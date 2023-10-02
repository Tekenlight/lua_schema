local date_utils = require("lua_schema.date_utils");

print("Date in UTC", date_utils.today(true));
print("Date in local time zone", date_utils.today(false));
print("Date in local time without time zone ", date_utils.today());
print("--------------------------------------------------");
print("Datetime in UTC", date_utils.now(true));
print("Datetime in local time zone", date_utils.now(false));
print("Datetime in local time without time zone ", date_utils.now());
