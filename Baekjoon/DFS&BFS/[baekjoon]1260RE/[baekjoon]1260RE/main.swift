//
//  main.swift
//  [baekjoon]1260RE
//
//  Created by 양승현 on 2022/03/16.
//
/*
var n // 정점 개수
var m //간선의 개수
var v // 탐색 시작 번호
*/
import Foundation

var seq = readLine()!.split(separator: " ").map{Int($0)!}
var graph : [[Int]]  = Array(repeating: Array(repeating: 0 , count:0), count: seq[0] + 1)
var dfsres = ""
var bfsres = ""
for _ in 0..<seq[1] {
    let node = readLine()!.split(separator: " ").map{Int($0)!}
    graph[node[0]].append(node[1])
    graph[node[1]].append(node[0])
}
func dfs(start vertex: Int){
    var visited = [Int]()
    var stack = [Int]()
    stack.append(vertex)
    while(!stack.isEmpty){
        let node = stack.removeLast()
        if(!visited.contains(node)){
            visited.append(node)
            dfsres = dfsres + "\(node) "
            stack.append(contentsOf: graph[node].sorted(by: > ))
        }
    }
}
func bfs(start vertex: Int){
    var visited = [Int]()
    var queue = [Int]()
    queue.append(vertex)
    while(!queue.isEmpty){
        let node = queue.removeFirst()
        if !visited.contains(node){
            visited.append(node)
            bfsres = bfsres + "\(node) "
            queue.append(contentsOf : graph[node].sorted())
        }
    }
}
dfs(start: seq[2])
bfs(start: seq[2])

print(dfsres)
print(bfsres)
