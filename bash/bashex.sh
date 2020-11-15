#! /bin/bash
#set -xv

#"local" is bash reserved word

echo $1 $2 $3 ' -> echo $1 $2 $3'

args=("$@") # or args="$@"
echo ${args[0]} ${args[1]} ${args[2]}
echo $@

echo Number of arguments passed: $#
# use backticks " ` ` " to execute shell command
echo `uname -o`

echo -e "What are your favorite colours ? "
read -a colours
echo ${colours[@]}
#read color1 color2
#echo $color1, $color2
#read
#echo $REPLY

# bash trap command
trap bashtrap INT
# bash clear screen command
#clear;
# bash trap function is executed when CTRL-C is pressed:
# bash prints message => Executing bash trap subrutine !
bashtrap()
{
    echo "CTRL+C Detected !...executing bash trap !"
}
# for loop from 1/10 to 10/10
for a in `seq 1 2`; do
    echo "$a/2 to Exit." 
    sleep 1;
done
echo "Exit Bash Trap Example!!!"

ARRAY=( 'Debian Linux' 'Redhat Linux' Ubuntu Linux )
ELEMENTS=${#ARRAY[@]}
for (( i=0;i<$ELEMENTS;i++)); do
    echo ${ARRAY[${i}]}
done

for f in $( ls /var/ ); do
	echo $f
done 

COUNT=0
until [ $COUNT -gt 5 ]; do
        echo Value of count is: $COUNT
        let COUNT=COUNT+1
done 


# This bash script will locate and replace spaces
# in the filenames
DIR="."
# Controlling a loop with bash read command by redirecting STDOUT as
# a STDIN to while loop
# find will not truncate filenames containing spaces
find $DIR -type f | while read file; do
# using POSIX class [:space:] to find space in the filename
if [[ "$file" = *[[:space:]]* ]]; then
# substitute space with "_" character and consequently rename the file
    mv "$file" `echo $file | tr ' ' '_'`
fi;
# end of while loop
done

#bash function
function function_A {
        echo $1
}
function_A "Function A."

#bash select

#bash switch
case=2
case $case in
    1) echo "You selected bash";;
    2) echo "You selected perl";;
    3) echo "You selected phyton";;
    4) echo "You selected c++";;
    5) exit
esac 

BASH_VAR="xixi"
echo "It's $BASH_VAR  and \"$BASH_VAR\" using backticks: `date`" 

# Bash quoting with ANSI-C style
echo $'web: www.linuxconfig.org\nemail: web\x40linuxconfigorg' #sigle quotes and $

#arithmetic operations
a=1
b=2
let RESULT1=$a+$b
echo $a+$b=$RESULT1
declare -i RESULT2
RESULT2=$a+$b
RESULT3=$((a + b))
RESULT4=$a+$b

echo "RESULT1=$RESULT1, RESULT2=$RESULT2, RESULT3=$RESULT3, RESULT4=$RESULT4"
echo $a+$b=$RESULT2
echo $a+$b=$(($a + $b))
echo $a+$b=$((a + b))
# There are two formats for arithmetic expansion: $[ expression ] 
# and $(( expression #)) its your choice which you use
echo 7 - 7 = $[ 7 - 7 ]

floating_point_number=3.14
echo `printf %.0f $floating_point_number`
x=$(printf %.0f $floating_point_number)
echo "x=$x"

y=2
if [[ y -eq 1 || y -eq 2 ]] ; then
    echo "y equals $y"
fi

var="abcde"; echo ${var%d*}
echo ${var/de/12}
default="hello"
unset var
echo ${var:-$default}
mv error.log{,.OLD}
echo f{ee,oo}d
for num in {000..2}; do echo "$num"; done
for num in {1..10}; do echo $num; done
echo {00..8..2}
echo {D..T..4}




