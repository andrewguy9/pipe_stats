#include <iostream>
#include <string>

#include "ReservoirSample.hpp"
#include "EnterpySource.hpp"

int main(int argc, char ** argv) 
{

        EnterpySource enterpySource;
        const size_t sampleSize = 1000;

        ReservoirSample<std::string> sample(sampleSize, &enterpySource);

        do {
                std::string line;

                std::cin >> line;
                std::cout << "read line '" << line << "'\n";

                if(std::cin.eof()) {
                        std::cout << "Done reading"<< std::endl;
                        break;
                } else if(std::cin.fail()) {
                        std::cout << "Error reading" << std::endl;
                        return 1;
                }

                sample.Insert(line);
        } while(std::cin.good());

        std::string * data = sample.GetData();
        size_t length = std::min(sampleSize, sample.GetInserted());
        for(size_t index = 0; index < length; index++) {
                std::cout << data[index] << std::endl;
        }
        
        return 0;
}
