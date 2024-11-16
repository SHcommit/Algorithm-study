//
//  main.cpp
//  Silver1_안전영역CPP
//
//  Created by 양승현 on 11/16/24.
//

#include <iostream>
#include <vector>
#include <cstring>

#define F(i,n) for (int i=0;i<n;i++)

using namespace std;
struct Point { int x; int y; };
Point directions[4] = { {-1, 0}, {1, 0}, {0, 1}, {0, -1} };
int n;
int area[100][100] = {0,};
bool visited[100][100] = {false,};
int maxHeight=0;
// 같은높이도잠김
void bfs(Point start, int height) {
  vector<Point> queue = {start};
  visited[start.y][start.x] = true;
  int index=0;
  while (index < queue.size()) {
    Point cur = queue[index++];
    for (auto d: directions) {
      Point next = {cur.x+d.x, cur.y+d.y};
      if (next.x < 0 || next.y < 0 || next.x >= n || next.y >= n) continue;
      if (visited[next.y][next.x] || area[next.y][next.x]<=height) continue;
      visited[next.y][next.x] = true;
      queue.push_back(next);
    }
  }
}

int main() {
  cin >> n;
  int ans = 1;
  F(y,n) {
    F(x,n) {
      cin >> area[y][x];
      if (area[y][x] > maxHeight) maxHeight = area[y][x];
    }
  }
  
  for (int h = 1; h<maxHeight;h++) {
    memset(visited, false, sizeof(visited));
    int numberOfSafeAreas = 0;
    F(y,n) {
      F(x,n) {
        if (visited[y][x] || area[y][x] <=h) continue;
        bfs({x,y}, h);
        numberOfSafeAreas++;
      }
    }
    if (numberOfSafeAreas > ans) ans=numberOfSafeAreas;
  }
  cout << ans;
  return 0;
}
