//
//  main.cpp
//  Gold5_토마토_CPP
//
//  Created by 양승현 on 11/2/24.
//

#include <iostream>
#include <vector>
using namespace std;

struct Point {
  int x;
  int y;
  
  Point(int x, int y) {
    this->x = x;
    this->y = y;
  }
};

Point Direction[4] = { Point(-1,0), Point(1,0), Point(0,1), Point(0,-1) };

struct Element {
  int day;
  Point point;
};

int main() {
  // insert code here...
  int height, width;
  int board[1000][1000] = {0,};
  vector<Point> queue;
  int index = 0;
  
  cin >> width >> height;
  for(int y = 0; y<height; y++) {
    for(int x = 0; x<width; x++) {
      cin >> board[y][x];
      if (board[y][x] == 1) {
        queue.push_back(Point(x,y));
      }
    }
  }
  while (index < static_cast<int>(queue.size())) {
    Point cur = queue[index++];
    for(auto d: Direction) {
      Point next = {Point(d.x+cur.x, d.y+cur.y)};
      if (0>next.x || 0>next.y || width <= next.x || height <= next.y) { continue; }
      if (board[next.y][next.x] > 0 || board[next.y][next.x] == -1) { continue; }
      board[next.y][next.x] += board[cur.y][cur.x] + 1;
      queue.push_back(next);
    }
  }
  int max = 0;
  for (int y=0; y<height; y++) {
    for (int x=0;x<width; x++) {
      if (board[y][x] > max) { max = board[y][x]; }
      if (board[y][x] == 0) {
        cout << -1;
        return 0;
      }
    }
  }
  cout << max - 1;
  return 0;
}
