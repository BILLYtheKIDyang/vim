import math
from matplotlib import pyplot
ws = list(range(-201, 201, 1))
xs = list(map(lambda x: math.pi * x * 0.01, ws))
ys = list(map(math.sin, xs))
pyplot.plot(xs, ys)
pyplot.show()

