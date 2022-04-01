//  main.swift
//  [baekjoon]2468
//  Created by 양승현 on 2022/04/01.
/**
 * [문제 : 2468](https://www.acmicpc.net/problem/2468)
 * 간단한 코드리뷰.
 *
 * 안전가옥 == land로 지정하고, 값을 받을 때, 최소 h랑 최대 h를 구했습니다.
 * 그리고 비가 내릴 수 있는 최소 h 부터 최대h 까지. 순차적으로 반복하면서, 특정 h에 안전가옥의 크기를 구한 후
 * 안전가옥 최대인지를 구했습니다.
 */
import Foundation
//높이
var h = Int(readLine()!)!
//안전가옥 개수
var safety = 1;
//지역
var land = Array(repeating: [Int](), count: h)
//최소 높이
var minH = 3
//최고 높이
var maxH = 1
// 탐색 방향
var direction = [(-1,0),(1,0),(0,-1),(0,1)]

//지역에 정보 삽입 + maxH or minH 찾기
for i in 0..<h{
    land[i] = readLine()!.split(separator: " ").map{
        if Int(String($0))! < minH{
            minH = Int(String($0))!
        }
        if Int(String($0))! > maxH{
            maxH = Int(String($0))!
        }
        return Int(String($0))!
    }
}
//물에 잠길 수 있는 최소 높이부터 최대 높이까지 순차적으로 탐색
for i in minH...maxH{
    var count = 0;
    var visited = Array(repeating: Array(repeating: false, count: h), count: h)
    
    for y in 0..<h{
        for x in 0..<h{
            if !visited[y][x] && land[y][x] > i{
                dfs(x,y,i, &visited)
                count += 1
            }
        }
    }
    if safety < count {
        safety = count;
    }
}
func dfs(_ x :Int, _ y :Int, _ height:Int, _ visited : inout [[Bool]]){
    for i in direction {
        let nx = x+i.0
        let ny = y+i.1
        if ny < 0 || ny > h - 1 || nx < 0 || nx > h - 1 {
            continue
        }
        if !visited[ny][nx] && land[y][x] > height {
            visited[ny][nx] = true;
            dfs(nx,ny,height, &visited)
        }
    }
}

print(safety)
