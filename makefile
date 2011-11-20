StatCalculator.out: StatCalculator.o RunningAverage.o
	g++ StatCalculator.o RunningAverage.o -o StatCalculator.out

RunningAverage.o: RunningAverage.cpp RunningAverage.hpp
	g++ -c RunningAverage.cpp -o RunningAverage.o

StatCalculator.o: StatCalculator.cpp
	g++ -c StatCalculator.cpp -o StatCalculator.o

clean:
	rm -f *.out *.o
