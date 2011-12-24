#include "Histogram.hpp"

#include<iostream>
#include <iomanip>

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

