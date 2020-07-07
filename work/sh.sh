# Udemy - Linux Bash Shell Scripting Complete Guide (incl. AWK & SED)
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
