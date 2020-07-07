if False:
    import numpy as np
    import matplotlib.pyplot as plt

    x = range(-3, 4)
    y = np.zeros(len(x))

    for i in range(0, len(x)):
        y[i] = 2 - x[i]**2
    plt.plot(x, y, 's-')
    plt.show()

    x = np.linspace(-3, 4, 100)
    y = 2 + np.sqrt(abs(x))
    plt.plot(x, y, 'ms-')
    plt.show()
    import numpy as np
    import matplotlib.pyplot as plt
    N = 8
    y = np.zeros(N)
    x1 = np.linspace(0, 10, N, endpoint=True)
    x2 = np.linspace(0, 10, N, endpoint=False)
    plt.plot(x1, y, 'o')
    plt.plot(x2, y + 0.5, 'o')
    plt.ylim([-0.5, 1])
    plt.show()

import os
p = os.popen("ls")
t = p.read()
[s for s in t.split("\n") if s.endswith("py")]
