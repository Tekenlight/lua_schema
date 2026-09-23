local ffi = require("ffi");
local date = require("date");
local xmlua = require("lua_schema.xmlua");
local xml_date_utils = xmlua.XMLDateUtils.new();
local nu = require("lua_schema.number_utils");

local error_handler = require("lua_schema.error_handler");



ffi.cdef [[

typedef struct o_dt_s {
	int type;
	char * value;
} o_dt_s_type, * dt_p_type;

/*
typedef struct dt_s {
	int type;
    int64_t day_num;
    int64_t day_frac;
    int32_t timezone;
    int has_timezone;
} dt_s_type, * n_dt_p_type;
*/

typedef struct _dur {
	char * value;
} dur_s_type, *dur_p_type;

void free(void *ptr);
char * strdup(const char *s1);

typedef struct {
    int64_t usec;
    int32_t day;
    int32_t mon;
} interval_s_type, *interval_p_type;

]]

local date_utils = {};

date_utils.MIN_TIME_ZONE = -840;
date_utils.MAX_TIME_ZONE = 840;
date_utils.TICKS_IN_14H = 14 * 60 * 60 * date.ticks();
date_utils.SECS_IN_14H = 14 * 60 * 60;
date_utils.tn_tid_map = {
	 ['date']       = xml_date_utils.value_type.XML_SCHEMAS_DATE
	,['time']       = xml_date_utils.value_type.XML_SCHEMAS_TIME
	,['dateTime']   = xml_date_utils.value_type.XML_SCHEMAS_DATETIME
	,['gYear']      = xml_date_utils.value_type.XML_SCHEMAS_GYEAR
	,['gYearMonth'] = xml_date_utils.value_type.XML_SCHEMAS_GYEARMONTH
	,['gMonth']     = xml_date_utils.value_type.XML_SCHEMAS_GMONTH
	,['gMonthDay']  = xml_date_utils.value_type.XML_SCHEMAS_GMONTHDAY
	,['gDay']       = xml_date_utils.value_type.XML_SCHEMAS_GDAY
};

date_utils.tid_fmt_map = {
	 [xml_date_utils.value_type.XML_SCHEMAS_DATE] = '%Y-%m-%d'
	,[xml_date_utils.value_type.XML_SCHEMAS_DATETIME] = '%Y-%m-%dT%H:%M:%\n'
	,[xml_date_utils.value_type.XML_SCHEMAS_TIME] = '%H:%M:%\n'
	,[xml_date_utils.value_type.XML_SCHEMAS_GYEAR] = '%Y'
	,[xml_date_utils.value_type.XML_SCHEMAS_GYEARMONTH] = '%Y-%m'
	,[xml_date_utils.value_type.XML_SCHEMAS_GMONTH] = '--%m'
	,[xml_date_utils.value_type.XML_SCHEMAS_GMONTHDAY] = '--%m-%d'
	,[xml_date_utils.value_type.XML_SCHEMAS_GDAY] = '---%d'
};

date_utils.tid_name_map = {
	 [xml_date_utils.value_type.XML_SCHEMAS_DATE] = 'date'
	,[xml_date_utils.value_type.XML_SCHEMAS_DATETIME] = 'dateTime'
	,[xml_date_utils.value_type.XML_SCHEMAS_TIME] = 'time'
	,[xml_date_utils.value_type.XML_SCHEMAS_GYEAR] = 'gYear'
	,[xml_date_utils.value_type.XML_SCHEMAS_GYEARMONTH] = 'gYearMonth'
	,[xml_date_utils.value_type.XML_SCHEMAS_GMONTH] = 'gMonth'
	,[xml_date_utils.value_type.XML_SCHEMAS_GMONTHDAY] = 'gMonthDay'
	,[xml_date_utils.value_type.XML_SCHEMAS_GDAY] = 'gDay'
};

date_utils.DAYRANGE = {
	 {0, 0}
	,{28, 31}
	,{59, 62}
	,{89, 92}
	,{120, 123}
	,{150, 153}
	,{181, 184}
	,{212, 215}
	,{242, 245}
	,{273, 276}
	,{303, 306}
	,{334, 337}
};

date_utils.time_from_dto = function(dto)
	local num = ffi.new("int64_t", 0);
	num = num + dto.dayfrc;
	return num;
end

date_utils.daynum_from_dto = function(dto)
	local num = ffi.new("int32_t", 0);
	num = num + dto.daynum;
	return num;
end

date_utils.num_from_dto = function(dto)
	local num = ffi.new("int64_t", 0);
	num = num + dto.daynum * 24 * 60 * 60 * date.ticks() + dto.dayfrc
	return num;
end

date_utils.dto_from_num = function(dt_num)
	--dt_num = nu.round(dt_num, 1);

	local d_day_frc = dt_num % (24 * 60 * 60 * date.ticks());
	--d_day_frc = nu.round(d_day_frc, 1000);
	d_day_frc = tonumber(d_day_frc);

	local d_day_num = (dt_num - d_day_frc) / (24 * 60 * 60 * date.ticks());
	--d_day_num = nu.round(d_day_num, 1);
	d_day_num = tonumber(d_day_num);

	return date.from_dnum_and_frac(d_day_num, d_day_frc);
end

