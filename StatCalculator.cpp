#include <iostream>
#include<stdlib.h>
#include <sys/time.h>

#include "RunningAverage.hpp"
#include "RunningMax.hpp"
#include "ReservoirSample.hpp"

void initMyRand() {
	struct timeval curTime;

	gettimeofday(&curTime, NULL);

	srand(curTime.tv_sec);
}

EnterpyRoutine myRand;
size_t myRand() {
	return rand();
}

int main(int argc, char ** argv) {

	initMyRand();

	RunningAverage avg;
	RunningMax max;
	ReservoirSample<size_t> sample(10, myRand);

	do {
		double val;
		std::cin >> val;

		if(std::cin.eof()) {
			std::cout << "Done reading"<< std::endl;
			break;
		} else if(std::cin.fail()) {
			std::cout << "Error converting value" << std::endl;
			return 1;
		}

		avg.Insert(val);
		max.Insert(val);
		sample.Insert(val);
	} while(std::cin.good());

	std::cout << "Avg is " << avg.Get() << std::endl;
	std::cout << "Max is " << max.Get() << std::endl;

	size_t *data = sample.GetData();
	std::cout << "Sample Dump " << std::endl;
	for(size_t index = 0; index < 10; index++) {
		std::cout << "\t" << data[index] << std::endl;
	}
	std::cout << "Sample Dump Done" << std::endl;

	return 0;
}
