val x = 3;
val y = x + 1;

fun fact n = 
  if n = 0 then 1
  else n * fact(n - 1) ;

  let val x = 3
    fun  f y = (y, x * y)
  in
    f(4 + x)
  end;

  Math.pi;

fun circleArea r = Math.pi * r * r;

  circleArea 1.0;
  circleArea (2.0);

fun fact 0 = 1
  | fact n = n * fact(n - 1);

fact 4;

fun power(x, 0) = 1.0
  | power(x, n) = x * power(x, n - 1) (* 2 *);
val a = (2.0, 3);
power a;
power (4.0, 2);

fun g(n) = n + 4;
fun h(x, y) = Math.sqrt(x * x + y * y);
  h(3.0, 4.0);

fun f 1 = 1
  | f n = f(n-1) + n;
  (* sum(m, n) = m + (m + 1) + (m + 2) + ... + (m + (n - 1)) + (m + n) *)
fun sum(m, 0) = m
  | sum(m, n) = sum(m, n - 1) + (m + n);
  sum(2,3);
  sum(0,4);

  (* fact (n) = 1 * 2 * 3 ... * (n - 1) * n *)
fun fact 0 = 1
  | fact n = fact(n - 1) * n;

  fact 10;
  fact 5;

val inc = fn x => x + 1;