--[[ OLD IMPLEMENTATION STARTS HERE ]]
date_utils.split_dtt = function(s)
	if (s == nil or type(s) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	local i,w = 0, nil;
	local str_day_num = nil;
	local str_day_frc = nil;
	local tzo = nil;

	for w in string.gmatch(s, '[^|]+') do
		if (i == 0) then
			str_day_num = w;
		elseif (i == 1) then
			str_day_frc = w;
		elseif (i == 2) then
			tzo = nu.round(tonumber(w), 1);
			if (tzo == nil) then
				error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
			end
		else
			error_handler.raise_fatal_error(-1, "Invalid date format in {"..s.."}", debug.getinfo(1));
		end
		i = i+1;
	end
	if (str_day_num == nil or str_day_frc == nil) then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end

	local day_num = tonumber(str_day_num);
	local day_frc = tonumber(str_day_frc);
	if (day_num == nil or day_frc == nil) then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	local dt = date.from_dnum_and_frac(day_num, day_frc)

	return dt, tzo;
end

date_utils.fast_split_dtt = function(s)

    local p1 = string.find(s, '|', 1, true);
    if p1 == nil then
        error_handler.raise_fatal_error(
            -1,
            "Invalid inputs",
            debug.getinfo(1)
        );
    end

    local p2 = string.find(s, '|', p1 + 1, true);

    local day_num;
    local day_frc;
    local tzo = nil;

    if p2 == nil then

        day_num = tonumber(string.sub(s, 1, p1 - 1));
        day_frc = tonumber(string.sub(s, p1 + 1));

    else

        day_num = tonumber(string.sub(s, 1, p1 - 1));
        day_frc = tonumber(string.sub(s, p1 + 1, p2 - 1));
        tzo = tonumber(string.sub(s, p2 + 1));

    end

    if day_num == nil or day_frc == nil then
        error_handler.raise_fatal_error(
            -1,
            "Invalid inputs",
            debug.getinfo(1)
        );
    end

    if tzo ~= nil then
        tzo = nu.round(tzo, 1);
    end

    local dt = date.from_dnum_and_frac(day_num, day_frc);

    return dt, tzo;
end

date_utils.is_valid_date = function(date_type_id, _s)
	local s = '';
	if (ffi.istype("char *", _s)) then
		s = ffi.string(_s);
	elseif (type(_s) == 'string') then
		s = _s;
	else
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	local status, dto, tzo = pcall(date_utils.split_dtt, s);
	return status;
end

date_utils.is_valid = function(cdt)
	if (not ffi.istype("o_dt_s_type", cdt)) then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	return date_utils.is_valid_date(cdt.type, cdt.value);
end

date_utils.is_valid_duration = function(inp)
	local s = '';
	if (ffi.istype("dur_s_type", inp)) then
		s = ffi.string(inp.value);
	else
		s = inp;
	end
	local status, dto, tzo = pcall(date_utils.split_dtt, s);
	return status;
end

date_utils.date_obj_from_dtt = function(s)
	if (ffi.istype("o_dt_s_type", s)) then
		s = ffi.string(s.value);
	end
	if (s == nil or type(s) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end

	local dto, tzo = date_utils.split_dtt(s);

	--local dto = date_utils.dto_from_num(dt_num);

	return dto, tzo;
end

date_utils.dtt_from_date_obj = function(dto, tzo)
	local ret = {};
	ret.num = nu.round(tonumber(date_utils.num_from_dto(dto)), 1);
	if (tzo ~= nil) then
		ret.tz = tzo;
		ret.str = dto.daynum..'|'..dto.dayfrc..'|'..ret.tz;
	else
		ret.tz = nil;
		ret.str = dto.daynum..'|'..dto.dayfrc;
	end
	return ret.str;
end

date_utils.add_tzoffset_to_dto = function(dto, tzo)
	local offset = -1 * 60 * tzo;
	dto:addseconds(offset);
	return dto;
end

date_utils.add_tzoffset_to_dn = function(dn, tzo)
	local offset = -1 * 60 * tzo * date.ticks();
	dn = dn + offset;
	return dn;
end

--[[
--This will return the string form of date
--]]
date_utils.dtt_from_xml_date_field = function(date_type_id, s)
	if (date_type_id == nil or type(date_type_id) ~= 'number') then
		error_handler.raise_fatal_error(-1, "Invalid inputs:"..debug.getinfo(1).currentline, debug.getinfo(1));
	elseif (s == nil or type(s) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs:"..debug.getinfo(1).currentline, debug.getinfo(1));
	end

	local d1 = xml_date_utils.str_to_date(date_type_id, s);
	if (d1 == nil) then
		local name = date_utils.tid_name_map[date_type_id];
		error_handler.raise_fatal_error(-1, "{"..s.."} not a valid "..name, debug.getinfo(1));
		return nil;
	end
	local ticks = (d1.mil_sec*1000);
	ticks = nu.round(ticks, 1000);
	if (d1.mon == 0) then
		d1.mon = 1
	end
	if (d1.day == 0) then
		d1.day = 1;
	end

	local dto = date(d1.year, d1.mon, d1.day, d1.hour, d1.min, d1.sec, ticks);

	local tzo = nil;
	if (d1.tz_flag) then
		tzo = nu.round(d1.tzo, 1);
	end

	if ((tzo ~= nil) and (tzo > date_utils.MAX_TIME_ZONE or tzo < date_utils.MIN_TIME_ZONE)) then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end

	return  date_utils.dtt_from_date_obj(dto, tzo);
end

date_utils.from_xml_date_field = function(date_type_id, s)
	local ret =  date_utils.dtt_from_xml_date_field(date_type_id, s);
	local cdt = ffi.new("o_dt_s_type", 0);
	cdt.type = date_type_id;
	cdt.value = ffi.C.strdup(ffi.cast("char*", ret));

	return cdt;
end

date_utils.get_tzo_in_h_m = function(tzo)
	local ptzo = math.abs(tzo);
	local h = math.floor(ptzo / 60);
	local m = math.floor(ptzo % 60);

	local h_str = '';
	if (tzo < 0) then h_str = '-'; else h_str = '+' end
	if (h == 0) then
		h_str = h_str..'00';
	elseif (h < 10) then
		h_str = h_str..'0'..h;
	else
		h_str = h_str..h;
	end

	local m_str = '';
	if (m == 0) then
		m_str = '00';
	elseif (m < 10) then
		m_str = m_str..'0'..m;
	else
		m_str = m_str..m;
	end
	return h_str..':'..m_str;
end

date_utils.append_tz = function(date_part, tzo)
	local ret = nil;
	if (tzo == nil) then
		ret = date_part;
	elseif (tzo == 0) then
		ret = date_part..'Z';
	elseif (tzo > 0) then
		ret = date_part..date_utils.get_tzo_in_h_m(tzo);
	else
		ret = date_part..date_utils.get_tzo_in_h_m(tzo);
	end
	return ret;
end

date_utils.to_xml_date_field = function(tid, _s)
	local s = '';
	if (ffi.istype("char *", _s)) then
		s = ffi.string(_s);
	elseif (type(_s) == 'string') then
		s = _s;
	else
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	local fmt = date_utils.tid_fmt_map[tid];
	local dto, tzo = date_utils.date_obj_from_dtt(s);

	local date_part = dto:fmt(fmt);

	return date_utils.append_tz(date_part, tzo);

end

date_utils.fast_to_xml_date_field = function(tid, _s)

    local s;

    if ffi.istype("char *", _s) then
        s = ffi.string(_s);
    elseif type(_s) == 'string' then
        s = _s;
    else
        error_handler.raise_fatal_error(
            -1,
            "Invalid inputs",
            debug.getinfo(1)
        );
    end

    local fmt = date_utils.tid_fmt_map[tid];

    local dto, tzo =
        date_utils.fast_split_dtt(s);

    local date_part = dto:fmt(fmt);

    return date_utils.append_tz(date_part, tzo);
end

date_utils.compare_dates_nn = function(dto1, dto2)
	--return (dto1 - dto2);
	if (dto1.daynum > dto2.daynum) then
		return 1;
	elseif (dto1.daynum < dto2.daynum) then
		return -1;
	else
		if (dto1.dayfrc > dto2.dayfrc) then
			return 1;
		elseif (dto1.dayfrc < dto2.dayfrc) then
			return -1;
		else
			return 0;
		end
	end
end

date_utils.compare_dates_both = function(dto1, dto2)
	local ret = date_utils.compare_dates_nn(dto1, dto2);
	if (ret > 0) then
		return 1;
	elseif (ret < 0) then
		return -1;
	else
		return 0;
	end
end

date_utils.compare_dates_either_or = function(dto1, dto2)
	local ret = (dto1 - dto2):spanseconds();
	if (nu.compare_num(ret,0) > 0) then
		local diff = (dto1 - dto2);
		if (nu.compare_num((diff:addseconds(-1*date_utils.SECS_IN_14H)):spanseconds(), 0) > 0) then
			return 1;
		else
			return 2;
		end
	elseif (nu.compare_num(ret,0) < 0) then
		local diff = (dto1 - dto2);
		--if ((ret + date_utils.SECS_IN_14H) < 0) then
		if (nu.compare_num((diff:addseconds(1*date_utils.SECS_IN_14H)):spanseconds(), 0) < 0) then
			return -1;
		else
			return 2;
		end
	else
		return 2;
	end
end

-- Both input dates are time zone adjusted.
date_utils.compare_dates_tz_tz = function(dto1, dto2)
	return date_utils.compare_dates_both(dto1, dto2);
end

-- dto1 is time zone adjusted and dto2 is not
date_utils.compare_dates_tz_ntz = function(dto1, dto2)
	return date_utils.compare_dates_either_or(dto1, dto2);
end

-- dto2 is time zone adjusted and dto1 is not
date_utils.compare_dates_ntz_tz = function(dto1, dto2)
	return date_utils.compare_dates_either_or(dto1, dto2);
end

-- Both dto1 and dto2 are not time zone adjusted
date_utils.compare_dates_ntz_ntz = function(dto1, dto2)
	return date_utils.compare_dates_both(dto1, dto2);
end

date_utils.compare_dates = function(cdt1, cdt2)
	local s1 = '';
	local s2 = '';
	if (not ffi.istype("o_dt_s_type", cdt1)) then
		if (type(cdt1) == 'string') then
			s1 = cdt1;
		else
			error_handler.raise_fatal_error(-1, "Invalid inputs first argument ["..  tostring(cdt1) .. "]", debug.getinfo(1));
		end
	else
		s1 = ffi.string(cdt1.value);
	end
	if (not ffi.istype("o_dt_s_type", cdt2)) then
		if (type(cdt2) == 'string') then
			s2 = cdt2;
		else
			error_handler.raise_fatal_error(-1, "Invalid inputs second argument [".. tostring(cdt2) .. "]", debug.getinfo(1));
		end
	else
		s2 = ffi.string(cdt2.value);
	end


	local dto1, tzo1 = date_utils.split_dtt(s1);
	if (tzo1 ~= nil) then dto1 = date_utils.add_tzoffset_to_dto(dto1, tzo1); end
	local dto2, tzo2 = date_utils.split_dtt(s2);
	if (tzo2 ~= nil) then dto2 = date_utils.add_tzoffset_to_dto(dto2, tzo2); end

	local ret = nil;
	if (tzo1 == nil and tzo2 == nil) then
		ret = date_utils.compare_dates_ntz_ntz(dto1, dto2)
	elseif (tzo1 == nil and tzo2 ~= nil) then
		ret = date_utils.compare_dates_ntz_tz(dto1, dto2)
	elseif (tzo1 ~= nil and tzo2 == nil) then
		ret = date_utils.compare_dates_tz_ntz(dto1, dto2)
	else
		ret = date_utils.compare_dates_tz_tz(dto1, dto2)
	end
	return ret;
end

date_utils.split_duration = function(inp)
	local s = '';
	if (ffi.istype("dur_s_type", inp)) then
		s = ffi.string(inp.value);
	else
		s = inp;
	end
	if (s == nil or type(s) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	local i,w = 0, nil;
	local str_mon_num, mon_num = nil, 0;
	local str_day_num, day_num = nil, 0;
	local str_sec_num, sec_num = nil, 0;

	for w in string.gmatch(s, '[^|]+') do
		if (i == 0) then
			str_mon_num = w;
			mon_num = tonumber(str_mon_num);
			if (mon_num == nil) then
				error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
			end
		elseif (i == 1) then
			str_day_num = w;
			day_num = tonumber(str_day_num);
			if (day_num == nil) then
				error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
			end
		elseif (i == 2) then
			str_sec_num = w;
			sec_num = tonumber(str_sec_num);
			if (sec_num == nil) then
				error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
			end
		else
			error_handler.raise_fatal_error(-1, "Invalid date format in {"..s.."}", debug.getinfo(1));
		end
		i = i+1;
	end
	local dur = { mon = mon_num, day = day_num, sec = sec_num };
	return dur;
end

local date_from_inp_dt = function(inp_dt)
	local dt = '';
	local dt_format = -1;
	if (ffi.istype("o_dt_s_type", inp_dt)) then
		dt = ffi.string(inp_dt.value);
		dt_format = inp_dt.type;
	else
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end

	if (dt == nil or type(dt) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end

	local dto, tzo = date_utils.split_dtt(dt);
	return dto, tzo, dt_format;
end

local function duration_from_inp_dur(inp_dur)
	local s_dur = '';
	local dur;
	if (ffi.istype("dur_s_type", inp_dur)) then
		s_dur = ffi.string(inp_dur.value);
		if (s_dur == nil or type(s_dur) ~= 'string') then
			error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
		end
		dur = date_utils.split_duration(s_dur);
	elseif (type(inp_dur) == 'table') then
		assert(inp_dur.mon == nil or type(inp_dur.mon) == 'number')
		assert(inp_dur.day == nil or type(inp_dur.day) == 'number')
		assert(inp_dur.sec == nil or type(inp_dur.sec) == 'number')
		dur = inp_dur;
		if (dur.mon == nil) then dur.mon = 0; end
		if (dur.day == nil) then dur.day = 0; end
		if (dur.sec == nil) then dur.sec = 0; end
	else
		s_dur = inp_dur;
		if (s_dur == nil or type(s_dur) ~= 'string') then
			error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
		end
		dur = date_utils.split_duration(s_dur);
	end

	return dur;
end

local get_julian_day = function(dto)
    local y, m, d = dto:getdate();
    if (m <= 2) then
        y = y - 1;
        m = m + 12;
    end
    local A = math.floor(y / 100);
    local B = 2 - A + math.floor(A / 4);
    local jd = math.floor(365.25 * (y + 4716)) + math.floor(30.6001 * (m + 1)) + d + B - 1524.5;
    local jdn = math.floor(jd + 0.5);

    return jd, jdn;

end

--[[
--Important
--]]
date_utils.get_date_components = function(inp_dt)
	local dto, tzo, dt_format = date_from_inp_dt(inp_dt);
    local jd, jdn = get_julian_day(dto);
    local y, m, d = dto:getdate();
    return {
        year = y,
        month = m,
        date = d,
        day = dto:getday(),
        weekday = dto:getweekday(),
        isoweekday = dto:getisoweekday(),
        hours = dto:gethours(),
        minutes = dto:getminutes(),
        seconds = dto:getseconds(),
        jd = jd,
        jdn = jdn,
    }
end

--[[
--Important
--]]
date_utils.date_diff = function(inp_dt1, inp_dt2)
	local dto1, tzo1, dt_format1 = date_from_inp_dt(inp_dt1);
	local dto2, tzo2, dt_format2 = date_from_inp_dt(inp_dt2);

	if (tzo1 ~= nil) then dto1 = date_utils.add_tzoffset_to_dto(dto1, tzo1); end
	if (tzo2 ~= nil) then dto2 = date_utils.add_tzoffset_to_dto(dto2, tzo2); end

	local loc = (dto1 - dto2);
	loc.sec = nu.round(loc.dayfrc/1000000, 1);

	if ((loc.daynum < 0) and (loc.sec > 0)) then
		loc.daynum = loc.daynum + 1;
		loc.sec = loc.sec - 24 * 3600;
	elseif ((loc.daynum > 0) and (loc.sec < 0)) then
		loc.daynum = loc.daynum - 1;
		loc.sec = loc.sec + 24 * 3600;
	end

	local diff = {day = loc.daynum, sec = loc.sec};

	return diff;
end

--[[
--Important meta method
--]]
date_utils.eq = function(inp_dt1, inp_dt2)
	local diff = date_utils.date_diff(inp_dt1, inp_dt2);
	if (diff.day ~= 0) then
		return false;
	elseif (diff.day == 0 and nu.compare_num(diff.sec, 0) == 0) then
		return true;
	else
		return false;
	end
end

--[[
--Important meta method
--]]
date_utils.lt = function(inp_dt1, inp_dt2)
	local diff = date_utils.date_diff(inp_dt1, inp_dt2);
	if (diff.day < 0) then
		return true;
	elseif (diff.day == 0 and nu.compare_num(diff.sec, 0) < 0) then
		return true;
	else
		return false;
	end
end

--[[
--Important meta method
--]]
date_utils.le = function(inp_dt1, inp_dt2)
	local diff = date_utils.date_diff(inp_dt1, inp_dt2);
	if (diff.day < 0) then
		return true;
	elseif (diff.day == 0 and nu.compare_num(diff.sec, 0) <= 0) then
		return true;
	else
		return false;
	end
end

--[[
--Important meta method
--]]
date_utils.gt = function(inp_dt1, inp_dt2)
	local diff = date_utils.date_diff(inp_dt1, inp_dt2);
	if (diff.day > 0) then
		return true;
	elseif (diff.day == 0 and nu.compare_num(diff.sec, 0) > 0) then
		return true;
	else
		return false;
	end
end

--[[
--Important meta method
--]]
date_utils.ge = function(inp_dt1, inp_dt2)
	local diff = date_utils.date_diff(inp_dt1, inp_dt2);
	if (diff.day > 0) then
		return true;
	elseif (diff.day == 0 and nu.compare_num(diff.sec, 0) >= 0) then
		return true;
	else
		return false;
	end
end

--[[
-- Important
-- Inputs:
--          date/dateTime in binary format
--          duration, a lua structure with three elements, mon, day and sec
--]]
date_utils.add_duration_to_date = function(inp_dt, inp_dur)
	local dto, tzo, dt_format = date_from_inp_dt(inp_dt);
	local dur = duration_from_inp_dur(inp_dur);;

	local o_dto = dto:copy();
	o_dto:addmonths(dur.mon);
	o_dto:adddays(dur.day);
	o_dto:addseconds(dur.sec);

	local ret = date_utils.dtt_from_date_obj(o_dto, tzo);
	local cdt = ffi.new("o_dt_s_type", 0);
	if (dt_format ~= -1) then
		cdt.type = dt_format;
	else
		cdt.type = 0;
	end
	cdt.value = ffi.C.strdup(ffi.cast("char*", ret));

	return cdt;
end

date_utils.subtract_duration_from_date = function(inp_dt, inp_dur)
	local dto, tzo, dt_format = date_from_inp_dt(inp_dt);
	local dur = duration_from_inp_dur(inp_dur);;

	local o_dto = dto:copy();
	o_dto:addmonths((-1 * dur.mon));
	o_dto:adddays((-1 *dur.day));
	o_dto:addseconds((-1 * dur.sec));

	local ret = date_utils.dtt_from_date_obj(o_dto, tzo);
	local cdt = ffi.new("o_dt_s_type", 0);
	if (dt_format ~= -1) then
		cdt.type = dt_format;
	else
		cdt.type = 0;
	end
	cdt.value = ffi.C.strdup(ffi.cast("char*", ret));

	return cdt;
end

date_utils.compare_durations = function(inp_dur1, inp_dur2)
	local s_dur1 = '';
	local s_dur2 = '';
	if (ffi.istype("dur_s_type", inp_dur1)) then
		s_dur1 = ffi.string(inp_dur1.value);
	else
		s_dur1 = inp_dur1;
	end
	if (ffi.istype("dur_s_type", inp_dur2)) then
		s_dur2 = ffi.string(inp_dur2.value);
	else
		s_dur2 = inp_dur2;
	end
	if (s_dur1 == nil or type(s_dur1) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	if (s_dur2 == nil or type(s_dur2) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	local dur1 = date_utils.split_duration(s_dur1);
	local dur2 = date_utils.split_duration(s_dur2);

	local invert = 1;
	local minday = nil
	local maxday = nil
	local xmon = nil;
	local xday = nil;
	local myear = nil;

	local months = dur1.mon - dur2.mon;
	local secs = dur1.sec - dur2.sec;
	local day_incr = math.floor(secs / (24*60*60));
	secs = (secs % (24*60*60));
	local days = dur1.day - dur2.day + day_incr;

	if (months == 0) then
		if (days == 0) then
			if (nu.compare_num(secs, 0) == 0) then
				return 0;
			elseif (nu.compare_num(secs, 0) < 0) then
				return -1;
			else
				return 1;
			end
		elseif (days < 0) then
			return -1;
		else
			return 1;
		end
	end

	if (months > 0) then
		if (days >=0 and (nu.compare_num(secs, 0) > 0)) then
			return 1;
		else
			xmon = months;
			xday = -1 * days;
		end
	elseif (days <=0 and (nu.compare_num(secs, 0) < 0)) then
		return -1;
	else
		invert = -1;
		xmon = -months;
		xday = days;
	end

	local myear = math.floor(xmon / 12);
	if (myear == 0) then
		minday = 0;
		maxday = 0;
	else
		maxday = 365 * myear + ((myear+3)/4);
		minday = maxday - 1;
	end

	xmon = xmon % 12;
	minday = minday + date_utils.DAYRANGE[xmon+1][1];
	maxday = maxday + date_utils.DAYRANGE[xmon+1][2];

	assert((maxday ~= nil) and (minday ~= nil) and (xday ~= nil));

	if ((maxday == minday) and (maxday == xday)) then
		return 0;
	end

	assert(invert ~= nil);
	if (maxday < xday) then
		return (-1 * invert);
	end

	if (minday > xday) then
		return invert;
	end

	return 2;

end

date_utils.str_from_dur = function(dur)
	local str = '';
	str = dur.mon..'|'..dur.day..'|'..dur.sec;
	return str;
end

date_utils.str_dur_from_xml_duration = function(s)
	if (s == nil or type(s) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	local x_dur = xml_date_utils.str_to_duration(s);
	if (x_dur == nil) then
		error_handler.raise_fatal_error(-1, "{"..s.."} not a valid duration", debug.getinfo(1));
		return nil
	end
	--require 'pl.pretty'.dump(x_dur);
	local dur = { mon = x_dur.mon, day = x_dur.day, sec = x_dur.sec } ;
	--require 'pl.pretty'.dump(dur);
	return date_utils.str_from_dur(dur);
end

date_utils.from_xml_duration = function(s)
	local str_dur = date_utils.str_dur_from_xml_duration(s);
	local cdur = ffi.new("dur_s_type");
	cdur.value = ffi.C.strdup(ffi.cast("char*", str_dur));
	return cdur;
end

date_utils.to_xml_duration = function(inp)
	local s = '';
	if (ffi.istype("dur_s_type", inp)) then
		s = ffi.string(inp.value);
	else
		s = inp;
	end
	if (s == nil or type(s) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	if (s == nil or type(s) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end

	local dur = date_utils.split_duration(s);
	local years = math.floor((dur.mon / 12));
	local months = math.floor((dur.mon % 12));
	local days = dur.day;
	local hours = math.floor((dur.sec / (60*60)));
	days = days + math.floor((hours / 24));
	hours = math.floor((hours % 24));
	local balance = (dur.sec % (60*60));
	local minutes = math.floor(balance / 60);
	local secs = (balance % 60);
	local fsecs = nu.round((secs % 1), 0.001);
	secs = math.floor(secs);
	if (nu.compare_num(fsecs, 0) ~= 0) then
		fsecs = nu.round(fsecs, 0.001);
		secs = secs + fsecs;
	end
	local s_dur = 'P'
	if (years ~= 0) then
		s_dur = s_dur .. years ..'Y';
	end
	if (months ~= 0) then
		s_dur = s_dur .. months ..'M';
	end
	if (days ~= 0) then
		s_dur = s_dur .. days ..'D';
	end
	local s_tur = 'T'
	if (hours ~= 0) then
		s_tur = s_tur .. hours ..'H';
	end
	if (minutes ~= 0) then
		s_tur = s_tur .. minutes ..'M';
	end
	if (secs ~= 0) then
		s_tur = s_tur .. secs ..'S';
	end
	if (s_tur ~= 'T') then
		s_dur = s_dur .. s_tur;
	end
	return s_dur;
end

date_utils.from_xml_date = function(s)
	return date_utils.from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATE, s);
end

date_utils.to_xml_date = function(s)
	return date_utils.to_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATE, s);
end

date_utils.from_xml_datetime = function(s)
	return date_utils.from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, s);
end

date_utils.to_xml_datetime = function(s)
	return date_utils.to_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, s);
end

date_utils.from_xml_time = function(s)
	return date_utils.from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_TIME, s);
end

date_utils.to_xml_time = function(s)
	return date_utils.to_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_TIME, s);
end

date_utils.dtt_from_long = function(n, t, tzo)
	local dto = date_utils.dto_from_num(n)
	local dtt = date_utils.dtt_from_date_obj(dto, tzo);
	local cdt = ffi.new("o_dt_s_type", 0);
	cdt.type = date_utils.tn_tid_map[t];
	cdt.value = ffi.C.strdup(ffi.cast("char*", dtt));
	return cdt;
end

date_utils.long_from_dtt = function(dtt)
	local dto, tzo = date_utils.date_obj_from_dtt(dtt)
	local n = date_utils.num_from_dto(dto);
	return n, tzo;
end

date_utils.dtt_from_daynum = function(n, t, tzo)
	local dto = date.from_dnum_and_frac(tonumber(n), 0);
	local dtt = date_utils.dtt_from_date_obj(dto, tzo);
	local cdt = ffi.new("o_dt_s_type", 0);
	cdt.type = date_utils.tn_tid_map[t];
	cdt.value = ffi.C.strdup(ffi.cast("char*", dtt));
	return cdt;
end

date_utils.daynum_from_dtt = function(dtt)
	local dto, tzo = date_utils.date_obj_from_dtt(dtt)
	local n = date_utils.daynum_from_dto(dto);
	return n, tzo;
end

date_utils.dtt_from_time = function(n, t, tzo)
	local dto = date.from_dnum_and_frac(0, tonumber(n));
	local dtt = date_utils.dtt_from_date_obj(dto, tzo);
	local cdt = ffi.new("o_dt_s_type", 0);
	cdt.type = date_utils.tn_tid_map[t];
	cdt.value = ffi.C.strdup(ffi.cast("char*", dtt));
	return cdt;
end

date_utils.cdt_from_dto = function(dto, format, tzo)
	assert(type(dto) == 'table');
	assert(type(format) == 'string');
	assert(date_utils.tn_tid_map[format] ~= nil);
	assert(tzo == nil or type(tzo) == 'number');

	local dtt = date_utils.dtt_from_date_obj(dto, tzo);
	local cdt = ffi.new("o_dt_s_type", 0);
	cdt.type = date_utils.tn_tid_map[format];
	cdt.value = ffi.C.strdup(ffi.cast("char*", dtt));
	return cdt;
end

date_utils.date_time_from_dto = function (dto, tzo)
	if ((tzo ~= nil) and (tzo > date_utils.MAX_TIME_ZONE or tzo < date_utils.MIN_TIME_ZONE)) then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end

	return  date_utils.cdt_from_dto(dto, 'dateTime', tzo);
end

date_utils.convert_format = function(cdt, desired_format)
	assert(type(cdt) == 'cdata');
	assert(ffi.istype("o_dt_s_type", cdt));
	assert(desired_format == 'date' or desired_format == 'dateTime');

	local dto, tzo = date_utils.date_obj_from_dtt(cdt);
	return date_utils.cdt_from_dto(dto, desired_format, tzo);
end

date_utils.time_from_dtt = function(dtt)
	local dto, tzo = date_utils.date_obj_from_dtt(dtt)
	local n = date_utils.time_from_dto(dto);
	return n, tzo;
end

date_utils.dur_from_bin = function(bin)
	local dur = { mon = tonumber(bin.mon), day = tonumber(bin.day), sec = tonumber(bin.usec)/1000000 } ;
	local str_dur = date_utils.str_from_dur(dur);
	local cdur = ffi.new("dur_s_type");
	cdur.value = ffi.C.strdup(ffi.cast("char*", str_dur));
	return cdur;
end

date_utils.bin_from_dur = function(s_dur)
	local dur = date_utils.split_duration(s_dur)
	local bin_dur = ffi.new("interval_s_type", 0);
	bin_dur.day = dur.day;
	bin_dur.mon = dur.mon;
	bin_dur.usec = dur.sec * 1000000;
	return bin_dur;
end

date_utils.to_xml_format = function(cdt)
	if (not ffi.istype("o_dt_s_type", cdt)) then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	local dt = cdt.type;
	return date_utils.to_xml_date_field(dt, cdt.value);
end

date_utils.fast_to_xml_format = function(cdt)

    if not ffi.istype("o_dt_s_type", cdt) then
        error_handler.raise_fatal_error(
            -1,
            "Invalid inputs",
            debug.getinfo(1)
        );
    end

    return date_utils.fast_to_xml_date_field(
        cdt.type,
        cdt.value
    );
end

date_utils.free_cdt = function(cdt)
	ffi.C.free(cdt.value);
end

date_utils.free_cdur = function(cdur)
	ffi.C.free(cdur.value);
end

date_utils.now = function(utc)
	if (utc ~= nil and type(utc) ~= 'boolean') then
		error("Invalid inputs");
	end
	local p = require('posix.sys.time');
	local t = p.gettimeofday();
	local dt = date(t.tv_sec+t.tv_usec/1000000);
	dt.dayfrc = nu.round(dt.dayfrc, 1);
	local dtt;
	if (utc == false) then
		local tzb = date(true):getbias();
		date_utils.add_tzoffset_to_dto(dt, tzb);
		local tzs = tostring(-1*tzb);
		dtt = date_utils.dtt_from_date_obj(dt, tzs);
	elseif (utc == true) then
		dtt =  date_utils.dtt_from_date_obj(dt, "0");
	else
		local tzb = date(true):getbias();
		date_utils.add_tzoffset_to_dto(dt, tzb);
		dtt =  date_utils.dtt_from_date_obj(dt, nil);
	end
	local cdt = ffi.new("o_dt_s_type", 0);
	cdt.type = date_utils.tn_tid_map['dateTime'];
	cdt.value = ffi.C.strdup(ffi.cast("char*", dtt));
	return cdt;
end

date_utils.set_tz = function(cdt, tzo)
	if (not ffi.istype("o_dt_s_type", cdt)) then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	assert(tzo ~= nil and type(tzo) == 'number');
	local dto, tzo_2 = date_utils.date_obj_from_dtt(cdt);
	local dtt = date_utils.dtt_from_date_obj(dto, nu.round(tzo, 1));

	--[[
	local o_cdt = ffi.new("o_dt_s_type", 0);
	o_cdt.type = cdt.type;
	o_cdt.value = ffi.C.strdup(ffi.cast("char*", dtt));
	return o_cdt;
	--]]

	ffi.C.free(cdt.value);
	cdt.value = ffi.C.strdup(ffi.cast("char*", dtt));

	return cdt;
end

date_utils.today = function(utc)
	if (utc ~= nil and type(utc) ~= 'boolean') then
		error("Invalid inputs");
	end
	local today = os.date("*t");
	local dt = date(today.year, today.month, today.day)
	dt.dayfrc = nu.round(dt.dayfrc, 1);
	local dtt;
	if (utc == false) then
		local tzb = date(false):getbias();
		date_utils.add_tzoffset_to_dto(dt, tzb);
		dt.dayfrc = 0;
		local tzs = tostring(-1*tzb);
		dtt = date_utils.dtt_from_date_obj(dt, tzs);
	elseif (utc == true) then
		dtt =  date_utils.dtt_from_date_obj(dt, "0");
	else
		local tzb = date(false):getbias();
		date_utils.add_tzoffset_to_dto(dt, tzb);
		dtt =  date_utils.dtt_from_date_obj(dt, nil);
	end
	local cdt = ffi.new("o_dt_s_type", 0);
	cdt.type = date_utils.tn_tid_map['date'];
	cdt.value = ffi.C.strdup(ffi.cast("char*", dtt));
	return cdt;
end

date_utils.date_obj_from_cdt = function(_s)
	local s = '';
	if (ffi.istype("char *", _s)) then
		s = ffi.string(_s);
    elseif (ffi.istype("o_dt_s_type", _s)) then
		s = _s;
	elseif (type(_s) == 'string') then
		s = _s;
	else
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end

	local dto, tzo = date_utils.date_obj_from_dtt(s);

    return dto, tzo;
end

date_utils.get_utc_date_time = function(cdt)
    local dto, tzo = date_utils.date_obj_from_cdt(cdt);
    if (tzo ~= nil) then
        dto = date_utils.add_tzoffset_to_dto(dto, tzo);
    end

    return date_utils.date_time_from_dto(dto, 0);
end

--TS - 0

--[[
print(debug.getinfo(1).source, debug.getinfo(1).currentline, date_utils.now(true));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, date(true));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, date_utils.now(false));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, date(false));


local dt = date_utils.from_xml_date("1973-04-26");
print(debug.getinfo(1).source, debug.getinfo(1).currentline, dt);
local dto = date_utils.split_dtt(ffi.string(dt.value));
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(dto);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
--]]

-- TS - 1
--[[
local t = date_utils.dtt_from_long(ffi.new("long", 27000001000), 'time', nil)
print(debug.getinfo(1).source, debug.getinfo(1).currentline, 27000001000);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, t);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, date_utils.long_from_dtt(t));

local dt = date_utils.dtt_from_long(ffi.new("long", 62240254200001000), 'dateTime', nil)
print(debug.getinfo(1).source, debug.getinfo(1).currentline, dt);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, 62240254200001000);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, dt);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, date_utils.long_from_dtt(dt));

