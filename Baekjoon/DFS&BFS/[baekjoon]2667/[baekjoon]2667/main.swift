//
//  main.swift
//  [baekjoon]2667
//
//  Created by 양승현 on 2022/03/27.
//

import Foundation

var N = Int(readLine()!)!
var direction = [(-1,0),(1,0),(0,1),(0,-1)]
//지도
var map = Array(repeating: [Int](), count: N)
//결과
var res = [Int]()

for i in 0..<N {
    map[i] = readLine()!.map{Int(String($0))!}
}
var visited = Array(repeating: Array(repeating: false, count: N), count: N)
/**
 * 단지내 아파트를 0,0부터 N,N까지 전부 탐색하는데,
 * 방문하지 않았으면서 && 아파트 인 경우
 * bfs 탐색을 했고, 그 결과값을 res 에 저장했습니다.
 */
for y in 0..<N{
    for x in 0..<N {
        var house = 0;
        if visited[y][x] == false && map[y][x] == 1{
            visited[y][x] = true;
            house += 1
            bfs(x,y, &house)
            res.append(house)
        }
    }
}
func bfs(_ x :Int, _ y:Int , _ house : inout Int){
    
    for i in direction {
        let nx = x + i.0
        let ny = y + i.1
        
        if nx < 0 || nx > N - 1 || ny < 0 || ny > N - 1 {
            continue
        }
        if visited[ny][nx] == false && map[ny][nx] == 1 {
            visited[ny][nx] = true
            house += 1
            bfs(nx, ny, &house)
        }
    }
}
print("\(res.count)")

res.sorted().forEach{print($0)}
