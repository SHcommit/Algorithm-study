//
//  main.swift
//  [baekjoon]1018
//
//  Created by 양승현 on 2022/04/04.
//

import Foundation

if let model = inputData(){
    bruteForce(model: model)
    print(model.count)
}


// M x N을 탐색하는 보드의 처음과 끝이 8보다 작다면 다음 줄을 순회하도록 했습니다.
func bruteForce(model : Model){
    for y in 0..<model.height{
        for x in 0..<model.width{
            if model.width - x >= model.minLine && model.height - y >= model.minLine{
                let tmp = drawBoard(x: x, y: y, model: model)
                if tmp < model.count{
                    model.count = tmp
                }
            }else{
                break
            }
        }
    }
}

// 데이터를 입력받습니다.
func inputData() -> Model?{
    if let input = readLine(){
        let nm = input.split(separator: " ").map{Int(String($0))!}
        return Model(width: nm[1], height: nm[0])
    }
    return nil
}

/**
 * 보드의 최소 draw를 탐색하는 함수입니다.
 * 보드의 시작점이 "W" 일때 or "B" 일 때 두 가지의 경우로 나누어
 * W == 0일때 칠해야 할 최소 경우를 aCnt
 * B == 0일 때 칠해야 할 최소 경우를 bCnt로 둔 후 최소값을 반환했습니다.
 */
func drawBoard(x :Int, y: Int, model: Model) -> Int{
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


// 자료형들입니다.
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
            if let line = readLine(){
                board[i] = line.map{String($0)}
            }
        }
    }
}
