//
//  main.cpp
//  완주하지_못한_선수CPP
//
//  Created by 양승현 on 11/17/24.
//

#include <string>
#include <vector>
#include <unordered_map>
#define F(i,n) for(int i=0;i<n;i++)
using namespace std;

string solution(vector<string> participant, vector<string> completion) {
  string answer = "";
  unordered_map<string, int> info;
  F(i,participant.size()) {
    info[participant[i]] += 1;
  }
  
  F(i,completion.size()) {
    info[completion[i]] -= 1;
  }
  
  for ( auto elem: info) {
    if (elem.second > 0) {
      return elem.first;
    }
  }
  return "";
}
