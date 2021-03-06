//  [baekjoon]7576
//  Created by 양승현 on 2022/03/21.

import Foundation

var MN = readLine()!.split(separator: " ").map{Int($0)!}
var farm = Array(repeating: Array(repeating: 0, count: MN[0]), count: MN[1])

/**
 * 튜플
 * c++은 pair, 파이썬은 튜플로 쓰이는 자료형을 배열로 선언.
 * 특정 좌표를 기준으로 상 하 좌 우 방문을 위한 배열.
 */
var direction = [(0,1),(0,-1),(-1,0),(1,0)]
//bfs를 사용하기에 큐 할당
var queue = [(Int,Int)]()

for i in 0..<MN[1]{
    farm[i] = readLine()!.split(separator: " ").map{Int($0)!}
}
var day = farm

//farm에서의 시작 지점을 찾아야한다.
for y in 0..<MN[1]{
    for x in 0..<MN[0]{
        if farm[y][x] == 1 {
            queue.append((x,y))
            day[y][x] = 1
        }
    }
}

var res = 0
/**
 * swift에서는 큐를 이용해 맨 앞 원소를 출력하게 되면
 * 해당 원소 삭제 -> 뒤에 값들 앞으로 이전  총O(n) 시간이 걸린다.
 * 따라서 배열을 순차적으로 탐색하기 위한 index를 사용한다.
 *
 * 특정 day 마다 여러개의 좌표가 큐에 삽입되는데, 언제 day가 증가되는지는 걱정할 필요가 없다.
 * 특정 day마다 값을 다르게 증가시키기 때문에 이미 방문했다면 그냥 넘어간다.
 */
func bfs() {
    var index = 0
    
    while(index  != queue.count){
        
        for i in direction{
            //farm에서 익은 토마토 1 인 좌표값을 기준으로 상하좌우 값을 nx, ny 로 받음.
            let nx = queue[index].0 + i.0
            let ny = queue[index].1 + i.1
            //농장을 벗어났는가?
            if nx < 0 || nx > MN[0] - 1 || ny < 0 || ny > MN[1] - 1 {
                continue
            }
            //방문하지 않는 농장이 있다면
            if farm[ny][nx] == 0 {
                farm[ny][nx] = 1
                day[ny][nx] = day[ny - i.1][nx - i.0 ] + 1
                queue.append((nx, ny))
                res = day[ny][nx] - 1
            }
        }
        index += 1
    }
}
bfs()
// 2차원 배열의 0번째부터 마지막 열까지 특정 행을 i 로 받음(1차원 배열)
for i in day {
    if i.contains(0){
        res = -1
    }
}

print(res)

/**
 * Bfs 탐색 시 방문하는 day함수에서 -1 처리를 하지 않아서 -1 위치는 값이 다 0이었다.
 * 따라서 초기 farm 상자 값을 받은 그대로 day에 복사해주면서 해결했다.
 */
