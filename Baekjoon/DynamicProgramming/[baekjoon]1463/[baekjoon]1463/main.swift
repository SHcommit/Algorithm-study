import Foundation

func BOJ_1463(){
    let n = Int(readLine()!)!

    var dp = Array(repeating: 1, count: n+1)
    
    dp[1] = 0
    if n >= 2 {
        for num in 2...n{
            dp[num] = 1000000
            if num % 3 == 0{
                dp[num] = dp[num/3] + 1 < dp[num] ? dp[num/3] + 1 : dp[num]
            }
            if num % 2 == 0{
                dp[num] = dp[num/2] + 1 < dp[num] ? dp[num/2] + 1 : dp[num]
            }
            dp[num] = dp[num - 1] + 1 < dp[num] ? dp[num - 1] + 1 : dp[num]
        }
    }
    print(dp[n])
}

BOJ_1463()

