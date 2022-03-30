//  main.swift
//  [baekjoon]11724
//  Created by 양승현 on 2022/03/31.

import Foundation

var connected = 0;

func solution(){
    var NM = readLine()!.split(separator: " ").map{Int(String($0))!}
    if NM[1] == 0{
        connected = 1
        return
    }
    //편의상 1부터 해야지,, 정점이 1부터 시작이니까
    var graph = Array(repeating: Array(repeating: 0, count: NM[0] - 1), count: NM[0]+1)
    var visited = Array(repeating: false, count: NM[0]+1)
    
    for i in 0..<NM[1]{
        var UV = readLine()!.split(separator: " ").map{Int(String($0))!}
        graph[UV[0]].append(UV[1])
        graph[UV[1]].append(UV[0])
    }
    
    if  NM[1] == 1{
        connected = 1;
        return;
    }
    for i in 1..<NM[0]{
        var stack = [Int]()
        if visited[i] == true{
            continue
        }
    
        stack.append(i);
        while(!stack.isEmpty){
            var vertax = stack.popLast()!
            if !visited[vertax] {
                visited[vertax] = true;
                stack.append(contentsOf: graph[vertax].filter{$0 > 0 && visited[$0] == false})
            }
        }
    
        connected += 1
    }
}
solution();
print(connected);
