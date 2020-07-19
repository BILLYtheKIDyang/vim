import random

bases = [
    30.5,
    40,
    48,
    32.5,
    65,
    40.8,
    37.5,
    28,
    28.5,
    37,
    35,
    39.2,
    52.7,
    16,
    59.5,
    45,
    43.6,
    56,
    40.8,
    54,
    28,
    60.5,
    30,
    53,
    72,
    37.1,
    28,
    36.5,
    38.5,
    65.8,
    41.5,
    51.5,
    44,
    52,
    32,
    46.6,
    45,
    55.5,
    49.8,
    61,
    44,
    43,
    30.5,
    20,
    28,
    56,
    63,
    44,
    46,
    22,
    40,
    50.1,
    42.5,
]
for _ in range(100):
    random.shuffle(bases)
    for x in bases:
        t1 = int(x) + round(30.3 * random.random(), 1)
        t1 = 90 if t1 > 90 else t1
        t2 = int(x) + round(30.3 * random.random(), 1)
        t2 = 90 if t2 > 90 else t2
        t3 = int(x) + round(30.3 * random.random(), 1)
        t3 = 90 if t3 > 90 else t3
        t4 = int(x) + round(30.3 * random.random(), 1)
        t4 = 90 if t4 > 90 else t4
        print(t1, ",", t2, ",", t3, ",", t4)


