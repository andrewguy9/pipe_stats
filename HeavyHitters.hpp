#ifndef HEAVY_HITTERS_HPP
#define HEAVY_HITTERS_HPP

#include <map>
#include <iterator>
#include <string>

class HeavyHittersTracker 
{
        private:
        
        size_t n_;
        std::map<std::string, double> colorToValue_;

        public:
       
        HeavyHittersTracker(size_t n);
        std::map<std::string, double>::iterator begin();
        std::map<std::string, double>::iterator end();
        void Update(std::string c, double v);
        
        private:

        std::string getSmallestColor();
       
};

#endif /* HEAVY_HITTERS_HPP */
