import Foundation

/// 음.. 뭔가 결국에 모든 각 number마다 -,+ 모든 경우를 비교해야 할 것 같다는 생각이 들었다.
/// bfs를 써봤다. 오랜만에 써서 그런지 첫 실행은 틀렸다. 이유는 c.idx가 지나치게 커져서 numbers 에 접근 범위 벗어남.

let Direction = [-1,1]
typealias Element = (idx: Int, sum: Int)
func solution(_ numbers:[Int], _ target:Int) -> Int {
    var queue: [Element] = [(0, 0)]
    var idx = 0, ans = 0
    while idx < queue.count {
        let c = queue[idx]
        if c.idx == numbers.count { 
            idx += 1
            if c.sum == target {
                ans += 1
            }
            continue 
        }
        for d in Direction {
            let n = numbers[c.idx]*d + c.sum
            queue.append((c.idx+1,n))
        }
        idx += 1
    }
    return ans
}
print(solution([1,1,1,1,1],3))
