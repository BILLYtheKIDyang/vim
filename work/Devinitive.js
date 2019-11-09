// 6.1.1 对象直接量
var empty = {};                          // 没有任何属性的对象
var point = {x: 0, y: 0};                // 两个属性
var point2 = {x: point.x, y: point.y+1}; // 更复杂的值
var book = { 
   "main title": "JavaScript",          // 属性名字里有空格，必须用字符串表示
   "sub-title": "The Definitive Guide", // 属性名字里有连字符，必须用字符串表示
   "for": "all audiences",              // for 是保留字，因此必须用引号
   author: {                            // 这个属性的值是一个对象
      firstname: "David",               // 这里的属性名都没有引号
      surname: "Flanagan"
   }
};

// 6.1.2 通过 new 创建对象
var o = new Object(); // 创建一个空对象，和 {} 一样
var a = new Array(); // 创建一个空数组，和 [] 一样
var d = new Date();  // 创建一个表示当前时间的 Date 对象
var r = new RegExp("js"); // 创建一个可以进行模式匹配的 RegExp 对象

// 6.1.3 原型
r.prototype

var o1 = Object.create({x: 1, y: 2});
var o2 = Object.create(null);
var o3 = Object.create(Object.prototype);
