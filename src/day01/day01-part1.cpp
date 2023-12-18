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
      int firstPos = -1;
      for (int i = 0; i < line.size(); ++i) {
            if (isdigit(line[i])) {
                firstPos = i;
                break;
            }
      }
      char first = (firstPos != -1) ? line[firstPos] : '\0';

      // Find the last digit
      int lastPos = -1;
      for (int i = line.size() - 1; i >= 0; --i) {
         if (isdigit(line[i])) {
            lastPos = i;
            break;
         }
      }
      char last = (lastPos != -1) ? line[lastPos] : '\0'; 
     
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

