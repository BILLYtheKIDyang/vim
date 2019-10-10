def fact(n):
    if n < 2:
        return 1
    else:
        return n * fact(n - 1)
fact(10)
fact(20)
fact(30)
b = [
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
]
b
import pprint
pprint.pprint(b)
