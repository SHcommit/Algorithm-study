//  main.swift
//  [baekjoon]14502
//  Created by 양승현 on 2022/03/30.

import Foundation

var NM = readLine()!.split(separator:" ").map{Int(String($0))!}
var map = Array(repeating: Array(repeating: 0, count: NM[1]), count: NM[0])
for i in 0..<NM[0]{
    map[i] = readLine()!.split(separator: " ").map{Int(String($0))!}
}

var virus = map;
var queue = [(Int,Int)]()

//바이러스는 상 하 좌 우로 퍼져나간다
var direction = [(0,1),(0,-1),(-1,0),(0,-1)]

//이때 세울 수 있는 벽의 개수는 3개이다. + 반드시!!
//0은 빈칸 1은 벽 2는 바이러스

/*
 7 7
 2 0 0 0 1 1 0
 0 0 1 0 1 2 0
 0 1 1 0 1 0 0
 0 1 0 0 0 0 0
 0 0 0 0 0 1 1
 0 1 0 0 0 0 0
 0 1 0 0 0 0 0
 */
for y in 0..<NM[0]{
    for x in 0..<NM[1]{
        if map[y][x] == 2 {
            queue.append((x,y));
        }
    }
}
/*
 만약 아래에 1있을 때 오른쪽 0이고, 그럼 오른쪽으로 갔을 때 1이있는지,, 아니면 다 0인지
 파악하고 없으면 그다음꺼 1로만들자
 
var bfs () {
    
    while(!queue.isEmpty){
        
    }
}
*/
