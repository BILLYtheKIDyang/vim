class A():
    def fact(self, n):
        if n < 2:
            return 1
        else:
            return n * self.fact(n - 1)

    def fib(self, n):
        if n == 1:
            return 0
        elif n == 2:
            return 1
        else:
            return self.fib(n - 1) + self.fib(n - 2)

a  = A()
a.fib(20)
a.fib(30)
a.fib(32)
a.fib(33)
