//  [baekjoon]2178
//  Created by 양승현 on 2022/03/16.


import Foundation
/**
 *map은 지도가 저장되는 변수
 *visited는 n-1, m-1 (nm[0] - 1 , nm[1] - 1) 에 도달했을 때 최단 경우가 저장된다.
 *큐를 사용했다. 특정 좌표가 주어지면 그 좌표를 기준으로 상 하 좌 우
 * //for xy in [(1,0),(-1,0),(0,1),(0,-1)]
 * 포 인 구문을 4번 실행하면서 특정 좌표를 기준으로 탐색하지 않은 map이 있다면? 그 위치의 값은 1이다.
 * 0으로 바꿔주면서 탐색했음을 표시하기위해 방문한 위치의 visited[ny][nx]를 증가시킨다.
 * 의 반복이다.
 *
 *for i in 0..<nm[0] {map[i] = readLine()!.map{Int(String($0))!}} 포문에서
 *배열의 특정 열의 행을 초기화 시키는 방법!*
 */
var nm = readLine()!.split(separator: " ").map{Int($0)!}
var map = Array(repeating: Array(repeating: 0, count: nm[1]), count: nm[0])
var visited = map
var queue = [(Int,Int)]()

for i in 0..<nm[0]{
    map[i] = readLine()!.map{Int(String($0))!}
}

func bfs (startX x :Int, startY y :Int){
    queue.append((x,y))
    map[y][x] = 0
    visited[y][x] = 1
    while(!queue.isEmpty){
        let node = queue.removeFirst()
        
        for xy in [(1,0),(-1,0),(0,1),(0,-1)]{
            //상하좌우
            var (nx,ny) = (node.0 + xy.0 , node.1 + xy.1 )
    
            if isOverEdge(nx: nx, ny: ny) {
                continue
            }
            if map[ny][nx] == 1 {
                map[ny][nx] = 0
                queue.append((nx,ny))
                visited[ny][nx] = visited[node.1][node.0] + 1
            }
        }
    }
}
func isOverEdge( nx : Int, ny :Int) -> Bool {
    return nx < 0 || nx > nm[1] - 1 || ny < 0 || ny > nm[0] - 1 ? true : false
}

bfs(startX: 0, startY: 0)

print(visited[nm[0]-1][nm[1]-1])
