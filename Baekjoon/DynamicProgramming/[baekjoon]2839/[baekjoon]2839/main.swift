
import Foundation


func BOJ_2839(){
    let n = Int(readLine()!)!

    var dp = Array(repeating: -1, count: n + 1)
    dp[3] = 1
    if n >= 5 {
        dp[5] = 1
    }
    if n >= 6 {
        for num in 6...n{
            dp[num] = 5000
            if dp[num - 3] != -1 {
                dp[num] = dp[num - 3] + 1 < dp[num] ? dp[num - 3] + 1 : dp[num]
            }
            if dp[num - 5] != -1{
                dp[num] = dp[num - 5] + 1 < dp[num] ? dp[num - 5] + 1 : dp[num]
            }
            if dp[num] == 5000{
                dp[num] = -1
            }
        }
    }
    print(dp[n])
}
BOJ_2839()
