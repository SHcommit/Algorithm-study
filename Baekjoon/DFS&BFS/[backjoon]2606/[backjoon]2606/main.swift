//
//  main.swift
//  [backjoon]2606
//
//  Created by 양승현 on 2022/03/14.
//
/**
 7
 6
 1 2
 2 3
 1 5
 5 2
 5 6
 4 7
 */
import Foundation

var vertex = Int(readLine()!)!
var n = Int(readLine()!)!
var cnt = 0
var graph :[[Int]] = Array(repeating: Array(repeating: 0, count: 0), count: vertex+1)

for i in 0..<n{
    var input = readLine()!.split(separator: " ").map{Int($0)!}
    graph[input[0]].append(input[1])
    graph[input[1]].append(input[0])
}


func dfs (startVertex s : Int) {
    var visited = [Int]()
    var stack = [Int]()
    stack.append(s)
    while(!stack.isEmpty){
        var node = stack.popLast()!
        if(!visited.contains(node)){
            
            visited.append(node)
            if visited.count > 1 {
                cnt = cnt + 1
            }
            stack.append(contentsOf: graph[node].sorted(by: >))
        }
    }
}
dfs(startVertex: 1)
print("\(cnt)")
