local date = require("date");
local xmlua = require("xmlua");
local xml_date_utils = xmlua.XMLDateUtils.new();
local nu = require("number_utils");

local error_handler = require("error_handler");

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

date_utils.num_from_dto = function(dto)
	local num = dto.daynum * 24 * 60 * 60 * date.ticks() + dto.dayfrc
	return num;
end

date_utils.dto_from_num = function(dt_num)
	dt_num = nu.round(dt_num, 1);

	local d_day_frc = dt_num % (24 * 60 * 60 * date.ticks());
	d_day_frc = nu.round(d_day_frc, 1000);

	local d_day_num = (dt_num - d_day_frc) / (24 * 60 * 60 * date.ticks());
	d_day_num = nu.round(d_day_num, 1);

	return date.from_dnum_and_frac(d_day_num, d_day_frc);
end

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

date_utils.is_valid_date = function(date_type_id, s)
	local status, dto, tzo = pcall(date_utils.split_dtt, s);
	return status;
end

date_utils.is_valid_duration = function(s)
	local status, dto, tzo = pcall(date_utils.split_dtt, s);
	return status;
end

date_utils.date_obj_from_dtt = function(s)
	if (s == nil or type(s) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end

	local dto, tzo = date_utils.split_dtt(s);

	--local dto = date_utils.dto_from_num(dt_num);

	return dto, tzo;
end

date_utils.dtt_from_date_obj = function(dto, tzo)
	local ret = {};
	ret.num = nu.round(date_utils.num_from_dto(dto), 1);
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

date_utils.from_xml_date_field = function(date_type_id, s)
	if (date_type_id == nil or type(date_type_id) ~= 'number') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	elseif (s == nil or type(s) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end

	local d1 = xml_date_utils.str_to_date(date_type_id, s);
	if (d1 == nil) then
		local name = date_utils.tid_name_map[date_type_id];
		error_handler.raise_validation_error(-1, "{"..s.."} not a valid "..name, debug.getinfo(1));
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

	return date_utils.dtt_from_date_obj(dto, tzo);
end

date_utils.get_tzo_in_h_m = function(tzo)
	ptzo = math.abs(tzo);
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
		m_str = h_str..'00';
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
	end
	return ret;
end

date_utils.to_xml_date_field = function(tid, s)
	local fmt = date_utils.tid_fmt_map[tid];
	local dto, tzo = date_utils.date_obj_from_dtt(s);

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

date_utils.compare_dates = function(s1, s2)
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

date_utils.split_duration = function(s)
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

date_utils.add_duration_to_date = function(dt, s_dur)
	if (dt == nil or type(dt) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	if (s_dur == nil or type(s_dur) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end

	local dto, tzo = date_utils.split_dtt(dt);
	local dur = date_utils.split_duration(s_dur);

	local o_dto = dto:copy();
	o_dto:addmonths(dur.mon);
	o_dto:adddays(dur.day);
	o_dto:addseconds(dur.sec);

	local ret = date_utils.dtt_from_date_obj(o_dto, tzo);

	return ret;
end

date_utils.compare_durations = function(s_dur1, s_dur2)
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

date_utils.from_xml_duration = function(s)
	if (s == nil or type(s) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	local x_dur = xml_date_utils.str_to_duration(s);
	if (x_dur == nil) then
		error_handler.raise_validation_error(-1, "{"..s.."} not a valid duration", debug.getinfo(1));
		return nil
	end
	--require 'pl.pretty'.dump(x_dur);
	local dur = { mon = x_dur.mon, day = x_dur.day, sec = x_dur.sec } ;
	--require 'pl.pretty'.dump(dur);
	return date_utils.str_from_dur(dur);
end

date_utils.to_xml_duration = function(s)
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

--[[
local dt1 = date_utils.from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "1973-04-26T07:30:00.001Z");
local dt2 = date_utils.from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "1973-04-26T07:30:00.001Z");


print(date_utils.compare_dates(dt1, dt2));
--
local d = date.from_dnum_and_frac(0, 0)
require 'pl.pretty'.dump(d);
print(d);
print(d:spandays());
--
--local s_dur = 'P2Y6M5DT12H35M30S';
--]]
--[[
local s_dur = 'P1Y'
local dur = date_utils.from_xml_duration(s_dur);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, dur);
local dt1 = date_utils.from_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, "1973-04-26T07:30:00.001+05:30");
print(date_utils.to_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, dt1));

local o = date_utils.add_duration_to_date(dt1, dur);
print(date_utils.to_xml_date_field(xml_date_utils.value_type.XML_SCHEMAS_DATETIME, o));
print(date_utils.to_xml_duration(dur));

s_dur = 'P2Y6M5DT12H35M30.123S';
dur = date_utils.from_xml_duration(s_dur);
print(s_dur);
print(date_utils.to_xml_duration(dur));
--
local D1 = 'P1Y1DT1M';
local D2 = 'P1Y1DT1S';
local dur1 = date_utils.from_xml_duration(D1);
local dur2 = date_utils.from_xml_duration(D2);
print(date_utils.compare_durations(dur1, dur2));
--]]

return date_utils;