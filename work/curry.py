def curry(fn, k=None):
    k = k or fn.__code__.co_argcount

    def p(*a):
        l = len(a)
        if l == k:
            return fn(*a)
        elif l < k:
            return curry(lambda *b: fn(*(a + b)), k - l)
        elif l > k:
            raise TypeError('too many arguments', a)

    return p


@curry
def y(f, x):
    return f(y(f), x)


@curry
def fact(f, n):
    return 1 if n < 2 else n * f(n - 1)


@curry
def f3(a, b, c):
    return a + b + c


f3(1, 2, 3)
y(fact, 5)
