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
a.fact(10)
a.fact(20)
a.fact(30)
b = [
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
]
b
