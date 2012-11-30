#!/usr/bin/env python

import random
import math
import counter

tot = counter.CumlativeMovingAverage()
avg = counter.ExponentialMovingAverage()
aot = counter.AverageOverTime(5000.0,0.0)
rat = counter.Rate(1000.0,0.0)

for t in range(25000):
  v = random.randint(0,1)
  tot.update(v)
  avg.update(v, 1.0/5000.0)
  aot.update(v,t)
  rat.update(v,t)
print '%.2f %.2f %.2f %.2f'%(tot.get(), avg.get(), aot.get(), rat.get(t))
