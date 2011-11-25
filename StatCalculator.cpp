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

int compare_size_t(const void *va, const void *vb) {
	const size_t *a = (size_t *) va;
	const size_t *b = (size_t *) vb;

	if(*a<*b) {
		return -1;
	} else if(*a==*b) {
		return 0;
	} else {
		return 1;
	}
}

int main(int argc, char ** argv) {

	initMyRand();

	RunningAverage avg;
	RunningMax max;
	const size_t sampleLength = 100;
	ReservoirSample<size_t> sample(sampleLength, myRand);

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
	qsort(data, sampleLength, sizeof(size_t), compare_size_t);
	std::cout << "Sample Dump " << std::endl;
	int percentiles[] = {10,20,30,40,50,60,70,80,90};
	int numPercentiles = 9;
	for(size_t percentile = 0; percentile < numPercentiles; percentile++) {
		size_t index = (percentiles[percentile] * sampleLength) / 100;
		std::cout << "\t" << percentiles[percentile] << "% " << data[index] << std::endl;
	}
	std::cout << "Sample Dump Done" << std::endl;

	return 0;
}
