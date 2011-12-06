#include<string>
#include<iostream>
#include<sstream>

#include "EnterpySource.hpp"
#include "HeavyHitters.hpp"

int main() 
{
	EnterpySource es;
	HeavyHittersTracker hht(100);


	for(size_t i = 0; i < 1000000; i++) {
		int num = es.rand(1,100);

		std::stringstream stream;
		std::string str;
		stream << num;
		str = stream.str();

		hht.Update(str, 1);
	}

	std::cout << "Dumping " << std::endl;
	std::map<std::string, double>::iterator cur = hht.begin();
	for(cur = hht.begin(); cur != hht.end(); ++cur) {
		std::cout << "\t" << cur->first << "\t" << cur->second << " " << std::endl;
	}
	std::cout << "Dumping Done!" << std::endl;
}

