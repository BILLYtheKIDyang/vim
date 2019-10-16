#include <iostream>
#include <vector>

using namespace std;

int main() {
   vector<int> vi;
   vi.push_back(1);
   vi.push_back(2);
   vi.push_back(3);
   vi.push_back(4);

   for (auto x : vi) {
      cout << x << endl;
   }
}