local d = date_utils.dtt_from_long(ffi.new("long", 62240227200000000), 'date', nil)
print(debug.getinfo(1).source, debug.getinfo(1).currentline, d);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, 62240227200000000);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, d);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, date_utils.long_from_dtt(d));
--]]


--[[
-- TS - 2
local s_dur = 'P1Y1M1DT1H1M45S';
local dur = date_utils.from_xml_duration(s_dur);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, dur, ffi.string(dur.value));

local s_dur = 'P1Y'
local dur = date_utils.from_xml_duration(s_dur);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, dur);
local dt1 = date_utils.from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "1973-04-26T07:30:00.001+05:30");
print(debug.getinfo(1).source, debug.getinfo(1).currentline, dt1);

local o = date_utils.add_duration_to_date(dt1, dur);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, o);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, dur);

local dt1 = date_utils.from_xml_datetime("1973-04-26T07:30:00.001Z");
print(debug.getinfo(1).source, debug.getinfo(1).currentline, dt1);

local dt2 = date_utils.from_xml_date("1973-04-26");
print(debug.getinfo(1).source, debug.getinfo(1).currentline, dt2);

local dt1 = date_utils.from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "1973-04-26T07:30:00.002Z");
local dt2 = date_utils.from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "1973-04-26T07:30:00.002Z");

