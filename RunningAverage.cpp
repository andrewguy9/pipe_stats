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
	for(int i=0; i<argc; i++) {
		double val = atof(argv[i]);
		std::cout << "adding " << val << std::endl;

		avg.Insert(val);
	}

	std::cout << "Avg is " << avg.Get() << std::endl;
	return 0;
}
