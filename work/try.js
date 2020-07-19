var i = 0, total = 0;
a=[1,2,3,"a", "1", "100", "bc"];
while (i < a.length) {
   try {
      if ((typeof a[i] != "number") || isNaN(a[i]))
         continue;
      total += a[i];
   } finally {
      i++;
   }
}
total
