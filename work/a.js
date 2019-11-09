function doSomething(a) {
   b = a + doSomethingElse(a * 2);
   console.log(b * 3);
}

function doSomethingElse(a) {
   return a - 1;
}

//var b;
doSomething(2);
// b = 2 + doSomethingElse(2 * 2);
// b = 2 + doSomethingElse(4);
// b = 2 + 3;
// b = 5
// Console.log(5 * 3);
// 15
