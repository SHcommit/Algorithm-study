import Foundation
/**
 * 이 문제가 좀..?
 * if n > 1이랑 if n > 2 조건 안 걸어도 되는데 런타임 에러로 채점해버림..
 */
func BOJ_2156()
{
    let n    = Int(readLine()!)!
    var list = Array(repeating: 0, count: 10001)
    var dp   = Array(repeating: 0, count: n + 1)
    for i in 1...n
    {
        list[i] = Int(readLine()!)!
    }
    dp[1] = list[1]
    if n > 1
    {
        dp[2] = dp[1] + list[2]
    }
    if n>2
    {
        for i in 3...n
        {
            dp[i] = max(dp[i-3]+list[i-1]+list[i], dp[i-2]+list[i],dp[i-1])
        }
    }
    print(dp[n])
}
BOJ_2156()
