def fact(n):
    return 1 if n < 2 else n * fact(n - 1)

print(fact(5))
