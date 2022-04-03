//
//  main.swift
//  [baekjoon]2589
//
//  Created by 양승현 on 2022/04/03.
//

import Foundation
//HW[0] == 세로 , HW[1] == 가로
var HW = readLine()!.split(separator: " ").map{Int(String($0))!}
//탐색방향
var direction = [(-1,0),(1,0),(0,-1),(0,1)]
var map = Array(repeating: [String](), count: HW[0])

for i in 0..<HW[0]{
    map[i] = readLine()!.map{String($0)}
}
//최단경로
var max = 0

for y in 0..<HW[0]{ //세로
    for x in 0..<HW[1]{ //가로
        if map[y][x] == "L"{ //특정 좌표 (x,y)가 길인가?
            let day = bfs(x,y) //bfs탐색
            if max < day { max = day } //최단 경로인가?
        }
    }
}
func bfs(_ x :Int , _ y : Int ) -> Int{
    //bfs탐색 결과 저장
    var shortPath = Array(repeating: Array(repeating: -1, count: HW[1]), count: HW[0])
    //최단 경로 길이
    var maxPath = 0
    var queue = [(Int,Int)]()
    queue.append((x,y))
    //시작지점 값 0
    shortPath[y][x] = 0
    while(!queue.isEmpty){
        let (dx,dy) = queue.removeFirst()
        for i in direction{
            let nx = dx + i.0
            let ny = dy + i.1
            if ny < 0 || ny > HW[0] - 1 || nx < 0 || nx > HW[1] - 1{
                continue
            }
            if map[ny][nx] == "L" && shortPath[ny][nx] == -1 {
                //특정 지역 이동 시 1시간
                shortPath[ny][nx] = shortPath[dy][dx] + 1
                if maxPath < shortPath[ny][nx] { maxPath = shortPath[ny][nx]}
                queue.append((nx,ny))
            }
        }
    }
    return maxPath
}
print(max)
