#include <iostream>

#include "RunningAverage.hpp"
#include "RunningMax.hpp"

int main(int argc, char ** argv) {
	RunningAverage avg;
	RunningMax max;

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

		std::cout << "Read " << val << std::endl;
		avg.Insert(val);
		max.Insert(val);
	} while(std::cin.good());

	std::cout << "Avg is " << avg.Get() << std::endl;
	std::cout << "Max is " << max.Get() << std::endl;
	return 0;
}
