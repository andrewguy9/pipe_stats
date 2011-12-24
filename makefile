all: StatCalculator.out EnterpySourceTest.out Sample.out

StatCalculator.out: StatCalculator.o RunningAverage.o RunningMax.o ReservoirSample.o HeavyHitters.o EnterpySource.o Histogram.o
	g++ StatCalculator.o RunningAverage.o RunningMax.o ReservoirSample.o HeavyHitters.o EnterpySource.o -o StatCalculator.out Histogram.o

EnterpySourceTest.out: EnterpySource.o EnterpySourceTest.o HeavyHitters.o
	g++ EnterpySource.o EnterpySourceTest.o HeavyHitters.o -o EnterpySourceTest.out

Sample.out: Sample.o EnterpySource.o ReservoirSample.o
	g++ Sample.o EnterpySource.o ReservoirSample.o -o Sample.out

RunningAverage.o: RunningAverage.cpp RunningAverage.hpp
	g++ -c RunningAverage.cpp -o RunningAverage.o

RunningMax.o: RunningMax.cpp RunningMax.hpp
	g++ -c RunningMax.cpp -o RunningMax.o

ReservoirSample.o: ReservoirSample.cpp ReservoirSample.hpp
	g++ -c ReservoirSample.cpp -o ReservoirSample.o

HeavyHitters.o: HeavyHitters.cpp HeavyHitters.hpp
	g++ -c HeavyHitters.cpp -o HeavyHitters.o

StatCalculator.o: StatCalculator.cpp
	g++ -c StatCalculator.cpp -o StatCalculator.o

EnterpySource.o: EnterpySource.cpp EnterpySource.hpp
	g++ -c EnterpySource.cpp -o EnterpySource.o

EnterpySourceTest.o: EnterpySourceTest.cpp
	g++ -c EnterpySourceTest.cpp -o EnterpySourceTest.o

Histogram.o: Histogram.cpp Histogram.hpp
	g++ -c Histogram.cpp -o Histogram.o

Sample.o: Sample.cpp
	g++ -c Sample.cpp -o Sample.o

clean:
	rm -f *.out *.o
