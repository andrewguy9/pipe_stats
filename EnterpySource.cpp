#include "EnterpySource.hpp"

class EnterpySourceImpl : public EnterpySource
{
        public:
        EnterpySourceImpl()
        {
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

EnterpySource & GetEnterpySource()
{
        static bool bootstrapped = false;
        static EnterpySourceImpl impl;

        if( !bootstrapped) {
                bootstrapped = true;
                struct timeval curTime;
                gettimeofday(&curTime, NULL);
                srand(curTime.tv_sec);
        }

        return impl;
}