print(debug.getinfo(1).source, debug.getinfo(1).currentline, date_utils.compare_dates(dt1, dt2));

local d = date.from_dnum_and_frac(0, 0)
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(d);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, d, d:spandays());

--local s_dur = 'P2Y6M5DT12H35M30S';
local s_dur = 'P1Y'
local dur = date_utils.from_xml_duration(s_dur);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, dur);
local dt1 = date_utils.from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "1973-04-26T07:30:00.001+05:30");
print(debug.getinfo(1).source, debug.getinfo(1).currentline, dt1);

local o = date_utils.add_duration_to_date(dt1, dur);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, tostring(o));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, tostring(dur));

s_dur = 'P2Y6M5DT12H35M30.123S';
dur = date_utils.from_xml_duration(s_dur);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, s_dur);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, date_utils.to_xml_duration(dur));

local D1 = 'P1Y1DT1M';
local D2 = 'P1Y1DT1S';
local dur1 = date_utils.from_xml_duration(D1);
local dur2 = date_utils.from_xml_duration(D2);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, date_utils.compare_durations(dur1, dur2));
--]]

--[[
--TS - 3

print(debug.getinfo(1).source, debug.getinfo(1).currentline, date_utils.today(true));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, date(true));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, date_utils.today(false));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, date(false));
--]]

