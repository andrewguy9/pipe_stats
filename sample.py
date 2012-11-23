#!/usr/bin/env python

import random

class ReservoirSample:
  def __init__(self, N):
    self.N = N
    self.n = 0
    self.data = []

  def add(self, value):
    if self.n < self.N:
      self.data.append(value)
    else:
      r = random.randint(0,self.N-1)
      self.data[r] = value
    self.n+=1

  def __iter__(self):
    return iter(self.data)

  def sample_size(self):
    return self.N

  def num_added(self):
    return self.n

