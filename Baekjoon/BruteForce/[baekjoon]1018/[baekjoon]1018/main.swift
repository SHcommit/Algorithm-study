//
//  main.swift
//  [baekjoon]1018
//
//  Created by 양승현 on 2022/04/04.
//

import Foundation

var model : Model

let nm = readLine()!.split(separator: " ").map{Int(String($0))!}

model = Model(width: nm[1], height: nm[0])

bruteForce()

print(model.count)


func bruteForce(){
    for y in 0..<model.height{
        for x in 0..<model.width{
            if model.width - x >= model.minLine && model.height - y >= model.minLine{
                let tmp = drawBoard(x: x, y: y)
                if tmp < model.count{
                    model.count = tmp
                }
            }else{
                break
            }
        }
    }
}
func drawBoard(x :Int, y: Int) -> Int{
    var aCnt = 0
    var bCnt = 0
    for dy in 0..<model.minLine{
        for dx in 0..<model.minLine{
            let ny = dy + y
            let nx = dx + x
            
            // w == 0 일때
            if ((dy + dx) % 2 == 0 && model.board[ny][nx] == "B") ||
                ((dy + dx) % 2 == 1 && model.board[ny][nx] == "W"){
                aCnt += 1
            }
            if ((dy + dx) % 2 == 0 && model.board[ny][nx] == "W") ||
                ((dy + dx) % 2 == 1 && model.board[ny][nx] == "B") {
                bCnt += 1
            }
        }
    }
    return aCnt > bCnt ? bCnt : aCnt;
}


class Model {
    
    var width : Int
    var height : Int
    var minLine : Int
    var count : Int
    var board : [[String]]
    
    init(width w: Int , height h: Int){
        width = w
        height = h
        minLine = 8
        count = 9999
        board = Array(repeating: [String](), count: height)
        for i in 0..<height{
            board[i] = readLine()!.map{String($0)}
        }
    }
}

