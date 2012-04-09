#ifndef ENTERPY_SOURCE_HPP
#define ENTERPY_SOURCE_HPP

#include <sys/time.h>
#include<stdlib.h>

class EnterpySource
{
        public:
        virtual int rand() const = 0;
        virtual int rand(int low, int high) const = 0;
};

EnterpySource & GetEnterpySource();

#endif /* ENTERPY_SOURCE_HPP */
