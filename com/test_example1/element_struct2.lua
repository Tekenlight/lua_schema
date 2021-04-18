local basic_stuff = require("basic_stuff");

local _factory = {};

function _factory:new_instance_as_root()
    return require('com.test_example1.struct2'):new_instance_as_global_element({
                                        ns = 'http://test_example1.com',
                                        local_name = 'element_struct2',
                                        generated_name = 'element_struct2',
                                        root_element = true,
                                        min_occurs = 1,
                                        max_occurs = 1});
end


function _factory:new_instance_as_ref(element_ref_properties)
    return require('com.test_example1.struct2'):new_instance_as_local_element({ ns = 'http://test_example1.com',
                                                        local_name = 'element_struct2',
                                                        generated_name = element_ref_properties.generated_name,
                                                        min_occurs = element_ref_properties.min_occurs,
                                                        max_occurs = element_ref_properties.max_occurs,
                                                        root_element = element_ref_properties.root_element});
end


return _factory;
