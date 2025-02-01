#!/bin/python3

import matplotlib.pyplot as plt
import math

#a = 0.1 # scaling factor
#b = 0.1 # math.cot(....)

def from_polar(r, t):
    return r * math.sin(t),  r * math.cos(t)

def p(a, b, theta):
    return a * math.exp(b*theta)

def pc(a, b, theta):
    return a/2 * (math.exp(2 * math.pi * b) + 1) * math.exp(b*theta)

def main():
#    spiral(.1, .1, 'bo', 'go')
    spiral(.1, .2, 'b-', 'g-')
#    spiral(.05, .1, 'bx', 'gx')

    plt.show()

def spiral(a, b, c1, c2):
    X = []
    Y = []

    Xc = []
    Yc = []
    for i in range(20):
        t = i * 30 * math.pi/180
        #print(from_polar(p(t)), from_polar(pc(t)))

        x, y = from_polar(p(a, b, t), t)
        X += [x]
        Y += [y]
        #X += [(x,y)]
        #Y += [i]

        #X += [x]
        #Y += [y]
        x, y = from_polar(pc(a, b, t), t)
        Xc += [x]
        Yc += [y]

    print("Outer:")
    print(X)
    print(Y)
    print("Inner:")
    print(Xc)
    print(Yc)
    plt.plot(X, Y, c1, Xc, Yc, c2)

main()