--[[ NEW IMPLEMENTATION STARTS HERE ]]
date_utils.n_split_dtt = function(cdt)
    assert(ffi.istype("dt_s_type", cdt));

    local dto = date.from_dnum_and_frac(tonumber(cdt.day_num), tonumber(cdt.day_frac));

    local tzo = nil;

    if (cdt.has_timezone ~= 0) then
        tzo = tonumber(cdt.timezone);
    end

	return dto, tzo;
end

date_utils.n_is_valid_date = function(date_type_id, cdt)
    assert(ffi.istype("dt_s_type", cdt));

	local status, dto, tzo = pcall(date_utils.n_split_dtt, cdt);

	return status;
end

date_utils.n_is_valid = function(cdt)
    assert(ffi.istype("dt_s_type", cdt));

	return date_utils.n_is_valid_date(cdt.type, cdt);
end

date_utils.n_is_valid_duration = function(inp)
	local s = '';
	if (ffi.istype("dur_s_type", inp)) then
		s = ffi.string(inp.value);
	else
		s = inp;
	end
	local status, dto, tzo = pcall(date_utils.split_dtt, s);
	return status;
end

date_utils.n_date_obj_from_dtt = date_utils.n_split_dtt;

date_utils.n_dtt_from_date_obj = function(dto, tzo)
    local cdt = ffi.new("dt_s_type");

    cdt.day_num = ffi.cast("int64_t", dto.daynum);
    cdt.day_frac = ffi.cast("int64_t", dto.dayfrc);

    if (tzo ~= nil) then
        cdt.timezone = tzo;
        cdt.has_timezone = 1;
    else
        cdt.timezone = 0;
        cdt.has_timezone = 0;
    end

    return cdt;
end

--[[
--This will return the cdt dt_s_type form of date
--]]
date_utils.n_o_dtt_from_xml_date_field = function(date_type_id, s)
    if (date_type_id == nil or type(date_type_id) ~= 'number') then
        error_handler.raise_fatal_error(-1, "Invalid inputs:"..debug.getinfo(1).currentline, debug.getinfo(1));
    elseif (s == nil or type(s) ~= 'string') then
        error_handler.raise_fatal_error(-1, "Invalid inputs:"..debug.getinfo(1).currentline, debug.getinfo(1));
    end

    local d1 = xml_date_utils.str_to_date(date_type_id, s);
    if (d1 == nil) then
        local name = date_utils.tid_name_map[date_type_id];
        error_handler.raise_fatal_error(-1, "{"..s.."} not a valid "..name, debug.getinfo(1));
        return nil;
    end
    local ticks = (d1.mil_sec * 1000);
    ticks = nu.round(ticks, 1000);
    if (d1.mon == 0) then
        d1.mon = 1;
    end
    if (d1.day == 0) then
        d1.day = 1;
    end
    local dto = date(d1.year, d1.mon, d1.day, d1.hour, d1.min, d1.sec, ticks);
    local tzo = nil;
    if (d1.tz_flag) then
        tzo = nu.round(d1.tzo, 1);
    end
    if ((tzo ~= nil) and (tzo > date_utils.MAX_TIME_ZONE or tzo < date_utils.MIN_TIME_ZONE)) then
        error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
    end
    local cdt = date_utils.n_dtt_from_date_obj(dto, tzo);
    cdt.type = date_type_id;
    return cdt;
end
date_utils.n_dtt_from_xml_date_field = function(date_type_id, s)
    if (date_type_id == nil or type(date_type_id) ~= 'number') then
        error_handler.raise_fatal_error(-1, "Invalid inputs:"..debug.getinfo(1).currentline, debug.getinfo(1));
    elseif (s == nil or type(s) ~= 'string') then
        error_handler.raise_fatal_error(-1, "Invalid inputs:"..debug.getinfo(1).currentline, debug.getinfo(1));
    end

    --[[
    local d1 = xml_date_utils.str_to_date(date_type_id, s);
    if (d1 == nil) then
        local name = date_utils.tid_name_map[date_type_id];
        error_handler.raise_fatal_error(-1, "{"..s.."} not a valid "..name, debug.getinfo(1));
        return nil;
    end
    local ticks = (d1.mil_sec * 1000);
    ticks = nu.round(ticks, 1000);
    if (d1.mon == 0) then
        d1.mon = 1;
    end
    if (d1.day == 0) then
        d1.day = 1;
    end
    local dto = date(d1.year, d1.mon, d1.day, d1.hour, d1.min, d1.sec, ticks);
    local tzo = nil;
    if (d1.tz_flag) then
        tzo = nu.round(d1.tzo, 1);
    end
    if ((tzo ~= nil) and (tzo > date_utils.MAX_TIME_ZONE or tzo < date_utils.MIN_TIME_ZONE)) then
        error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
    end
    local cdt = date_utils.n_dtt_from_date_obj(dto, tzo);
    cdt.type = date_type_id;
    return cdt;
    ]]
    local cdt = xml_date_utils.str_to_dtt(date_type_id, s);

    if (cdt == nil) then
        error("Invalid date");
    end

    return cdt;
end

date_utils.n_from_xml_date_field = date_utils.n_dtt_from_xml_date_field;

date_utils.n_o_to_xml_date_field = function(tid, cdt)
    assert(ffi.istype("dt_s_type", cdt));

	local fmt = date_utils.tid_fmt_map[tid];
	local dto, tzo = date_utils.n_date_obj_from_dtt(cdt);

	local date_part = dto:fmt(fmt);

	return date_utils.append_tz(date_part, tzo);
end

date_utils.n_to_xml_date_field = function(tid, cdt)
    assert(ffi.istype("dt_s_type", cdt));
    assert(tid == cdt.type);

    return xml_date_utils.dtt_to_str(cdt);
end

date_utils.n_compare_dates = function(cdt1, cdt2)
    assert(ffi.istype("dt_s_type", cdt1));
    assert(ffi.istype("dt_s_type", cdt2));

    local dto1, tzo1 = date_utils.n_date_obj_from_dtt(cdt1);
    if (tzo1 ~= nil) then
        dto1 = date_utils.add_tzoffset_to_dto(dto1, tzo1);
    end

    local dto2, tzo2 = date_utils.n_date_obj_from_dtt(cdt2);
    if (tzo2 ~= nil) then
        dto2 = date_utils.add_tzoffset_to_dto(dto2, tzo2);
    end

    local ret = nil;
    if (tzo1 == nil and tzo2 == nil) then
        ret = date_utils.compare_dates_ntz_ntz(dto1, dto2);
    elseif (tzo1 == nil and tzo2 ~= nil) then
        ret = date_utils.compare_dates_ntz_tz(dto1, dto2);
    elseif (tzo1 ~= nil and tzo2 == nil) then
        ret = date_utils.compare_dates_tz_ntz(dto1, dto2);
    else
        ret = date_utils.compare_dates_tz_tz(dto1, dto2);
    end

    return ret;
