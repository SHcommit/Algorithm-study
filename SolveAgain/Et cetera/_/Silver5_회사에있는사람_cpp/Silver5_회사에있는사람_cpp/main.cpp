//
//  main.cpp
//  Silver5_회사에있는사람_cpp
//
//  Created by 양승현 on 11/2/24.
//

#include <iostream>
#include <vector>
#include <map>
#include <algorithm>
using namespace std;

bool comparer(string lhs, string rhs) {
  return lhs > rhs;
}

int main() {
  
  map<string, string> dict;
  vector<string> res;
  int n;
  cin >> n;
  for (int i=0;i<n;i++) {
    string name, state;
    cin >> name >> state;
    dict[name] = state;
  }
  for (auto& tuple: dict) {
    if (tuple.second == "enter") {
      res.push_back(tuple.first);
    }
  }
  sort(res.begin(), res.end(), comparer);
  for (auto name: res) {
    cout << name << endl;
  }
  
  return 0;
}
