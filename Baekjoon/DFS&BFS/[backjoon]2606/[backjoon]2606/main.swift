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
var img = """
\\    /\
 )  ( ')
(  /  )
 \\\(\\_\\_)|

"""

print("\(img")
/*
var vertex = Int(readLine()!)!
var n = Int(readLine()!)!
var cnt = 0
var graph :[[Int]] = Array(repeating: Array(repeating: 0, count: 0), count: vertex+1)

for i in 0..<n{
    var input = readLine()!.split(separator: " ").map{Int($0)!}
    graph[input[0]].append(input[1])
    graph[input[1]].append(input[0])
}

for i in 0..<graph.count{
    graph[i].sort(by: ){ $0 > $1 }
}

func dfs (startVertex s : Int) {
    
    var visited = [Int]()
    var stack = [Int]()
    stack.append(s)
    while(!stack.isEmpty){
        /*
         stack에 일단
         1일 때 2탐색해야함
         2는 3
         3은없으니까 pop
         
         2는 5랑 연결됨
         5는 없으니까 pop
         **/
        var node = stack.last!
    
        if(!visited.contains(node)){
            visited.append(node)
            cnt = cnt + 1
            stack.append(graph[node].last!)
        }else{
            stack.popLast()
        }
    }
}
dfs(startVertex: 1)

print("\(cnt)")
*/
