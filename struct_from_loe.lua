local struct_from_loe = function(schema_type_handler, list)
	local out_struct = {};
	local list_index = 1;
	local objs = (require('stack')).new();
	local metas = (require('stack')).new();
	objs:push(out_struct);
	metas:push({top_obj = nil;});
	local i = 1;
	local n = #list;

	local N = #schema_type_handler.properties.content_fsa_properties;
	while (i <= N) do
		while (true) do
			local item = schema_type_handler.properties.content_fsa_properties[i];
			if (item.symbol_type == 'cm_begin') then
				local obj = objs:top();
				if (item.max_occurs ~= 1) then
					local meta = {begin_index = i, element_found = false;};
					meta.top_obj = obj;
					if (nil == obj[item.generated_symbol_name]) then
						obj[item.generated_symbol_name] = {};
					end
					objs:push({});
					metas:push(meta);
				end
				i = i+1;
				break;
			elseif (item.symbol_type == 'element' or item.symbol_type == 'any') then
				if (list_index > n) then
					while (item.symbol_type ~= 'cm_end') do
						i = i+1;
						item = schema_type_handler.properties.content_fsa_properties[i];
					end
					break;
				end
				local name, value;
				for nn,vv in pairs(list[list_index]) do
					name = nn;
					value = vv;
					break;
				end
				if (name == item.generated_name) then
					local sth = schema_type_handler.properties.generated_subelements[item.generated_name];
					if (sth.particle_properties.max_occurs ~= 1) then
						if ((objs:top())[item.generated_name] == nil) then
							(objs:top())[item.generated_name] = {};
						end
						local count = #((objs:top())[item.generated_name]);
						(objs:top())[item.generated_name][count+1] = value;
					else
						(objs:top())[item.generated_name] = value;
					end
					list_index = list_index + 1;
					i = i+1;
					if (item.cm.max_occurs ~= 1) then
						(metas:top()).element_found = true;
					end
					if (item.cm.group_type == 'C') then
						item = schema_type_handler.properties.content_fsa_properties[i];
						while (item.symbol_type ~= 'cm_end') do
							i = i+1;
							item = schema_type_handler.properties.content_fsa_properties[i];
						end
					end
				else
					i = i+1;
				end
				break;
			elseif (item.symbol_type == 'cm_end') then
				local begin_idx = item.cm_begin_index;
				local begin_item = schema_type_handler.properties.content_fsa_properties[begin_idx];
				local generated_name = begin_item.generated_symbol_name;
				if (begin_item.max_occurs ~= 1) then
					local meta = metas:pop();
					local obj = objs:pop();
					local top_obj = objs:top();
					local arr = top_obj[generated_name];
					local count = #arr;
					if (meta.element_found) then
						arr[count+1] = obj;
					end
					if (begin_item.max_occurs ~= -1) then
						if (#arr == begin_item.max_occurs) then
							i = i+1;
						else
							i = begin_idx;
						end
					else
						if (not meta.element_found) then
							i = i+1;
						else
							i = begin_idx;
						end
					end
				else
					i = i+1;
				end
				local top_obj = objs:top();
				break;
			end
		end
	end

	if (list_index <= n) then
		return nil;
	else
		return out_struct;
	end
end

return struct_from_loe;
