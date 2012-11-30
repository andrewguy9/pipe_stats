#!/usr/bin/env python

import time
import math

class CumlativeMovingAverage:
  def __init__(self):
    self.n = 0.0
    self.total = 0.0

  def update(self, value):
    self.n += 1
    self.total += value
    return self.get()

  def get(self):
    return self.total / self.n

# Exponentially moving average: Returns a moving average where a given data point has
# less and less impact on the current value as new points come in.
# alpha is the proportion of the measurement which should be determined
# by this datapoint.
# S(1) = Y(1)
# S(t) = alpha * Y(t) + (1 - alpha) * S(t-1)
# where alpha is between 0 and 1
class ExponentialMovingAverage:
  def __init__(self):
    self.s = 0.0
 
  def update(self, y, alpha):
    self.s = alpha * y + (1-alpha)*self.s
    return self.s

  def get(self):
    return self.s


# S(n) = a*Y(n) + (1-a)*S(n-1)
# Where a is function of time between n and n-1.
# a( t(n) - t(n-1) ) = 1 - exp(-(t(n) - t(n-1))/(W*60))
# Where time is in seconds and W is the period of time in minutes over which the
# average is said to be over.
class MovingAverage:
  def __init__(self, period, time_source=time.time):
    self.w = period
    self.ts = time_source
    self.t_last = self.ts()
    self.avg = ExponentialMovingAverage()

  def update(self, value):
    t_now = self.ts()
    delta = t_now - self.t_last
    self.t_last = t_now
    alpha = 1-math.exp(-delta/self.w)
    return self.avg.update(value, alpha)

  def get(self):
    return self.avg.get()


class MovingRate:
  def __init__(self, period, time_source=time.time):
    self.w = period
    self.ts = time_source
    self.t_last = self.ts()
    self.rate = 0

  def update(self, count):
    t_now = self.ts()
    delta = t_now - self.t_last
    self.t_last = t_now
    alpha = math.exp(-delta/self.w)
    self.rate = count + self.rate*alpha
    return self.rate

  def get(self):
    return self.update(0)
