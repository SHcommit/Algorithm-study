/// https://dev-with-precious-dreams.tistory.com/312

#include <iostream>
#include <vector>
#include <tuple>

using namespace std;

vector<pair<int,int>> directions = {{-1,0},{1,0},{0,1}, {0,-1}};

// 익숙해지기. visited 없애보자.
int _solution(vector<vector<int> > maps) {
    int height = maps.size();
    int width = maps[0].size();
    vector<vector<bool>> visited(height, vector<bool>(width, false));
    vector<tuple<int, int, int>> queue = { {0,0,1} };
    int idx = 0;
    while (queue.size() > idx) {
        auto [cx, cy, cnt] = queue[idx++];
        if (cy == height-1 && cx==width-1) return cnt;

        for (auto [dx, dy] : directions) {
            int nx = dx+cx, ny = dy+cy;

            if (nx<0 || ny<0 || nx >= width || ny >= height) continue;
            if (visited[ny][nx]) continue;
            if (maps[ny][nx] == 0) continue;
            queue.push_back(make_tuple(nx,ny,cnt+1));
            visited[ny][nx] = true;
        }
        
    }
    return -1;
}

int solution(vector<vector<int> > maps) {
    int height = maps.size();
    int width = maps[0].size();
    vector<tuple<int, int, int>> queue = {{0,0,1}};
    maps[0][0] = 0;
    int idx = 0;

    while (queue.size() > idx) {
        auto [cx, cy, cnt] = queue[idx++];
        if (cy==height-1 && cx==width-1) return cnt;
        for (const auto&[dx, dy] : directions) {
            int nx = dx+cx, ny = dy+cy;
            bool isOutOfBounds = nx<0 || ny<0 || nx>=width || ny>=height;
            if (isOutOfBounds || maps[ny][nx]==0) continue;
            queue.push_back({nx,ny,cnt+1}); // C++ 17부터는 make_tuple 안써도됨
            maps[ny][nx] = 0;
        }
    }
    return -1;
}

int main() {
    cout << solution({{1,0,1,1,1},{1,0,1,0,1},{1,0,1,1,1},{1,1,1,0,1},{0,0,0,0,1}}) << endl;
}