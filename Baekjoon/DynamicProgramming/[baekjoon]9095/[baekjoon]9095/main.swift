import Foundation

func BOJ_9095(){
    let testCase = Int(readLine()!)!
    var seq = [Int]()
    
    for _ in 0..<testCase{
        seq.append(Int(readLine()!)!)
    }
    let sortSeq = seq.sorted(by: <)
    
    var dp = Array(repeating: 0, count: sortSeq[seq.count - 1] + 1)
    dp[1] = 1
    dp[2] = 2
    dp[3] = 4
    for i in 4...sortSeq[seq.count - 1]{
        dp[i] = dp[i - 3] + dp[i - 2] + dp[i - 1]
    }
    for num in seq{
        print(dp[num])
    }
}


BOJ_9095()
