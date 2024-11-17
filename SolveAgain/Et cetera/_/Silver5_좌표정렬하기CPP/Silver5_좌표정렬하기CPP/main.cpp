//
//  main.cpp
//  Silver5_좌표정렬하기CPP
//
//  Created by 양승현 on 11/17/24.
//

#include <iostream>
#include <algorithm>
#include <vector>
#define F(i,n) for(int i=0;i<n;i++)

/// 짜잔!!
/// 소팅은 algorithm 라이브러리안에 sort(_:_:_:) 쓰면됨.
/// comparer 함수로 소팅을 직접 정해서 함수를 세번째 인자값으로 전달하면 됨.
///
/// 백터를 소팅할 때는 begin(), end()를 넣어주면됨. 그 이외에는 배열의 첫 원소, 마지막 원소의 포인터 느낌이랄까.. 이걸 넣어주면됨.
///
///
/// 또 하나 초대박;;;;.
/// endl 쓰면 시간초과나는데 "\n"으로 줄바꿈하면 시간초과 안남
using namespace std;

struct Point {
  int x; int y;
};

bool comparer(Point lhs, Point rhs) {
  if (lhs.x == rhs.x) {
    return lhs.y < rhs.y;
  } else return lhs.x < rhs.x;
}

int main() {
  ios::sync_with_stdio(false);
  cin.tie(NULL);
  
  int n;
  cin >> n;
  vector<Point> points;
  F(i,n) {
    Point input = {0,0};
    cin >> input.x >> input.y;
    points.push_back(input);
  }
  sort(points.begin(), points.end(), comparer);
  F(i, points.size()) {
    cout << points[i].x << " " << points[i].y << "\n";
  }
  return 0;
}

