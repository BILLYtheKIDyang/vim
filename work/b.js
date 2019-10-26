function fact(n) {
   if (n < 2) {
      return 1;
   } else {
      return n * fact(n - 1);
   }
}

fact(5)
fact(9)
