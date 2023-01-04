//
//  main.swift
//  [baekjoon]6087
//
//  Created by 양승현 on 2023/01/04.
//

import Foundation

//MARK: - Properties
typealias Point = (x:Int, y:Int)
let Direction: [Point] = [(-1,0),(1,0),(0,1),(0,-1)]
let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (width,height) = (input[0],input[1])
var map = Array(repeating: [String](), count: height)
var start: Point = (-1,-1), end: Point = (-1,-1)
var visited = Array(repeating: Array(repeating: Int.max, count: width), count: height)

//MARK: - Init
var temp = true
for y in 0..<height {
    map[y] = readLine()!.map{String($0)}
    for x in 0..<width {
        if map[y][x] == "C" {
            if temp {
                start = (x,y)
                temp = false
            }else {
                end = (x,y)
            }
        }
    }
}
//for y in 0..<height {
//    map[y] = readLine()!.map{String($0)}
//    if let x = map[y].firstIndex(of: "C") {
//        if temp {
//            start = (x,y)
//            temp = false
//        } else {
//            end = (x,y)
//        }
//    }
//}

//MARK: - Helpers
func isOutOfBounds(point: Point) -> Bool {
    return point.x < 0 || point.x > width - 1 || point.y < 0 || point.y > height - 1
}

func bfs(start: Point) {
    var queue: [(point: Point, mirror: Int, prevDirect: Point)] = []
    var index = 0
    Direction.forEach { direct in
        queue.append((start,0,direct))
    }
    visited[start.y][start.x] = 0
    while queue.count != index {
        let (curPoint,mirror,prevDirect) = queue[index]
        index += 1
        for direct in Direction {
            let (nx, ny) = (direct.x+curPoint.x, direct.y+curPoint.y)
            var newMirror = mirror
            if isOutOfBounds(point: (nx,ny)) { continue }
            if prevDirect != direct { newMirror += 1 }
            if map[ny][nx] != "*" && visited[ny][nx] >= newMirror {
                visited[ny][nx] = newMirror
                queue.append(((nx,ny), newMirror, direct))
            }
        }
    }
}

func solution() {
    bfs(start: start)
    print(visited[end.y][end.x])
}
solution()
