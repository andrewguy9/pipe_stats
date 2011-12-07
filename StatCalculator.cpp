#include <iostream>

#include "RunningAverage.hpp"
#include "RunningMax.hpp"
#include "ReservoirSample.hpp"
#include "HeavyHitters.hpp"
#include "EnterpySource.hpp"
#include "Histogram.hpp"

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

	EnterpySource enterpySource;

	RunningAverage avg;
	RunningMax max;
	const size_t sampleSize = 1000;
	ReservoirSample<size_t> sample(sampleSize, &enterpySource);
	HeavyHittersTracker hhtSize(20);
	HeavyHittersTracker hhtFiles(20);

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
		hhtFiles.Update(ext, 1);
	} while(std::cin.good());

	std::cout << "Avg is " << avg.Get() << std::endl;
	std::cout << "Max is " << max.Get() << std::endl;
	printHisogram(sample.GetData(), sampleSize);
	printHHT(hhtSize.begin(), hhtSize.end(), "mb");
	printHHT(hhtFiles.begin(), hhtFiles.end(), "Files");
	
	return 0;
}
