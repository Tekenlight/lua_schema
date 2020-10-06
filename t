for file in test_cases/*.lua
do
lua $file
echo $file
read
done
