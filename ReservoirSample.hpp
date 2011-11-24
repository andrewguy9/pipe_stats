#ifndef RESERVOIR_SAMPLE_HPP
#define RESERVOIR_SAMPLE_HPP

#include<stdlib.h>

typedef size_t (EnterpyRoutine)(void);

template<class T>
class ReservoirSample {
	private:

	T *Sample;
	size_t Size;
	size_t Inserted;
	EnterpyRoutine * Rand;

	public:

	ReservoirSample(size_t size, EnterpyRoutine * rand) :
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
			index = Rand() % Inserted; //TODO Need to make uniform distrubition. 
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
