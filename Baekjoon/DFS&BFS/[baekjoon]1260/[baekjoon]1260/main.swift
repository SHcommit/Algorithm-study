//
//  main.swift
//  [baekjoon]1260
//
//  Created by 양승현 on 2022/03/12.
//
//dictionary 쓸 때
//dictionary<int,[int]>타입일 경우 맨 처음에 배열에 값을 넣기 전에 초기화를
/*
 for i in 0..<input[1]{
     graph.updateValue([], forKey: i)
 }
 해주어야..
 
 //sort 과 sorted의 차이는
 sort는 주어진 배열을 정렬해주는거고
 sorted는 주어진 배열(원본)을 정렬한 시퀀스(복사본)를 반환한다.
 */
import Foundation
var input = readLine()!.split(separator: " ").map{Int($0)!}
var graph = Array(repeating: Array(repeating: 0, count: 0), count: input[0] + 1)
var dfsRes = ""
var bfsRes = ""
for _ in 0..<input[1]{
    let m = readLine()!.split(separator: " ").map{Int($0)!}
    graph[m[0]].append(m[1])
    graph[m[1]].append(m[0])
}
func dfs(start s : Int){
    var visited = [Int]()
    var stack = [Int]()
    stack.append(s)
    while(!stack.isEmpty){
        let vertex = stack.removeLast()
        if(!visited.contains(vertex)){
            visited.append(vertex)
            dfsRes = dfsRes + "\(vertex) "
            stack.append(contentsOf: graph[vertex].sorted{
                switch($0,$1){
                case ($0,nil):
                    return ($0 != 0)
                case ($0,$1):
                    return $0 > $1
                default:
                    return false
                }
            })
        }
    }
}
func bfs(start s : Int){
    var visited = [Int]()
    var queue = [Int]()
    queue.append(s)
    while(!queue.isEmpty){
        let vertex = queue.removeFirst()
        if (!visited.contains(vertex)){
            visited.append(vertex)
            bfsRes = bfsRes + "\(vertex) "
            queue.append(contentsOf: graph[vertex].sorted())
        }
    }
}
dfs(start: input[2])
bfs(start: input[2])
print(dfsRes)
print(bfsRes)
