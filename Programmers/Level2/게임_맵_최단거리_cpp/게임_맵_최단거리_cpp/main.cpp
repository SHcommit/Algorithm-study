//
//  main.cpp
//  게임_맵_최단거리_cpp
//
//  Created by 양승현 on 11/16/24.
//

#include<iostream>
#include<vector>
#include<climits>
#define F(i,n) for(int i=0;i<n;i++)

using namespace std;

int visited[100][100] = {0,};
struct Point { int x; int y;};
Point directions[4] = {{-1,0},{1,0},{0,1},{0,-1}};
int width = 0;
int height = 0;

int solution(vector<vector<int> > maps) {
  height = maps.size();
  width = maps[0].size();
  F(y,height) {
    F(x,width) {
      visited[y][x] = INT_MAX;
    }
  }
  vector<Point> queue = {{0,0}};
  visited[0][0] = 1;
  int index = 0;
  
  while (index < queue.size()) {
    Point cur = queue[index++];
    for (auto d: directions) {
      Point next = {cur.x+d.x, cur.y+d.y};
      if (next.x<0||next.y<0||next.x>=width||next.y>=height) continue;
      if (maps[next.y][next.x] == 0 || visited[next.y][next.x] < (visited[cur.y][cur.x]+1)) continue;
      visited[next.y][next.x] = visited[cur.y][cur.x] + 1;
      queue.push_back(next);
    }
  }
  return visited[height-1][width-1] == INT_MAX ? -1 : visited[height-1][width-1];
}
