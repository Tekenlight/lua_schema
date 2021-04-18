local _xml_lib_loader = package.loadlib('lua_xsd_lib.so', 'luaopen_xsd_lib');
local _lib = _xml_lib_loader();

return _lib;
