//  main.swift
//  [baekjoon]11724
//  Created by 양승현 on 2022/03/31.

import Foundation

var connected = 0;

var NM = readLine()!.split(separator: " ").map{Int(String($0))!}
//편의상 1부터 해야지,, 정점이 1부터 시작이니까
var graph = [Int:[Int]]()

var visited = Array(repeating: false, count: NM[0] + 1)
    
for i in 1...NM[0]{
    graph.updateValue([], forKey: i);
}
for i in 0..<NM[1]{
    var UV = readLine()!.split(separator: " ").map{Int(String($0))!}
    graph[UV[0]]?.append(UV[1])
    graph[UV[1]]?.append(UV[0])
}
for i in 1...NM[0]{
    if visited[i]{
        continue
    }
    dfs(vertex : i)
    connected += 1
}
        
func dfs(vertex v :Int){
    var stack = [Int]()
    stack.append(v)
    while(!stack.isEmpty){
        let vertex = stack.removeLast()
        if(!visited[vertex]){
            visited[vertex] = true
            stack.append(contentsOf: graph[vertex]!.sorted(by: >))
        }
    }
}
print(connected);
