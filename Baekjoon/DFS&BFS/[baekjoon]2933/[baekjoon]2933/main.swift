//
//  main.swift
//  [baekjoon]2933
//
//  Created by 양승현 on 2023/01/01.
//

/*
    막대를 던져 맞은 클러스터가 여러 개 있었다면 좀 어려웠을 것인데 다행히 한개라서
    땅에 닿지 않은 클러스터만 bfs 탐색 후 불안정한 클러스터 위치를 Fix시켰다.
    다만 주의할 점은 width height는 2차원 배열에서 맨 아래, 맨 오른쪽을 의미하기 때문에
    -를 통한 감소가 아니라 + 를 통한 증가로 좌표들을 지정해야했다. 살짝 했갈렸지만 바로 파악했다.
 */

import Foundation
//MARK: - Properties
let direction = [(-1,0),(1,0),(0,1),(0,-1)]
let input = readLine()!.split(separator: " ").map{Int(String($0))!}
let width = input[1] , height = input[0]
var map = Array(repeating: [String](), count: height)
var visited = [[Bool]]()
//좌인지 우인지 파악하기 위한 변수
var i = 0

//MARK: - Input
for y in 0..<height {
    let line = readLine()!.map{String($0)}
    map[y] = line
}

let throwCount = Int(readLine()!)!
let throwHeights = readLine()!.split(separator: " ").map{ height - 1 - (Int(String($0))! - 1)}

// 던진 막대에 특정한 "x"가 맞았다면 제거
func findItemInRow(at height: Int, isleftToRight ltr: Bool? = nil) {
    guard let _ = ltr else {
        for x in stride(from: width - 1, through: 0, by: -1) {
            if map[height][x] == "x" {
                map[height][x] = "."
                return
            }
        }
        return
    }
    for x in 0..<width {
        if map[height][x] == "x" {
            map[height][x] = "."
            return
        }
    }
}

//맵을 벗어났는가?
func isOutOfMap(nx: Int, ny: Int) -> Bool {
    if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1 {
        return true
    }
    return false
}

// 클러스터 집단이 bottom에 닿아 있는가? = 안전
func isSafetyCluster(y: Int) -> Bool {
    return y == height - 1 ? true : false
}

//만약 isSafety가 false라면 클러스터는 떠있는 상태.
func bfs(x: Int, y: Int) -> (Bool,[(Int,Int)]?) {
    var isSafety = false
    var queue = [(x,y)]
    var index = 0
    while queue.count != index {
        let (curX,curY) = queue[index]
        if !isSafety { isSafety = isSafetyCluster(y: curY) }
        direction.forEach{ dx,dy in
            let (nx,ny) = (curX+dx,curY+dy)
            if isOutOfMap(nx: nx, ny: ny) { return }
            if !visited[ny][nx] && map[ny][nx] == "x" {
                visited[ny][nx] = true
                queue.append((nx,ny))
            }
        }
        index += 1
    }
    return isSafety ? (isSafety,nil) : (isSafety,queue)
}

// 클러스터를 파악하고 떠있는 클러스터를 찾아 unsafetyCluster에 저장
func updateMap() {
    visited = Array(repeating: Array(repeating: false, count: width), count: height)
    var isSafety = true
    var unsafetyCluster = [(Int,Int)]()
    for y in 0..<height {
        for x in 0..<width {
            if map[y][x] == "x" && !visited[y][x] {
                visited[y][x] = true
                let temp = bfs(x: x, y: y)
                if !temp.0 {
                    isSafety = temp.0
                    unsafetyCluster = temp.1!
                }
                
            }
        }
    }
    // 클러스터 집단 떠 있다는 뜻. 내려가야함.
    //일단 맵에 떠있는 클러스터 지우고 -> fixUnsafetyCluster(cluster:)를 통해 내려가도록 고침
    if !isSafety {
        unsafetyCluster.forEach{ (x,y) in
            map[y][x] = "."
        }
        fixUnsafetyCluster(cluster: &unsafetyCluster)
    }
}
// 클러스터가 안전하게 땅이나 다른 집단에 닿을 때 까지 1칸씩 내려감.
func fixUnsafetyCluster(cluster: inout [(Int,Int)]) {
    var isSafety = false
    while !isSafety {
        var visit = Array(repeating: Array(repeating: false, count: width), count: height)
        cluster = cluster.map { (x,y) in
            visit[y+1][x] = true
            return (x,y+1)
        }
       isSafety = checkIsSafedCluster(cluster: cluster, visit: visit)
    }
    cluster.forEach { (x,y) in
        map[y][x] = "x"
    }
}

// 클러스터가 한칸씩 내려가기 위하도록 클러스터 좌표 수정.
func checkIsSafedCluster(cluster: [(Int,Int)], visit: [[Bool]]) -> Bool {
    var index = 0
    while cluster.count != index {
        let (x,y) = cluster[index]
        if y == height - 1 {
            return true
        }
        let (dx,dy) = (0,1)
        let (nx,ny) = (x+dx,y+dy)
        
        if isOutOfMap(nx: nx, ny: ny) { continue }
        if !visit[ny][nx] && map[ny][nx] == "x" { return true }
        index += 1
    }
    return false
}

throwHeights.forEach { height in
    findItemInRow(at: height, isleftToRight: i  % 2 == 0 ? true : nil)
    i += 1
    updateMap()
}

for line in map {
    print(line.joined())
}
