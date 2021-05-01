for file in to_xml/*.lua
do
	lua $file
	echo $file
	read
done
