#include <iostream>
#include <iomanip>
#include<stdlib.h>
#include <sys/time.h>

#include "RunningAverage.hpp"
#include "RunningMax.hpp"
#include "ReservoirSample.hpp"
#include "HeavyHitters.hpp"

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

void printHisogram(size_t *data, size_t sampleSize) {
	qsort(data, sampleSize, sizeof(size_t), compare_size_t);
	
	int numPercentiles = 15;
	int percentiles[] = {10,20,30,40,50,60,70,80,90,95,96,97,98,99,100};

	size_t max = data[sampleSize - 1];
	for(size_t cur = 0; cur < numPercentiles; cur++) {
		size_t index = (percentiles[cur] * sampleSize) / 100;
		if(index >= sampleSize) {
			index = sampleSize - 1;
		}
		size_t num = data[index];
		std::cout << "\t" << std::setw(3) << percentiles[cur] << "% ";
		for(int star = 0; star < (num * 60) / max; star++) {
			std::cout << "*";
		}
		std::cout << std::endl;
	}
	std::cout << "Sample Dump Done" << std::endl;
}

void printHHT(
		std::map<std::string, double>::iterator begin, 
		std::map<std::string, double>::iterator end,
		std::string units) 
{
	std::cout << "Dumping " << units << std::endl;
	std::map<std::string, double>::iterator cur = begin;
	for(cur = begin; cur != end; ++cur) {
		std::cout << "\t" << cur->first << "\t" << cur->second << " " << units << std::endl;
	}
	std::cout << "Dumping Done!" << std::endl;
}

int main(int argc, char ** argv) {

	initMyRand();

	RunningAverage avg;
	RunningMax max;
	const size_t sampleSize = 1000;
	ReservoirSample<size_t> sample(sampleSize, myRand);
	HeavyHittersTracker hhtSize(20);

	do {
		double size;
		std::string ext;

		std::cin >> size;
		std::cin >> ext;

		if(std::cin.eof()) {
			std::cout << "Done reading"<< std::endl;
			break;
		} else if(std::cin.fail()) {
			std::cout << "Error converting value" << std::endl;
			return 1;
		}

		avg.Insert(size);
		max.Insert(size);
		sample.Insert(size);
		hhtSize.Update(ext, ((double)size)/100000.0);
	} while(std::cin.good());

	std::cout << "Avg is " << avg.Get() << std::endl;
	std::cout << "Max is " << max.Get() << std::endl;
	printHisogram(sample.GetData(), sampleSize);
	printHHT(hhtSize.begin(), hhtSize.end(), "mb");
	
	return 0;
}
