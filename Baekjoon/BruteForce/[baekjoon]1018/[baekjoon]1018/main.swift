//
//  main.swift
//  [baekjoon]1018
//
//  Created by 양승현 on 2022/04/04.
//

import Foundation

//N == 세로 M == 가로
var NM = readLine()!.split(separator: " ").map{Int(String($0))!}
let width = NM[1]
let height = NM[0]
let minLine = 8;
var count = 33;

var board = Array(repeating: [String](), count: height)
for i in 0..<height{
    board[i] = readLine()!.map{String($0)}
}

for y in 0..<width{
    for x in 0..<height{
        if width - x >= minLine && height - y >= minLine{
            let tmp = fixBoard(x: x, y: y)
            if tmp < count{
                count = tmp
            }
        }
    }
}
func fixBoard(x :Int, y: Int) -> Int{
    var cnt = 0
    for dy in 0..<minLine{
        for dx in 0..<minLine{
            let ny = dy + y
            let nx = dx + x
            //짝수인지?
            if(dy+dx) % 2 == 0{
                if board[dy][dx] == board[y][x]{
                    continue
                }
                else if board[dy][dx] != board[y][x]{
                    cnt += 1
                }
            }else if (dy + dx) % 2 == 1{
                if board[y][x] == board[ny][nx]{
                    cnt += 1
                }
                else{
                    continue
                }
            }
        }
    }
    return count;
}
print(count)


