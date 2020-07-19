seq 10 \
   | sed 'H;g' \
   |awk -v RS='' \
   '{
   for (i=1; i<=NF; i++)
      printf("%d x %d = %d%s", i, NR, i*NR, i == NR ? "\n" : "\t")
   }'
find ~/Desktop -name '*.jpg'
find ~/Desktop -iname  '*.jpg'
find ~/Desktop \( -iname '*.jpeg' -o -iname '*.avi' \)
find ~/Desktop -iname '*.txt' -mtime -365
find ~/Desktop -iname '*.txt' -size +20k

function  fact {
   if [ $1 -lt 2 ] ; then
      echo 1
   else
      local t=$[ $1 - 1 ]
      local r=`fact $t`
      echo $[ $r * $1 ]
   fi
}
fact 10
function percent {
   a=$(grep -iEo '[^0-9]' $1 | wc -l)
   b=$(wc -c $1 | awk '{ print $1 }')
   echo $(( $a * 100 / $b))
}
percent a.sh


max2() {
   if [ -z "$2" ]; then
      return $E_PARAM_ERR
   fi
   if [ "$1" -eq "$2" ]; then
      return $EQUAL
   else
      if [ "$1" -gt "$2" ] ; then
         return $1
      else
         return $2
      fi
   fi
}
max2 33 34
echo $?


dohanoi() {
   case $1 in
      0)
         ;;
      *)
         dohanoi "$(($1-1))" $2 $4 $3
         echo move $2 "-->" $3
         let "Moves += 1"
         dohanoi "$(($1-1))" $4 $3 $2
         ;;
   esac
}
Moves=
dohanoi 3 1 3 2

