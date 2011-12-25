#include "HeavyHitters.hpp"

HeavyHittersTracker::HeavyHittersTracker(size_t n) :
        n_(n),
        colorToValue_()
{
}

std::map<std::string, double>::iterator HeavyHittersTracker::begin()
{
        std::map<std::string, double>::iterator iterator;
        iterator = colorToValue_.begin(); 

        return iterator;
}

std::map<std::string, double>::iterator HeavyHittersTracker::end()
{
        std::map<std::string, double>::iterator iterator;
        iterator = colorToValue_.end(); 

        return iterator;
}

void HeavyHittersTracker::Update(std::string c, double v) 
{
        std::map<std::string, double>::iterator c_iterator;
        c_iterator = colorToValue_.find(c);

        if(c_iterator != colorToValue_.end()) {

                // Color already in map
                double old_v = c_iterator->second;
                colorToValue_.erase(c);
                colorToValue_[c] = old_v + v;
        } else {
                // Color is not in map, add it.

                if(colorToValue_.size() < n_) {

                        // Were not full, so just insert.
                        colorToValue_[c] = v;
                } else {
                        // We are full, replace smallest.
                        std::string smallest_color = getSmallestColor();
                        double old_v = colorToValue_[smallest_color];
                        colorToValue_.erase(smallest_color);
                        colorToValue_[c] = old_v + v;
                }
        }
}

std::string HeavyHittersTracker::getSmallestColor() 
{
        std::string smallest_color;
        double smallest_value;

        std::map<std::string, double>::iterator iterator;
        iterator = colorToValue_.begin(); 

        smallest_color = iterator->first;
        smallest_value = iterator->second;
        ++iterator;

        while(iterator != colorToValue_.end()) {
                if(smallest_value >= iterator->second) {
                        smallest_color = iterator->first;
                        smallest_value = iterator->second;
                }
                ++iterator;
        }
        return smallest_color;
}

