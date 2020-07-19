seq 10 \
   | sed 'H;g' \
   |awk -v RS='' \
   '{
   for (i=1; i<=NF; i++)
      printf("%d x %d = %d%s", i, NR, i*NR, i == NR ? "\n" : "\t")
   }'

find ~/Desktop -name '*.jpg'

find ~/Desktop -iname  '*.jpg'

find ~/ \( -iname '*.jpeg' -o -iname '*.avi' \)

find ~/ -iname '*.txt' -mtime -365

find ~/ -iname '*.txt' -size +20k
