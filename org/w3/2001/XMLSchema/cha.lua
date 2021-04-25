local s = '0alsjdflkajsf';

local found = string.match(s, '[^%a%d_:-]');
print(found, s);
local begin = string.sub(s, 1, 1);


print(begin);

local c = string.match(begin, '[^:%a_]');

print(tostring(c))
