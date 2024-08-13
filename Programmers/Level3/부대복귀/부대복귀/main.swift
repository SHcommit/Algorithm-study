//
//  main.swift
//  부대복귀
//
//  Created by 양승현 on 8/13/24.
//

import Foundation

/// 1트. 간단하게 매번 sources별로 bfs로 접근 -> 시간초과
/// 아무래도 sources를 100,000 * 500 => 50,000,000 어.. 시간초과 날만하네
/// 이전에 탐색했으면 그걸 활용해야할듯
///
/// 방법을 바꿔서! 일단 최악의 경우 bfs 특징을 활용해보자.
/// 그리고 bfs는 모든 tree를 한번씩 탐색하는거니까 이 루트 노드는 destination을 이용해서 탐색해보자!
func solution(_ n:Int, _ roads:[[Int]], _ sources:[Int], _ destination:Int) -> [Int] {
    var routes = roads.reduce(into: [Int: [Int]]()) {
        $0[$1[0], default: []].append($1[1])
        $0[$1[1], default: []].append($1[0])
    }
    
    var cache = Array(repeating: -1, count: n+1)
    bfs(destination: destination, n: n, cache: &cache, by: routes)
    return sources.map { cache[$0] }
}

typealias Element = (route: Int, day: Int)
func bfs(destination: Int, n: Int, cache: inout [Int], by routes: [Int: [Int]]) {
    var queue: [Element] = [(destination, 0)]
    var queueIdx = 0
    cache[destination] = 0
    while queue.count > queueIdx {
        var (curPos, curDay) = queue[queueIdx]
        queueIdx += 1
        guard let directions = routes[curPos] else { continue }
        for nextPos in directions {
            if cache[nextPos] != -1 && cache[nextPos] <= curDay+1 { continue }
            cache[nextPos] = curDay + 1
            queue.append((nextPos, curDay+1))
        }
    }
}

print(solution(5, [[1, 2], [1, 4], [2, 4], [2, 5], [4, 5]]  ,  [1, 3, 5], 5))
