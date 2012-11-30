#!/usr/bin/env python

import random
import math
import counter

t = 0

tot = counter.CumlativeMovingAverage()
avg = counter.ExponentialMovingAverage()
aot = counter.MovingAverage(5000.0,lambda: t)
rat = counter.MovingRate(5000.0, lambda: t)

for t in range(25000):
  v = random.randint(0,1)
  tot.update(v)
  avg.update(v, 1.0/5000.0)
  aot.update(v)
  rat.update(v)
print '%.2f %.2f %.2f %.2f'%(tot.get(), avg.get(), aot.get(), rat.get()/5000)
