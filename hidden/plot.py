import matplotlib.pyplot as plt
from numpy import linspace, array

def f(x):
    return x**5 + 8.*x**3 - 2.*x**2 + 5.*x - 1.2

x = linspace(-1,1,30)
y = f(x)
plt.plot(x, y, 'b-')
x = array([-1,1,0,0.5])
y = f(x)
plt.ylim((-18,12))
plt.plot(x, y, 'ro')
plt.plot([0.2407,0.2407], [-20,20], 'c:')
plt.grid()
plt.savefig('figs/bisection.png')
