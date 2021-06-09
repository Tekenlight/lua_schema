for file in `find gfrom_xml`
do
	if [ -f $file ]
	then
		echo $file
		lua $file
		echo $file
		echo -------------------------
		read
	fi
done
