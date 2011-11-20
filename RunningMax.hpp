#ifndef RUNNING_MAX_H
#define RUNNING_MAX_H

#include <stdlib.h>

class RunningMax
{
	private:
		double max;

	public:
		RunningMax() :
			max(0.0)
		{}

		~RunningMax()
		{}

		double Get() {
			return max;
		}

		void Insert(double value) {
			if(value > max) {
				max = value;
			}
		}
};

#endif /* RUNNING_MAX_H */
