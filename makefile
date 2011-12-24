CPP_C = g++
CPP_C_FLAGS = -g -Wall

%.o:
	$(CPP_C) $(CPP_C_FLAGS) -o $@ -c $<

%.out:
	$(CPP_C) $(CPP_C_FLAGS) -o $@ $^

all: StatCalculator.out EnterpySourceTest.out Sample.out
	echo "All done"

StatCalculator.out: StatCalculator.o RunningAverage.o RunningMax.o ReservoirSample.o HeavyHitters.o EnterpySource.o Histogram.o

EnterpySourceTest.out: EnterpySource.o EnterpySourceTest.o HeavyHitters.o

Sample.out: Sample.o EnterpySource.o ReservoirSample.o

RunningAverage.o: RunningAverage.cpp RunningAverage.hpp

RunningMax.o: RunningMax.cpp RunningMax.hpp

ReservoirSample.o: ReservoirSample.cpp ReservoirSample.hpp

HeavyHitters.o: HeavyHitters.cpp HeavyHitters.hpp

StatCalculator.o: StatCalculator.cpp

EnterpySource.o: EnterpySource.cpp EnterpySource.hpp

EnterpySourceTest.o: EnterpySourceTest.cpp

Histogram.o: Histogram.cpp Histogram.hpp

Sample.o: Sample.cpp

clean:
	rm -f *.out *.o
