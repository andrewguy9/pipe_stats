#include <stdlib.h>
#include <iostream>

class RunningAverage
{
	private:

		double total;
		size_t n;

	public:
		RunningAverage() :
			total(0.0),
			n(0)
		{}

		~RunningAverage() {}

		double Get() {
			return total / n;
		}

		void Insert(double value) {
			total += value;
			n++;
		}
};


int main(int argc, char ** argv) {
	RunningAverage avg;

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
	} while(std::cin.good());

	std::cout << "Avg is " << avg.Get() << std::endl;
	return 0;
}
