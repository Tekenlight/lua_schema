for file in `find from_xml/`
do
	if [ -f $file ]
	then
		echo $file
		lua $file
		echo -------------------------
	fi
done
