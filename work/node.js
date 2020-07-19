// 匹配中文 [\u4e00-\u9fa5]
"中文d愛Chinese".match(/[\u4e00-\u9fa5]+/g)


function fun1() {
   var a = 1;
   function fun2() {
      console.log(a);
   }
   return fun2;
}

var i = fun1()
i
i();

var arr = [1,2,3,4];
var str = arr.join("*_*");
str;
str.length
for (var i = 0; i < str.length; i++) {
   console.log(str.charAt(i));
}