end

local n_date_from_inp_dt = function(inp_dt)
    assert(ffi.istype("dt_s_type", inp_dt));

    local dto, tzo = date_utils.n_date_obj_from_dtt(inp_dt);

    return dto, tzo, inp_dt.type;

end

--[[
--Important
--]]
date_utils.n_get_date_components = function(inp_dt)
	local dto, tzo, dt_format = n_date_from_inp_dt(inp_dt);
    local jd, jdn = get_julian_day(dto);
    local y, m, d = dto:getdate();
    return {
        year = y,
        month = m,
        date = d,
        day = dto:getday(),
        weekday = dto:getweekday(),
        isoweekday = dto:getisoweekday(),
        hours = dto:gethours(),
        minutes = dto:getminutes(),
        seconds = dto:getseconds(),
        jd = jd,
        jdn = jdn,
    }
end

--[[
--Important
--]]
date_utils.n_date_diff = function(inp_dt1, inp_dt2)
	local dto1, tzo1, dt_format1 = n_date_from_inp_dt(inp_dt1);
	local dto2, tzo2, dt_format2 = n_date_from_inp_dt(inp_dt2);

	if (tzo1 ~= nil) then dto1 = date_utils.add_tzoffset_to_dto(dto1, tzo1); end
	if (tzo2 ~= nil) then dto2 = date_utils.add_tzoffset_to_dto(dto2, tzo2); end

	local loc = (dto1 - dto2);
	loc.sec = nu.round(loc.dayfrc/1000000, 1);

	if ((loc.daynum < 0) and (loc.sec > 0)) then
		loc.daynum = loc.daynum + 1;
		loc.sec = loc.sec - 24 * 3600;
	elseif ((loc.daynum > 0) and (loc.sec < 0)) then
		loc.daynum = loc.daynum - 1;
		loc.sec = loc.sec + 24 * 3600;
	end

	local diff = {day = loc.daynum, sec = loc.sec};

	return diff;
end

--[[
--Important meta method
--]]
date_utils.n_eq = function(inp_dt1, inp_dt2)
	local diff = date_utils.n_date_diff(inp_dt1, inp_dt2);
	if (diff.day ~= 0) then
		return false;
	elseif (diff.day == 0 and nu.compare_num(diff.sec, 0) == 0) then
		return true;
	else
		return false;
	end
end

--[[
--Important meta method
--]]
date_utils.n_lt = function(inp_dt1, inp_dt2)
	local diff = date_utils.n_date_diff(inp_dt1, inp_dt2);
	if (diff.day < 0) then
		return true;
	elseif (diff.day == 0 and nu.compare_num(diff.sec, 0) < 0) then
		return true;
	else
		return false;
	end
end

--[[
--Important meta method
--]]
date_utils.n_le = function(inp_dt1, inp_dt2)
	local diff = date_utils.n_date_diff(inp_dt1, inp_dt2);
	if (diff.day < 0) then
		return true;
	elseif (diff.day == 0 and nu.compare_num(diff.sec, 0) <= 0) then
		return true;
	else
		return false;
	end
end

--[[
--Important meta method
--]]
date_utils.n_gt = function(inp_dt1, inp_dt2)
	local diff = date_utils.n_date_diff(inp_dt1, inp_dt2);
	if (diff.day > 0) then
		return true;
	elseif (diff.day == 0 and nu.compare_num(diff.sec, 0) > 0) then
		return true;
	else
		return false;
	end
end

--[[
--Important meta method
--]]
date_utils.n_ge = function(inp_dt1, inp_dt2)
	local diff = date_utils.n_date_diff(inp_dt1, inp_dt2);
	if (diff.day > 0) then
		return true;
	elseif (diff.day == 0 and nu.compare_num(diff.sec, 0) >= 0) then
		return true;
	else
		return false;
	end
end

--[[
-- Important
-- Inputs:
--          date/dateTime in binary format
--          duration, a lua structure with three elements, mon, day and sec
--]]
date_utils.n_add_duration_to_date = function(inp_dt, inp_dur)
    local dto, tzo, dt_format = n_date_from_inp_dt(inp_dt);
    local dur = duration_from_inp_dur(inp_dur);

    local o_dto = dto:copy();
    o_dto:addmonths(dur.mon);
    o_dto:adddays(dur.day);
    o_dto:addseconds(dur.sec);

    local cdt = date_utils.n_dtt_from_date_obj(o_dto, tzo);
    cdt.type = dt_format;

    return cdt;
end

date_utils.n_subtract_duration_from_date = function(inp_dt, inp_dur)
	local dto, tzo, dt_format = n_date_from_inp_dt(inp_dt);
	local dur = duration_from_inp_dur(inp_dur);;

	local o_dto = dto:copy();
	o_dto:addmonths((-1 * dur.mon));
	o_dto:adddays((-1 *dur.day));
	o_dto:addseconds((-1 * dur.sec));

    local cdt = date_utils.n_dtt_from_date_obj(o_dto, tzo);
    cdt.type = dt_format;

	return cdt;
end

date_utils.n_from_xml_date = function(s)
	return date_utils.n_from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATE, s);
end

date_utils.n_to_xml_date = function(s)
	return date_utils.n_to_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATE, s);
end

date_utils.n_from_xml_datetime = function(s)
	return date_utils.n_from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, s);
end

date_utils.n_to_xml_datetime = function(s)
	return date_utils.n_to_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, s);
end

date_utils.n_from_xml_time = function(s)
	return date_utils.n_from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_TIME, s);
end

date_utils.n_to_xml_time = function(s)
	return date_utils.n_to_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_TIME, s);
end

date_utils.n_dtt_from_long = function(n, t, tzo)
	local dto = date_utils.dto_from_num(n)
	local cdt = date_utils.n_dtt_from_date_obj(dto, tzo);
	cdt.type = date_utils.tn_tid_map[t];

	return cdt;
end

date_utils.n_long_from_dtt = function(dtt)
    local dto, tzo = date_utils.n_date_obj_from_dtt(dtt)
    local n = date_utils.num_from_dto(dto);
    return n, tzo;
end

date_utils.n_dtt_from_daynum = function(n, t, tzo)
    local dto = date.from_dnum_and_frac(tonumber(n), 0);
    local cdt = date_utils.n_dtt_from_date_obj(dto, tzo);
    cdt.type = date_utils.tn_tid_map[t];
    return cdt;
end

date_utils.n_daynum_from_dtt = function(dtt)
    local dto, tzo = date_utils.n_date_obj_from_dtt(dtt)
    local n = date_utils.daynum_from_dto(dto);
    return n, tzo;
end

date_utils.n_dtt_from_time = function(n, t, tzo)
    local dto = date.from_dnum_and_frac(0, tonumber(n));
    local cdt = date_utils.n_dtt_from_date_obj(dto, tzo);
    cdt.type = date_utils.tn_tid_map[t];
    return cdt;
end

date_utils.n_dtt_from_time = function(n, t, tzo)
	local dto = date.from_dnum_and_frac(0, tonumber(n));
	local cdt = date_utils.n_dtt_from_date_obj(dto, tzo);
	cdt.type = date_utils.tn_tid_map[t];
	return cdt;
end

date_utils.n_cdt_from_dto = function(dto, format, tzo)
	assert(type(dto) == 'table');
	assert(type(format) == 'string');
	assert(date_utils.tn_tid_map[format] ~= nil);
	assert(tzo == nil or type(tzo) == 'number');

	local cdt = date_utils.n_dtt_from_date_obj(dto, tzo);
	cdt.type = date_utils.tn_tid_map[format];
	return cdt;
end

date_utils.n_date_time_from_dto = function (dto, tzo)
	if ((tzo ~= nil) and (tzo > date_utils.MAX_TIME_ZONE or tzo < date_utils.MIN_TIME_ZONE)) then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end

	return  date_utils.n_cdt_from_dto(dto, 'dateTime', tzo);
end

date_utils.n_convert_format = function(cdt, desired_format)
    assert(type(cdt) == 'cdata');
    assert(ffi.istype("dt_s_type", cdt));
    assert(desired_format == 'date' or desired_format == 'dateTime');

    local dto, tzo = date_utils.n_date_obj_from_dtt(cdt);
    return date_utils.n_cdt_from_dto(dto, desired_format, tzo);
end

date_utils.n_time_from_dtt = function(dtt)
	local dto, tzo = date_utils.n_date_obj_from_dtt(dtt)
	local n = date_utils.time_from_dto(dto);
	return n, tzo;
end

date_utils.n_to_xml_format = function(cdt)
    if (not ffi.istype("dt_s_type", cdt)) then
        error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
    end
    local dt = cdt.type;
    return date_utils.n_to_xml_date_field(dt, cdt);
end

date_utils.n_free_cdt = function(cdt)
end

date_utils.n_now = function(utc)
	if (utc ~= nil and type(utc) ~= 'boolean') then
		error("Invalid inputs");
	end
	local p = require('posix.sys.time');
	local t = p.gettimeofday();
	local dt = date(t.tv_sec+t.tv_usec/1000000);
	dt.dayfrc = nu.round(dt.dayfrc, 1);
	local cdt;
	if (utc == false) then
		local tzb = date(true):getbias();
		date_utils.add_tzoffset_to_dto(dt, tzb);
		cdt = date_utils.n_dtt_from_date_obj(dt, -1*tzb);
	elseif (utc == true) then
		cdt =  date_utils.n_dtt_from_date_obj(dt, 0);
	else
		local tzb = date(true):getbias();
		date_utils.add_tzoffset_to_dto(dt, tzb);
		cdt =  date_utils.n_dtt_from_date_obj(dt, nil);
	end
	cdt.type = date_utils.tn_tid_map['dateTime'];
	return cdt;
