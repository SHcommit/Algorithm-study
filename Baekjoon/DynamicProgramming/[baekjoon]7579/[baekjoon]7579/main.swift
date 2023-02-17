// https://dev-with-precious-dreams.tistory.com/193

import Foundation

//MARK: - Properties
let nm = readLine()!.split{$0==" "}.map{Int(String($0))!}

let needMemory = nm[1]
let appMemoryLists = readLine()!.split{$0==" "}.map{Int(String($0))!}
let costs = readLine()!.split{$0==" "}.map{Int(String($0))!}
let maximumCost = costs.reduce(0, +)

//MARK: - Helpers
func solution() {
    let n = appMemoryLists.count
    var dp = Array(repeating: Array(repeating: 0, count: maximumCost+1), count: n+1)
    defer {print("\(dp[n].firstIndex(where: {$0>=needMemory})!)")}
    for app in 1...n {
        for cost in 0...maximumCost {
            if cost - costs[app-1] >= 0 {
                dp[app][cost] = dp[app-1][cost - costs[app-1]] + appMemoryLists[app-1]
            }
            dp[app][cost] = max(dp[app][cost], dp[app-1][cost])
        }
    }
}

solution()
