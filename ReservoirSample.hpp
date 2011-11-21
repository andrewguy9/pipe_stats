#ifndef RESERVOIR_SAMPLE_HPP
#define RESERVOIR_SAMPLE_HPP

#include<stdlib.h>

template<class T>
class ReservoirSample {
	private:

	T *Sample;
	size_t Size;
	size_t Inserted;

	public:

	ReservoirSample(size_t size) :
			Sample(new T[size]),
			Size(size),
			Inserted(0)
	{ }
	
	~ReservoirSample() {
		delete [] Sample;
	}

	void Insert(T data) {
		size_t index;
		if(Inserted < Size) {
			index = Inserted;
		} else {
			index = rand() % Inserted; //TODO Need to make uniform distrubition. 
		}

		if(index < Size) {
			Sample[index] = data;
			Inserted++;
		}
	}

	T* GetData() {
		return Sample;
	}
};

#endif /* RESERVOIR_SAMPLE_HPP */
