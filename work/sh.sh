# Udemy - Linux Bash Shell Scripting Complete Guide (incl. AWK & SED)
# 1. Basic
# Match calculation - let
NUMBER=7
let RESULT=NUMBER+5 # no space nor dollar sign
echo $RESULT
echo $NUMBER
let NUMBER++
let NUMBER-=10
echo $NUMBER
# Math calculation - (())
echo $((5 + 5))
# Math calculation - []
echo $[NUMBER + 5]
# Math calculation - expr
echo $(expr $NUMBER + 5) # need space around math operator
echo `expr $NUMBER + 5`
# Math calculation - bc
# Operate with floating points
echo $(echo "3.14 * 3.0 + 3.00 / 10" | bc)

date
# 3. For Loop
for PLANET in Mercury Venus Earth; do
   echo $PLANET
done

for FILE in *.sh; do
   echo $FILE
done

for NUMBER in {1..10}; do
   echo $NUMBER
done

for ARG in "$@"; do
   echo $ARG
done

for ((i = 1; i <= 10; i++)); do
   echo $i
done

# info.sh
# into all .txt files in the current directory add a new line with the current date
# and first 5 lines of ps command
for FILE in *.txt; do
   echo $(date) >> $FILE
   ps -ef | head -5 >> $FILE
   echo ====================== >> $FILE
done
#!/bin/bash
# args.sh one two three hello someting
# go through all arugments and print them all

COUNT=1

for ARG in "$@"; do
   #          "$*" 不行
   echo "$COUNT. arugment: $ARG"
   let COUNT++
done
# 4. While Loop
while [ "$NAME" != "stop" ]; do
   echo -n Enter your name:
   read NAME
done

A=1
LIMIT=10
while((A < LIMIT)); do
   touch $A
   let A++
done


while read line; do
   echo $line
done < sh.sh


cat sh.sh | 
   while read line; do
      echo $line
   done

# 
# create script for printing files, which will display also line numbers

# argument check
if [ $# -ne 1 ]; then
   echo "Exactly one argument is needed, run: $0 file-path"
   exit 1
fi

# check if provided argument is a file
if ! [ -f "$1" ]; then
   echo "File you have specified does not exists."
   exit 2
fi

FILENAME=$1
COUNT=1
while read line; do
   echo "$COUNT: $line"
   let COUNT++
done < "$FILENAME"

# 查看 IFS
set | grep ^IFS
# 设置 IFS
IFS=$'\n'
echo a$'\n'b
echo a'\n'b
echo a"\n"b
echo a$"\n"b


for i in {1..9}; do
   for ((j = 1; j <= $i; j++)); do
      echo -ne "$i x $j = $[$i * $j]\t"
   done
   echo
done

echo {1..9}

begin_at=$(date "+%s")

while TRUE; do
   end_at=$(date '+%s')
   ((interval=${end_at}-${begin_at}))
   ((hours=${interval}/3600))
   ((minutes=(${interval} % 3600) / 60))
   ((seconds=(${interval} % 3600) % 60))
   tput cr
   tput el
   printf "%02d:%02d:%02d" ${hours} ${minutes} ${seconds}
   sleep 0.5
done
