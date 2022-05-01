//  [baekjoon]7562
//  Created by 양승현 on 2022/05/01.

import Foundation
/**
 *
 *
 * 주의사항
 * 이전 코드에서는 map에서0 이 아닐경우 탐색을하는데,
 * 시작좌표가 0으로 표시되서 맨 마지막의 경우 이동하지 않아야 할게
 * 최소 2번 이동으로 출력되는데 ( 마지막 input 답과 다름)
 * 이거만 주의하면 된다
 *  그래서 시작좌표를 1로하고 반환을 mpa[좌표] - 1 로 했다.
 */

solution()

/**
 * res == 값 저장
 * testCase 옵셔널 바인딩으로 값 받음
 * coord에 시작점, 도착점 저장 ( inputSeq함수를 통해 값 대입)
 * length에 체스판 크기 저장
 * map에 원하는 도착지점까지 bfs탐색할 때 방문했는지를 표시함(0이면 탐색 x)
 * BFS탐색을 통해 값 도출
 */
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
/**
 * direction = 나이트가 이동할 수 있는 곳 물론 현재 나이트의 위치에서 이 값을 더해야 이동할 값이나옴
 * start X, Y 처음 나이트가 위치한 좌표
 * destination X, Y 도착 좌표
 * index == queue를 훑는데 사용 . dequeue할때 시간이 오래 걸릴까봐 index를 통해 탐색함
 */
func BFS(map : inout [[Int]], array: [(Int,Int)]) -> Int{
    let direction = [(2,1),(1,2),(-2,1),(-1,2),(2,-1),(1,-2),(-2,-1),(-1,-2)]
    
    let startX = array[0].0
    let startY = array[0].1
    let destinationX = array[1].0
    let destinationY = array[1].1

    var index = 0
    //맨 위의 주의사항으로 인해
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
            //방문 x 이면
            if map[ny][nx] == 0 {
                //현재 좌표 x,y에서 나이트가 nx, ny로 이동함을 +1 로 표시
                map[ny][nx] = map[y][x] + 1
                //그 후 큐에 추가
                queue.append((nx,ny))
            }
            //도착했는가?
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
