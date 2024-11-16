//
//  main.cpp
//  Silver4_나는야_포켓몬_마스터_이다솜CPP
//
//  Created by 양승현 on 11/16/24.
//

/// 음.. 시간초과..  맵 사용법은 swift랑 같은데 ㅇㅅㅇ..
#include <iostream>
#include <unordered_map>
#include <string>
#define F(i,n) for(int i=0;i<n;i++)
using namespace std;
int n, m;
int main() {
  ios::sync_with_stdio(false);
  cin.tie(NULL);
  
  cin >> n >> m;
  unordered_map<string, string> dict;
  F(i,n) {
    string name;
    cin >> name;
    dict[name] = to_string(i+1);
    dict[to_string(i+1)]=name;
  }
  F(i,m) {
    string input;
    cin >> input;
    cout<<dict[input]<<endl;
  }
  return 0;
}
