import Foundation
/**
 * n == 0 일때 0 출력
 * n == 1일때 1출력을 해야한다.,,
 */
func BOJ_2748()
{
    let n = Int(readLine()!)!
    var dp = Array(repeating: 0, count: n+1)
    if n>0
    {
        dp[1] = 1
    }
    if n > 1
    {
        dp[2] = dp[1]
    }
    if n > 2
    {
        for i in 3...n
        {
            dp[i] = dp[i-1] + dp[i-2]
        }
    }
    print(dp[n])
}
BOJ_2748()
