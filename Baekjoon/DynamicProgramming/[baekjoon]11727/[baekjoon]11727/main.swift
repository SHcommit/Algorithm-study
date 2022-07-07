//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-11727-2%C3%97n-%ED%83%80%EC%9D%BC%EB%A7%81-2

import Foundation

func BOJ_11727()
{
    let n  = Int(readLine()!)!
    var dp = Array(repeating: 0, count: 1001)
    dp[1]  = 1
    dp[2]  = 3
    if n > 2
    {
        for i in 3...n
        {
            dp[i] = (dp[i-1] + 2*dp[i-2]) % 10007
        }
    }
    print(dp[n])
}
BOJ_11727()
