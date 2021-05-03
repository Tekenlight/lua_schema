basic_stuff = require("basic_stuff");

pn = basic_stuff.package_name_from_uri("http://www.example.prototype:9090/one/two/three:four/five");
print("http://www.example.prototype:9090/one/two/three:four/five ==== "..pn);

pn = basic_stuff.package_name_from_uri("urn:123:234:345:456");
print("urn:123:234:345:456 ==== "..pn);
