//  [baekjoon]14716
//  Created by 양승현 on 2022/04/02.

import Foundation
//M = 세로, N = 가로
var MN = readLine()!.split(separator: " ").map{Int(String($0))!}
//주어진 현수막을 필터링한 값
var filter = Array(repeating: [Int](), count: MN[0])
//탐색 위치
var direction = [(1,0),(1,1),(1,-1),(0,1),(0,-1),(-1,0),(-1,-1),(-1,1)]
//방문 여부
var visited = Array(repeating: Array(repeating: false, count: MN[1]), count: MN[0])

for i in 0..<MN[0]{
    filter[i] = readLine()!.split(separator: " ").map{Int(String($0))!}
}
//단어 수
var word = 0;

for y in 0..<MN[0]{
    for x in 0..<MN[1]{
        if !visited[y][x] && filter[y][x] == 1 {
            visited[y][x] = true
            bfs(x,y)
            word += 1
        }
    }
}
func bfs (_ x :Int ,_ y : Int){
    for i in direction{
        let ny = i.0 + y
        let nx = i.1 + x
        if ny < 0 || ny > MN[0] - 1  || nx < 0 || nx > MN[1] - 1{
            continue
        }
        if !visited[ny][nx] && filter[ny][nx] == 1 {
            visited[ny][nx] = true
            bfs(nx, ny)
        }
    }
}
print(word)
