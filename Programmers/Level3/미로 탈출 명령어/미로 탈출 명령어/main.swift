//
//  main.swift
//  미로 탈출 명령어
//
//  Created by 양승현 on 8/15/24.
//

import Foundation

/// DFS에서 조기조건을 찾을 경우에 어떻게 빠져나갈지가 의문이었는데.. 전역변수를 활용하면 됬다.
///
/// 문제가.. 처음에 규칙으로 최단거리에대한 경로를 구하고 남아있는 k - 최단거리 의 남은 값마다 du or lr 이렇게 최적의 방법을 찾아보려고했느데
/// 쉽지 않았다.
///
/// 초기에 조건을 확인해주고, dfs로 탐색할 때 탐색할 때 사전순으로 탐색할 수 있도록 정리해주어야한다.
///
/// 내가 놓쳤던 부분중 하나는 문제에선 n, m을 세로, 가로로 얘기했느데.. x,y는 가로 세로의 느낌을 받았었는데.. 탐색할 때 (1...n)~=x, (1...m)~=y 이게 맞다..
///
/// 중요한 점은 탐색할 때 현 위치에서 도착까지 구간이  k 구간보다 거리가 길 때, n구간에 존재하는지.
/// 갈 수 있는 남은 횟수가 k 따라 다른데 홀수 or 짝수여야만 목적지에 도달할 수 있다.
typealias Point = (x: Int, y:Int)
let Direction: [Point] = [(1,0), (0,-1),(0,1),(-1,0)]
let DirString: [String] = ["d","l","r","u"]

func solution(_ n:Int, _ m:Int, _ x:Int, _ y:Int, _ r:Int, _ c:Int, _ k:Int) -> String {
    let minDistance = abs(x-r) + abs(y-c)
    var _res = "impossible"
    if minDistance > k || (minDistance%2 == 1 ? k%2 == 0 : k%2 == 1) { return _res }
    
    func dfs(currentPoint cp: Point, cnt: Int, res: String) {
        if _res != "impossible" { return }
        let remainDist = abs(cp.x-r) + abs(cp.y-c)
        let remainCnt = k-cnt
        if remainCnt - remainDist < 0 || (remainCnt - remainDist) % 2 == 1 { return }
        if cnt == k {
            if cp.x == r, cp.y == c { _res = res }
            return
        }
        
        for (i,d) in Direction.enumerated() {
            let next: Point = (cp.x+d.x, cp.y+d.y)
            guard (1...n)~=next.x && (1...m)~=next.y else { continue }
            dfs(currentPoint: next, cnt: cnt+1, res: res+DirString[i])
        }
    }
    
    
    dfs(currentPoint: (x,y), cnt: 0, res: "")
    return _res
}

print(solution(3, 4, 2, 3, 3, 1, 5))
