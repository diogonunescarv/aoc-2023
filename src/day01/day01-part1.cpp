#include <iostream>
#include <fstream>
#include <string> 
using namespace std;

int main(){

   ifstream input("../../input/day01.txt");

   int sum = 0;
   string line;
   while (getline(input, line)) {

      // Find the first digit
      int first = -1;
      int last = -1;

      for (int i = 0; i < line.size(); ++i) {
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
         sum = sum + num;
      }
   }

   //printing the final result
   cout<<sum;
   
   input.close();

   return 0; 
}

