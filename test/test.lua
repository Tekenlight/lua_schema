-- test bc library

local bc=require"bc"
local qd=bc

------------------------------------------------------------------------------
print(qd.version)
qd.digits(64)

------------------------------------------------------------------------------
print""
print"Pi algorithm of order 4"

math.new=tonumber

-- http://pauillac.inria.fr/algo/bsolve/constant/pi/pi.html
function test(qd)
	local PI=qd.new"3.1415926535897932384626433832795028841971693993751058209749445923078164062862090"
	print("HHHHHHHHHHH", PI);
	local x=qd.sqrt(2)
	local p=2+x
	local y=qd.sqrt(x)
	print(-1,p)
	x=(y+1/y)/2
	p=p*(x+1)/(y+1)
	print(0,p)
	for i=1,20 do
		local P=p
		local t=qd.sqrt(x)
		y=(y*t+1/t)/(y+1)
		x=(t+1/t)/2
		p=p*(x+1)/(y+1)
		print(i,p)
		if p==P then break end
	end
	print("exact",PI)
	print("-",qd.abs(PI-p))
	return p
end

print"fp"
test(math)
print"qd"
test(qd)

------------------------------------------------------------------------------
print""
print"Square root of 2"

function mysqrt(x)
	local y,z=x,x
	repeat z,y=y,(y+x/y)/2 until z==y
	return y
end

print("fp math",math.sqrt(2))
print("fp mine",mysqrt(2))
a=qd.sqrt(2) print("qd sqrt",a)
b=mysqrt(qd.new(2)) print("qd mine",b)
R=qd.new"1.414213562373095048801688724209698078569671875376948073176679737990732478462107038850387534327641573"
print("exact",R)

------------------------------------------------------------------------------
print""
print("RSA")
bc.digits(0)
B=bc

header="="
assert(#header==1)

function text2B(s)
       local x=B.new(0)
       for i=1,#s do
               x=256*x+s:byte(i)
       end
       return x
end

function b2text(x)
	if x:iszero() then
		return ""
	else
		local r
		x,r=B.quotrem(x,256)
		return b2text(x)..string.char(r:tonumber())
       end
end

function B2text(x)
	x=b2text(x)
	assert(x:sub(1,1)==header)
	return x:sub(2)
end

public="10001"
public=65537
private="21216960821007814588960614390762841130569257066134254217244829964166960313603491419452980041842232401031783080783880766977126835656785351324646356132482893330044628606968265135168815301544329093219595232048337692815143928570515249251387658868931468312357689967540610052476964083797859233540117455097"
modulus="120378838310656146196581402937185033258948783684810026719381388742239639691163710255102584451754340363312978564112061445696186060252276929934503158241250532742249087072136730672705057927340298151300358954425756754140677885188853335290225279244158563370031548251283457509517872411021011738313314053603"

d=B.new(public)
	print("public key")
	print(d)

e=B.new(private)
	print("private key")
	print(e)

n=B.new(modulus)
	print("modulus")
	print(n)
	print""

message="The quick brown fox jumps over the lazy dog"
	print("message as text")
	print(message)

m=text2B(header..message)
	print("encoded message in decimal")
	print(m)
	--print("encoded message in hex")
	--print(B2hex(m))
	assert(m<n)
	assert(message==B2text(m))

x=B.powmod(m,e,n)
	print("encrypted message in decimal")
	print(x)
	--print("encrypted message in hex")
	--print(B2hex(x))

y=B.powmod(x,d,n)
	print("decrypted message in decimal")
	print(y)
	--print("decrypted message in hex")
	--print(B2hex(y))
	assert(y==m)

y=B2text(y)
	print("decoded message as text")
	print(y)
	assert(y==message)

------------------------------------------------------------------------------
print""
print(B.version)
