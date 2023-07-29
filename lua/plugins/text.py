import numpy as np
import matplotlib.pyplot as plt


def fun(x):
    return np.sin(x) + 0.5 * x

y=[]
x=[]
for i in range(100):
    x.append(i)
    y.append(fun(i))



plt.plot(x,y)
plt.show()
