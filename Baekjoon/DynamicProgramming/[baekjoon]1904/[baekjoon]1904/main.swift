//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-1904-01%ED%83%80%EC%9D%BC
import Foundation

func BOJ_1094()
{
    var n  = Int(readLine()!)!
    var dp = [0,1,2]
    if n > 2
    {
        for i in 3...n
        {
            dp.append((dp[i-1] + dp[i-2]) % 15746 )
        }
    }
    print(dp[n])
}
BOJ_1094()

