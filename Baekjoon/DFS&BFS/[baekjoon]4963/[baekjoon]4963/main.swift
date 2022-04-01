//
//  main.swift
//  [baekjoon]4963
//
//  Created by 양승현 on 2022/03/31.
//
//https://www.acmicpc.net/problem/4963

import Foundation

var direction = [(-1,0),(1,0),(-1,1),(-1,-1),(0,-1),(1,-1),(0,1),(1,1)]

while true {
    var WH = readLine()!.split(separator: " ").map{Int(String($0))!}
    if  WH[0] == 0 && WH[1] == 0{
        break;
    }
    var islandCount = 0;
    var visited = Array(repeating: Array(repeating: false, count: WH[0]), count: WH[1])
        var island = Array(repeating: [Int](), count: WH[1])
        for i in 0..<WH[1]{
            island[i] = readLine()!.split(separator: " ").map{Int(String($0))!}
        }
        for y in 0..<WH[1]{
            for x in 0..<WH[0]{
                if island[y][x] == 1 && !visited[y][x]{
                    bfs(x,y);
                    islandCount += 1
                }
            }
        }
    print(islandCount);
    func bfs(_ x : Int , _ y : Int) {
        visited[y][x] = true;
        for i in direction{
            let nx = x + i.0
            let ny = y + i.1
            if nx<0 || nx > WH[0] - 1 || ny < 0 || ny > WH[1] - 1 {
                continue
            }
            if !visited[ny][nx] && island[ny][nx] == 1{
                bfs(nx, ny)
                visited[ny][nx] = true;
            }
        }
    }
}
