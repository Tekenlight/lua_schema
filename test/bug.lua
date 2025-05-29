mhf = require("schema_processor")
unistd = require("posix.unistd");

local json_string = [=[
{
    "catalogue_list": [
        {
        "org_id": "0000000058",
        "sku": "652-CMP120-FX-10ROL",
        "item_id": "652-CMP120-FX-10ROL",
        "conversion_rate": "1",
        "description": "Resistor",
        "sku_unit_of_measure": "NAR",
        "lead_time": "1",
        "hsn_code": "8533"
        }
    ],
    "parent_org_id": "0000000001"
}
]=]

mhf = require("schema_processor")
example_struct = mhf:get_message_handler("partner_catalogue_setup_data", "http://composites.biop.com");

print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(example_struct.properties);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);

print("from JSON");
local content, msg = example_struct:from_json(json_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

