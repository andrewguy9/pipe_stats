StatCalculator.out: StatCalculator.o RunningAverage.o RunningMax.o ReservoirSample.o HeavyHitters.o
	g++ StatCalculator.o RunningAverage.o RunningMax.o ReservoirSample.o HeavyHitters.o -o StatCalculator.out

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

clean:
	rm -f *.out *.o
