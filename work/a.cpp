#include <iostream>
#include <vector>
using namespace std;
int foo(int a, int b) { return a + b; }
int foo(int a)        { return a; }

int main() {
   vector<int> vi;
   vi.push_back(1);
   vi.push_back(2);
   vi.push_back(3);
   for (auto x : vi)
      cout << x << endl;
}
