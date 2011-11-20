#ifndef RUNNING_AVERAGE_H
#define RUNNING_AVERAGE_H

#include <stdlib.h>

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

#endif /* RUNNING_AVERAGE_H */
