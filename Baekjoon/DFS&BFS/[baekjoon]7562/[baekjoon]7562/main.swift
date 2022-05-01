//  [baekjoon]7562
//  Created by 양승현 on 2022/05/01.

import Foundation
//0 이 아닐경우 탐색을하는데, 시작좌표가 0으로 표시되서 맨 마지막의 경우 이동하지않아도 최소 2번 이동으로 출력되는데 이거만 주의하면 됨 그래서 시작좌표를 1로하고 반환을 -1 로함
solution()

func solution(){
    var res = ""
    let testCase : Int = inputData()
    for _ in 0..<testCase{
        
        var coord = [(Int,Int)]()
        let length = inputData()
        var map = Array(repeating: [Int](), count: length)
        for i in 0..<length{
            map[i] = Array(repeating: 0, count: length)
        }
        for _ in 0..<2{
            inputSeq(array: &coord)
        }
        res += "\(BFS(map: &map, array: coord))\n"
    }
    print(res)
}

func BFS(map : inout [[Int]], array: [(Int,Int)]) -> Int{
    let direction = [(2,1),(1,2),(-2,1),(-1,2),(2,-1),(1,-2),(-2,-1),(-1,-2)]
    
    let startX = array[0].0
    let startY = array[0].1
    let destinationX = array[1].0
    let destinationY = array[1].1
    
    var index = 0
    map[startY][startX] = 1
    var queue = [(startX,startY)]
    
    while(queue.count != index){
        
        for (dx,dy) in direction{
            let x = queue[index].0
            let y = queue[index].1
            let nx = x + dx
            let ny = y + dy
            
            if nx < 0 || nx > map.count - 1 || ny < 0 || ny > map.count - 1 {
                continue
            }
            if map[ny][nx] == 0 {
                map[ny][nx] = map[y][x] + 1
                queue.append((nx,ny))
            }
            
            if nx == destinationX && ny == destinationY{
                return map[ny][nx] - 1
            }
            
        }
        index += 1
    }
    return 0
}
func inputData() -> Int{
    if let input = readLine(){
        return Int(input) ?? 0
    }
    return 0
}

/*
 * 0 0 이 값이 readLine()을 통해 input에 저장될 때
 * 옵셔널 바인딩할때 input을 split한 다음에 input[0] input[1]로 쓸 수 없음
 * let 변수이기때문에, 그래서 var 타입의 변수를 통해 그 변수를 split결과로 대입해야함.
 */
func inputSeq(array: inout [(Int,Int)]) {
    if let input = readLine(){
        var seq = input.split(separator: " ").map{Int($0)}
        array.append((Int(seq[0] ?? -1), Int(seq[1] ?? -1)))
    
    }
}