end

date_utils.n_set_tz = function(cdt, tzo)
    if (not ffi.istype("dt_s_type", cdt)) then
        error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
    end
    assert(tzo ~= nil and type(tzo) == 'number');

    cdt.timezone = ffi.cast("int32_t", nu.round(tzo, 1));
    cdt.has_timezone = 1;

    return cdt;
end

date_utils.n_today = function(utc)
	if (utc ~= nil and type(utc) ~= 'boolean') then
		error("Invalid inputs");
	end

	local today = os.date("*t");
	local dt = date(today.year, today.month, today.day)
	dt.dayfrc = nu.round(dt.dayfrc, 1);

	local cdt;
	if (utc == false) then
		local tzb = date(false):getbias();
		date_utils.add_tzoffset_to_dto(dt, tzb);
		dt.dayfrc = 0;
		cdt = date_utils.n_dtt_from_date_obj(dt, -1*tzb);
	elseif (utc == true) then
		cdt =  date_utils.n_dtt_from_date_obj(dt, 0);
	else
		local tzb = date(false):getbias();
		date_utils.add_tzoffset_to_dto(dt, tzb);
		cdt =  date_utils.n_dtt_from_date_obj(dt, nil);
	end
	cdt.type = date_utils.tn_tid_map['date'];
	return cdt;
end

date_utils.n_date_obj_from_cdt = function(cdt)
    assert(ffi.istype("dt_s_type", cdt));

	local dto, tzo = date_utils.n_date_obj_from_dtt(cdt);

    return dto, tzo;
end

date_utils.n_get_utc_date_time = function(cdt)
    local dto, tzo = date_utils.n_date_obj_from_cdt(cdt);
    if (tzo ~= nil) then
        dto = date_utils.add_tzoffset_to_dto(dto, tzo);
    end

    return date_utils.n_date_time_from_dto(dto, 0);
end








------CODEEND------








--[[ migration test
local function migration_test(date_type_id, value)

    local old = date_utils.from_xml_date_field(date_type_id, value);

    local new = date_utils.n_from_xml_date_field(date_type_id, value);

    local old_dto, old_tzo = date_utils.date_obj_from_dtt(old);

    local new_dto, new_tzo = date_utils.n_date_obj_from_dtt(new);

    assert(old_dto.daynum == new_dto.daynum, "daynum mismatch: "..value);
    assert(old_dto.dayfrc == new_dto.dayfrc, "dayfrc mismatch: "..value);
    assert(old_tzo == new_tzo, "timezone mismatch: "..value);

    local old_xml = date_utils.to_xml_date_field(date_type_id, old.value);

    local new_xml = date_utils.n_to_xml_date_field(date_type_id, new);

    assert(old_xml == new_xml, "XML output mismatch: old={" ..  tostring(old_xml) ..  "} new={" ..
            tostring(new_xml) ..  "} input={" ..  value ..  "}");
end

local function compare_dates_migration_test(date_type_id, value1, value2)
    local old1 = date_utils.from_xml_date_field(date_type_id, value1);

    local old2 = date_utils.from_xml_date_field(date_type_id, value2);

    local new1 = date_utils.n_from_xml_date_field(date_type_id, value1);

    local new2 = date_utils.n_from_xml_date_field(date_type_id, value2);

    local old_ret = date_utils.compare_dates(old1, old2);

    local new_ret = date_utils.n_compare_dates(new1, new2);

    assert(old_ret == new_ret, "compare_dates mismatch: {" ..  value1 ..  "} vs {" ..
            value2 ..  "} old={" ..  tostring(old_ret) ..  "} new={" ..  tostring(new_ret) ..  "}");

end

local function date_from_inp_dt_migration_test(date_type_id, value)

    local old = date_utils.from_xml_date_field(date_type_id, value);

    local new = date_utils.n_from_xml_date_field(date_type_id, value);

    local old_dto, old_tzo, old_type = date_from_inp_dt(old);

    local new_dto, new_tzo, new_type = n_date_from_inp_dt(new);

    assert(old_dto.daynum == new_dto.daynum);
    assert(old_dto.dayfrc == new_dto.dayfrc);
    assert(old_tzo == new_tzo);
    assert(old_type == new_type);

end

local function assert_same_dtt(old, new)

    local old_dto, old_tzo = date_utils.date_obj_from_dtt(old);
    local new_dto, new_tzo = date_utils.n_date_obj_from_dtt(new);

    assert(old_dto.daynum == new_dto.daynum);
    assert(old_dto.dayfrc == new_dto.dayfrc);
    assert(old_tzo == new_tzo);
    assert(old.type == new.type);
end

local xmlua = require("lua_schema.xmlua");
local xml_date_utils = xmlua.XMLDateUtils.new();

date_from_inp_dt_migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATE, '1973-04-26');
date_from_inp_dt_migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T07:30:00');
date_from_inp_dt_migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T07:30:00Z');
date_from_inp_dt_migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T07:30:00-01:00');
date_from_inp_dt_migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T07:30:00+05:30');
date_from_inp_dt_migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T07:30:00-05:00');


migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATE, '1973-04-26');
migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T07:30:00');
migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T07:30:00Z');
migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T07:30:00-01:00');
migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T07:30:00+05:30');
migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T07:30:00-05:00');

migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATE, '1973-04-26');
migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T12:34:56');
migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T12:34:56Z');
migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T12:34:56+05:30');
migration_test(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T12:34:56-05:00');

local DATETIME = xml_date_utils.value_type.XML_SCHEMAS_DATETIME;

-- Equal, no timezone
compare_dates_migration_test(DATETIME, '1973-04-26T12:34:56', '1973-04-26T12:34:56');

-- Earlier / later, no timezone
compare_dates_migration_test(DATETIME, '1973-04-26T12:34:55', '1973-04-26T12:34:56');
compare_dates_migration_test(DATETIME, '1973-04-26T12:34:57', '1973-04-26T12:34:56');

-- Equal, both with same timezone
compare_dates_migration_test(DATETIME, '1973-04-26T12:34:56+05:30', '1973-04-26T12:34:56+05:30');

-- Different lexical times representing same instant
compare_dates_migration_test(DATETIME, '1973-04-26T12:34:56+05:30', '1973-04-26T07:04:56Z');

-- Positive vs negative timezone
compare_dates_migration_test(DATETIME, '1973-04-26T12:34:56+05:30', '1973-04-26T12:34:56-05:00');

-- First has timezone, second does not
compare_dates_migration_test(DATETIME, '1973-04-26T12:34:56+05:30', '1973-04-26T12:34:56');

-- First has no timezone, second does
compare_dates_migration_test(DATETIME, '1973-04-26T12:34:56', '1973-04-26T12:34:56+05:30');

-- UTC is NOT the same representation as "no timezone"
compare_dates_migration_test(DATETIME, '1973-04-26T12:34:56Z', '1973-04-26T12:34:56');

-- Cross-day comparison caused by timezone adjustment
compare_dates_migration_test(DATETIME, '1973-04-26T01:00:00+05:30', '1973-04-25T20:00:00Z');

-- Fractional seconds
compare_dates_migration_test(DATETIME, '1973-04-26T12:34:56.123', '1973-04-26T12:34:56.124');

local d1 = date_utils.n_from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T12:34:56');
local d2 = date_utils.n_from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T12:34:57');
assert(date_utils.n_eq(d1, d1) == true);
assert(date_utils.n_eq(d1, d2) == false);
local d1 = date_utils.n_from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T12:34:56+05:30');
local d2 = date_utils.n_from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T07:04:56Z');
assert(date_utils.n_eq(d1, d2) == true);



local old_dt = date_utils.from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T12:34:56+05:30')
local new_dt = date_utils.n_from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, '1973-04-26T12:34:56+05:30')
local dur = date_utils.from_xml_duration("P2M4D");
local old_result = date_utils.add_duration_to_date(old_dt, dur);
local new_result = date_utils.n_add_duration_to_date(new_dt, dur);

local old_dto, old_tzo = date_utils.date_obj_from_dtt(old_result);
local new_dto, new_tzo = date_utils.n_date_obj_from_dtt(new_result);

assert(old_dto.daynum == new_dto.daynum);
assert(old_dto.dayfrc == new_dto.dayfrc);
assert(old_tzo == new_tzo);
assert(old_result.type == new_result.type);

local old_result = date_utils.subtract_duration_from_date(old_dt, dur);
local new_result = date_utils.n_subtract_duration_from_date(new_dt, dur);

local old_dto, old_tzo = date_utils.date_obj_from_dtt(old_result);
local new_dto, new_tzo = date_utils.n_date_obj_from_dtt(new_result);

assert(old_dto.daynum == new_dto.daynum);
assert(old_dto.dayfrc == new_dto.dayfrc);
assert(old_tzo == new_tzo);
assert(old_result.type == new_result.type);


local old = date_utils.dtt_from_long(ffi.new("long", 62240227200000000), 'date', 330);
local new = date_utils.n_dtt_from_long(ffi.new("long", 62240227200000000), 'date', 330);

assert_same_dtt(old, new);

local old_n, old_tzo = date_utils.long_from_dtt(old);
local new_n, new_tzo = date_utils.n_long_from_dtt(new);

assert(old_n == new_n);
assert(old_tzo == new_tzo);

local old_n, old_tzo = date_utils.daynum_from_dtt(old);
local new_n, new_tzo = date_utils.n_daynum_from_dtt(new);

assert(old_n == new_n);
assert(old_tzo == new_tzo);



local dto = date(1973, 4, 26, 12, 34, 56);
local old = date_utils.cdt_from_dto(dto, 'dateTime', 330);
local new = date_utils.n_cdt_from_dto(dto, 'dateTime', 330);
assert_same_dtt(old, new);

