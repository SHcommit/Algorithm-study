//
//  main.swift
//  [baekjoon]1012
//
//  Created by 양승현 on 2022/03/30.
//

//m =  가, N = 세 K = 배추 수

import Foundation

var n = Int(readLine()!)!
var res = ""
var direction = [(0,1),(0,-1),(-1,0),(1,0)]

for _ in 0..<n{
    
    var MNK = readLine()!.split(separator: " ").map{Int(String($0))!}
    
    var farm = Array(repeating: Array(repeating: 0, count: MNK[0]), count: MNK[1])
    var stack = [(Int,Int)]()
    var coord = [(Int,Int)]()
    
    
    var bug = 0;
    
    for _ in 0..<MNK[2]{
        let XY = readLine()!.split(separator: " ").map{Int(String($0))!}
        farm[XY[1]][XY[0]] = 1;
        coord.append((XY[0],XY[1]))
    }
    
    for i in 0..<coord.count{
        if farm[coord[i].1][coord[i].0] == 0{
            continue
        }
        stack.append(coord[i])
        bfs()
        bug += 1
    }
    func bfs(){
        while (!stack.isEmpty){
            let (dx, dy) = stack.removeLast()
            
            for (nx,ny) in direction{
                let x = nx + dx;
                let y = ny + dy;
                if x < 0 || x > MNK[0] - 1 || y < 0 || y > MNK[1] - 1{
                    continue
                }
                if farm[y][x] == 1{
                    farm[y][x] = 0;
                    stack.append((x,y));
                }
            }
            
        }
    }
    
    res += "\(bug)\n"
}
print(res)
