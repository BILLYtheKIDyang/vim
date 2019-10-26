import math
from matplotlib import pyplot
ws = list(range(-101, 101, 1))
xs = list(map(lambda x: math.pi * x * 0.01, ws))
ys = list(map(math.cos, xs))
pyplot.plot(xs, ys)
pyplot.show()
