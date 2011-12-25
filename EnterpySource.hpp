#ifndef ENTERPY_SOURCE_HPP
#define ENTERPY_SOURCE_HPP

#include <sys/time.h>
#include<stdlib.h>

class EnterpySource
{
        public:
        EnterpySource()
        {
                struct timeval curTime;
                gettimeofday(&curTime, NULL);
                srand(curTime.tv_sec);
        }

        int rand() const
        {
                return ::rand();
        }

        int rand(int low, int high) const
        {
                int spread = high - low;
                return (rand() % spread) + low;
        }
};

#endif /* ENTERPY_SOURCE_HPP */
