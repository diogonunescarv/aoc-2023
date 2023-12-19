#include <iostream>
#include <fstream>
#include <string> 
#include <map> 
#include <sstream>
using namespace std;

int main(){

   map<string, string> numbers = {
        {"one", "1"},
        {"two", "2"},
        {"three", "3"},
        {"four", "4"},
        {"five", "5"},
        {"six", "6"},
        {"seven", "7"},
        {"eight", "8"},
        {"nine", "9"}
    };

   ifstream input("../../input/tst-day1.txt");

   int sum = 0;
   string line;
   while (getline(input, line)) {

      int first = -1;
      int last = -1;

      for (int i = 0; i < line.size(); ++i) {
        
         // Substituir as ocorrências de chave por valor na linha
        for (map<string, string>::iterator it = numbers.begin(); it != numbers.end(); ++it) {
            size_t pos = line.find(it->first);
            const size_t notFound = string::npos;
         
            if (pos != notFound) {
               line.replace(pos, it->first.length(), it->second);
                //pos = line.find(it->first, pos + it->second.length());
               cout<<pos<<endl;
               cout<<line<<endl;

            }
            
        }

         
         if (isdigit(line[i])) {
            if(first == -1){
               first = line[i];
            }
            last = line[i];
         }

      }

     // Making the final number and adding to the variable sum
     if (isdigit(first) && isdigit(last)) {
         int num = (first - '0') * 10 + (last - '0');
         cout<<num<<endl;
         sum = sum + num;
      }
   }

    cout<<sum;

   input.close();

   return 0; 
}

