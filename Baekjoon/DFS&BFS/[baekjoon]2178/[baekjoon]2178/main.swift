//
//  main.swift
//  [baekjoon]2178
//
//  Created by 양승현 on 2022/03/16.
//

import Foundation

var nm = readLine()!.split(separator: " ").map{Int($0)!}
var map : [[Int]] = Array(repeating: Array(repeating: 0, count: 0), count: nm[0]+1)
for i in 0..<nm[0]{
    map[i].append(contentsOf: {
        readLine()!.split(separator: " ").map{Int($0)!}
    }())
}
func bfs (start vertex : Int){
    var queue = [Int]()
    var visited = [Int]()
    var cnt = 1
    var x = 0
    var y = 0
    
    while(x != nm[0]-1 && y != nm[1]){
        
        if map[y+1][x] == 1 {
            
        }
        if map[y][x+1] == 1 {
            
        }
        
    }
}
