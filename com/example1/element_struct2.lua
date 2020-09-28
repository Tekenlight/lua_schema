--[[
-- This is an element declaration of explicit type, hence all element type information
--	is externally defined .
-- 
-- ]]
local basic_stuff = require("basic_stuff");

local _factory = {}

function _factory:new_instance_as_root()
	return (require('com.example.struct2')):new_instance_as_root(
						{ns='http://example1.com', local_name = 'element_struct2', generated_name = 'element_struct2'});
end

function _factory:new_instance_as_ref(element_ref_properties)
	local o = self:new_instance_as_element({ns='http://example1.com', local_name = 'element_struct2', generated_name = 'element_struct2', min_occurs = element_ref_propertie.min_occurs, max_occurs = element_ref_propertie.max_occurs});
	return o;
end

return _factory;