local old = date_utils.date_time_from_dto(dto, 330);
local new = date_utils.n_date_time_from_dto(dto, 330);
assert_same_dtt(old, new);

local old_result = date_utils.convert_format(old_dt, 'date');
local new_result = date_utils.n_convert_format(new_dt, 'date');
assert_same_dtt(old_result, new_result);

local old_n, old_tzo = date_utils.time_from_dtt(old_dt);
local new_n, new_tzo = date_utils.n_time_from_dtt(new_dt);
assert(old_n == new_n);
assert(old_tzo == new_tzo);


local old_xml = date_utils.to_xml_format(old_dt);
local new_xml = date_utils.n_to_xml_format(new_dt);

assert(old_xml == new_xml);

local function test_dtt(date_type_id, input, expected)

    local cdt = date_utils.n_dtt_from_xml_date_field(
        date_type_id,
        input
    );

    assert(cdt ~= nil);
    assert(ffi.istype("dt_s_type", cdt));
    assert(cdt.type == date_type_id);

    local output = date_utils.n_to_xml_date_field(
        date_type_id,
        cdt
    );

    print(input, "->", output);

    assert(output == expected,
        "Expected {" .. expected .. "} got {" .. output .. "}");
end


-- date
test_dtt(xml_date_utils.value_type.XML_SCHEMAS_DATE, "2026-09-19", "2026-09-19");

-- date with UTC
test_dtt(xml_date_utils.value_type.XML_SCHEMAS_DATE, "2026-09-19Z", "2026-09-19Z");

-- date with positive timezone
test_dtt(xml_date_utils.value_type.XML_SCHEMAS_DATE, "2026-09-19+05:30", "2026-09-19+05:30");


-- dateTime
test_dtt(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "2026-09-19T12:34:56", "2026-09-19T12:34:56.000");

-- dateTime UTC
test_dtt(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "2026-09-19T12:34:56Z", "2026-09-19T12:34:56.000Z");

-- positive timezone
test_dtt(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "2026-09-19T12:34:56+05:30", "2026-09-19T12:34:56.000+05:30");

-- negative timezone -- important test
test_dtt(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "1973-04-26T12:34:56-05:00", "1973-04-26T12:34:56.000-05:00");


-- fractional seconds
test_dtt(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "2026-09-19T12:34:56.123", "2026-09-19T12:34:56.123");


-- time
test_dtt(xml_date_utils.value_type.XML_SCHEMAS_TIME, "12:34:56", "12:34:56.000");
test_dtt(xml_date_utils.value_type.XML_SCHEMAS_TIME, "12:34:56+05:30", "12:34:56.000+05:30");

print("str_to_dtt tests passed");

do
    local cdt = date_utils.n_dtt_from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "2026-09-19T12:34:56+05:30");

    assert(cdt.has_timezone == 1);
    assert(tonumber(cdt.timezone) == 330);

    print(
        "day_num =", tonumber(cdt.day_num),
        "day_frac =", tonumber(cdt.day_frac),
        "timezone =", tonumber(cdt.timezone)
    );
end

do
    local cdt = date_utils.n_dtt_from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "1973-04-26T12:34:56-05:00");

    assert(cdt.has_timezone == 1);

    -- Particularly important: proves the old signed-bitfield
    -- FFI problem is no longer leaking across the boundary.
    assert(tonumber(cdt.timezone) == -300);
end

do
    local cdt = date_utils.n_dtt_from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "2026-09-19T12:34:56");

    assert(cdt.has_timezone == 0);
    assert(tonumber(cdt.timezone) == 0);
end

print("dt_s_type field tests passed");


local function test_to_xml(tid, input)

    local dtt = date_utils.n_from_xml_date_field(tid, input);

    local old = date_utils.n_o_to_xml_date_field(tid, dtt);
    local new = date_utils.n_to_xml_date_field(tid, dtt);

    print(input, "OLD:", old, "NEW:", new);

    assert(old == new, "OLD {" .. old .. "} NEW {" .. new .. "}");
end

test_to_xml(xml_date_utils.value_type.XML_SCHEMAS_DATE, "1973-04-26");
test_to_xml(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "1973-04-26T07:30:00-05:00");
test_to_xml( xml_date_utils.value_type.XML_SCHEMAS_TIME, "12:34:56+05:30");

test_to_xml(xml_date_utils.value_type.XML_SCHEMAS_DATE, "2026-09-19Z");
test_to_xml(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "2026-09-19T12:34:56+05:30");
test_to_xml(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "2026-09-19T12:34:56.123");
test_to_xml(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "2000-02-29T23:59:59Z");

print("dtt_to_str tests passed");


local d = date_utils.n_from_xml_datetime("2026-09-19T12:30:45");

print(date_utils.n_to_xml_format(d));

local day_num  = tonumber(d.day_num);
local day_frac = tonumber(d.day_frac);
local typ      = d.type;

local ret = date_utils.n_set_tz(d, 330);

print(date_utils.n_to_xml_format(d));

assert(tonumber(d.timezone) == 330);
assert(tonumber(d.has_timezone) == 1);

-- Date/time itself must not change
assert(tonumber(d.day_num) == day_num);
assert(tonumber(d.day_frac) == day_frac);

-- Type must not change
assert(d.type == typ);

-- It mutates and returns the same object
assert(ret == d);

print("n_set_tz smoke test passed");

date_utils.n_set_tz(d, -300);
print(date_utils.n_to_xml_format(d));

assert(tonumber(d.timezone) == -300);

local cdt = date_utils.n_from_xml_datetime(
    "2026-09-19T12:34:56+05:30"
);

local dto, tzo = date_utils.n_date_obj_from_cdt(cdt);

print(dto);
print(tzo);

assert(tzo == 330);

local cdt2 = date_utils.n_dtt_from_date_obj(dto, tzo);

assert(tonumber(cdt.day_num) == tonumber(cdt2.day_num));
assert(tonumber(cdt.day_frac) == tonumber(cdt2.day_frac));
assert(tonumber(cdt.timezone) == tonumber(cdt2.timezone));
assert(tonumber(cdt.has_timezone) == tonumber(cdt2.has_timezone));

print("n_date_obj_from_cdt smoke test passed");

local d = date_utils.n_from_xml_datetime(
    "2026-09-19T12:30:45+05:30"
);

local u = date_utils.n_get_utc_date_time(d);

print(date_utils.n_to_xml_format(d));
print(date_utils.n_to_xml_format(u));

assert(tonumber(u.timezone) == 0);
assert(tonumber(u.has_timezone) == 1);

print("n_get_utc_date_time smoke test passed");

local d = date_utils.n_from_xml_datetime(
    "2026-09-19T12:30:45-05:00"
);

local u = date_utils.n_get_utc_date_time(d);

print(date_utils.n_to_xml_format(u));
]]















-- New datetime implementation mappings
date_utils.split_dtt                   = date_utils.n_split_dtt;
date_utils.date_obj_from_dtt           = date_utils.n_date_obj_from_dtt;
date_utils.is_valid_date               = date_utils.n_is_valid_date;
date_utils.is_valid                    = date_utils.n_is_valid;

date_utils.dtt_from_date_obj           = date_utils.n_dtt_from_date_obj;

date_utils.dtt_from_xml_date_field     = date_utils.n_dtt_from_xml_date_field;
date_utils.from_xml_date_field         = date_utils.n_from_xml_date_field;
date_utils.to_xml_date_field           = date_utils.n_to_xml_date_field;

date_utils.from_xml_date               = date_utils.n_from_xml_date;
date_utils.to_xml_date                 = date_utils.n_to_xml_date;

date_utils.from_xml_datetime           = date_utils.n_from_xml_datetime;
date_utils.to_xml_datetime             = date_utils.n_to_xml_datetime;

date_utils.from_xml_time               = date_utils.n_from_xml_time;
date_utils.to_xml_time                 = date_utils.n_to_xml_time;

date_utils.compare_dates               = date_utils.n_compare_dates;
date_utils.get_date_components         = date_utils.n_get_date_components;

date_utils.date_diff                   = date_utils.n_date_diff;

date_utils.add_duration_to_date        = date_utils.n_add_duration_to_date;
date_utils.subtract_duration_from_date = date_utils.n_subtract_duration_from_date;

date_utils.dtt_from_long               = date_utils.n_dtt_from_long;
date_utils.long_from_dtt               = date_utils.n_long_from_dtt;

date_utils.dtt_from_daynum             = date_utils.n_dtt_from_daynum;
date_utils.daynum_from_dtt             = date_utils.n_daynum_from_dtt;

date_utils.dtt_from_time               = date_utils.n_dtt_from_time;
date_utils.time_from_dtt               = date_utils.n_time_from_dtt;

date_utils.cdt_from_dto                = date_utils.n_cdt_from_dto;
date_utils.date_time_from_dto          = date_utils.n_date_time_from_dto;

date_utils.convert_format              = date_utils.n_convert_format;
date_utils.to_xml_format               = date_utils.n_to_xml_format;

date_utils.now                         = date_utils.n_now;
date_utils.today                       = date_utils.n_today;

date_utils.set_tz                      = date_utils.n_set_tz;
date_utils.date_obj_from_cdt           = date_utils.n_date_obj_from_cdt;
date_utils.get_utc_date_time           = date_utils.n_get_utc_date_time;

local dt_mt = {
	__tostring = date_utils.n_to_xml_format,
	__gc = date_utils.n_free_cdt,
	__sub = date_utils.n_date_diff,
	__eq = date_utils.n_eq,
	__lt = date_utils.n_lt,
	__le = date_utils.n_le,
	__gt = date_utils.n_gt,
	__ge = date_utils.n_ge,
};
ffi.metatype("dt_s_type", dt_mt);


local dur_mt = {
	__tostring = date_utils.to_xml_duration,
	__gc = date_utils.free_cdur,
};
ffi.metatype("dur_s_type", dur_mt);

return date_utils;
