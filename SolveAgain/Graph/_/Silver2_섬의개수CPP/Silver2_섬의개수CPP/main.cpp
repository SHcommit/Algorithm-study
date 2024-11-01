//
//  main.cpp
//  Silver2_섬의개수CPP
//
//  Created by 양승현 on 11/2/24.
//

#include <iostream>
#include <vector>
#include <cstring>
using namespace std;

struct Point {
  int x,y;
  Point(int x, int y) { this->x=x; this->y=y; }
};
int board[50][50] = {0,};
int visited[50][50] = {0,};
Point Direction[8] = {
  Point(-1, 0), Point(1, 0), Point(0, 1), Point(0, -1),
  Point(-1, 1), Point(1, 1), Point(-1, -1), Point(1, -1)
};

int main() {
  // insert code here...
  while (true) {
    int height, width;
    
    cin >> width >> height;
    if (width == 0) break;
    memset(board, 0, sizeof(board));
    memset(visited, 0, sizeof(visited));
    int ans = 0;
    
    for (int y = 0; y<height; y++) {
      for (int x = 0; x<width; x++) {
        cin >> board[y][x];
      }
    }
    
    for (int y = 0; y<height; y++) {
      for (int x = 0; x<width; x++) {
        if (board[y][x] == 1 && visited[y][x] == 0) {
          ++ans;
          
          /// bfs
          vector<Point> queue;
          int index = 0;
          queue.push_back(Point(x, y));
          visited[y][x] = 1;
          while (index < static_cast<int>(queue.size())) {
            Point cur = queue[index++];
            for (auto d: Direction) {
              Point next = Point(d.x+cur.x, d.y+cur.y);
              if (next.x < 0 || next.y < 0 || next.x >= width || next.y >= height) { continue; }
              if (visited[next.y][next.x] || board[next.y][next.x] == 0) { continue; }
              visited[next.y][next.x] = 1;
              queue.push_back(next);
            }
          }
        }
      }
    }
    cout << ans << endl;
  }
  return 0;
}
