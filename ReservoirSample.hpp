#ifndef RESERVOIR_SAMPLE_HPP
#define RESERVOIR_SAMPLE_HPP

#include<stdlib.h>
#include "EnterpySource.hpp"

template<class T>
class ReservoirSample {
	private:

	T *Sample;
	size_t Size;
	size_t Inserted;
	EnterpySource * Rand;

	public:

	ReservoirSample(size_t size, EnterpySource * rand) :
			Sample(new T[size]),
			Size(size),
			Inserted(0),
			Rand(rand)
	{ }
	
	~ReservoirSample() {
		delete [] Sample;
	}

	void Insert(T data) {
		size_t index;
		if(Inserted < Size) {
			index = Inserted;
		} else {
			index = Rand->rand(0, Inserted);
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
