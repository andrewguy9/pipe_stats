CPP_C = g++
CPP_C_FLAGS = -g -Wall

%.o:
	$(CPP_C) $(CPP_C_FLAGS) -o $@ -c $<

%.out:
	$(CPP_C) $(CPP_C_FLAGS) -o $@ $^

all: EnterpySourceTest.out Sample.out
	echo "All done"

EnterpySourceTest.out: EnterpySource.o EnterpySourceTest.o HeavyHitters.o

Sample.out: Sample.o EnterpySource.o ReservoirSample.o

ReservoirSample.o: ReservoirSample.cpp ReservoirSample.hpp

HeavyHitters.o: HeavyHitters.cpp HeavyHitters.hpp

EnterpySource.o: EnterpySource.cpp EnterpySource.hpp

EnterpySourceTest.o: EnterpySourceTest.cpp

Sample.o: Sample.cpp

clean:
	rm -f *.out *.o
