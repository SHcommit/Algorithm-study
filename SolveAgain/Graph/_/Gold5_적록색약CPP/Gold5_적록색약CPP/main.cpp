//
//  main.cpp
//  Gold5_적록색약CPP
//
//  Created by 양승현 on 11/16/24.
//

/// 이거 그 으으으으으
/// 적록색약일 경우에는 bfs 안에서 isREqualToG여부에따라서 R, G를 탐색한다면 R || G가 아닐 때에만 continue하는건데 이부분이 정확하지 않았음

#include <iostream>
#include <vector>
#include <cstring>
#define F(i,n) for (int i=0;i<n;i++)

using namespace std;

struct Point { int x; int y; };
Point directions[4] = {{-1,0}, {1,0}, {0,1}, {0,-1}};
char board[100][100] = {' ',};
bool visited[100][100]={false,};
int n;

void bfs(Point start, bool isREqualToG) {
  char target = board[start.y][start.x];
  vector<Point> queue = {start};
  visited[start.y][start.x] = true;
  int index=0;
  while (index<queue.size()) {
    Point cur = queue[index++];
    for (auto d: directions) {
      Point next = {cur.x+d.x,cur.y+d.y};
      if (next.x<0||next.y<0||next.x>=n||next.y>=n) continue;
      if (visited[next.y][next.x]) continue;
      if (isREqualToG) {
        if (target == 'R' || target == 'G') {
          if (!(board[next.y][next.x] == 'R' || board[next.y][next.x] == 'G')) continue;
        } else if (board[next.y][next.x] != target) continue;
      } else if (board[next.y][next.x] != target) continue;
      visited[next.y][next.x] = true;
      queue.push_back(next);
    }
  }
}

int main() {
  cin >> n;
  int f = 0; int s = 0;
  F(y,n) {
    F(x,n) {
      cin>>board[y][x];
    }
  }
  F(y,n) {
    F(x,n) {
      if (visited[y][x]) continue;
      bfs({x,y}, false);
      f++;
    }
  }
  memset(visited,false,sizeof(visited));
  F(y,n) {
    F(x,n) {
      if (visited[y][x]) continue;
      bfs({x,y}, true);
      s++;
    }
  }
  cout << f << " " << s;
  return 0;
}
