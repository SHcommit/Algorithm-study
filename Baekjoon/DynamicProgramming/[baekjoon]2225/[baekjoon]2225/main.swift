import Foundation

func BOJ_2225()
{
    let nk = readLine()!.split(separator:" ").map{Int(String($0))!}
    let (n,k) = (nk[0],nk[1])
    var dp    = Array(repeating: Array(repeating: 0, count: n+1), count: k+1)
    dp[1] = Array(repeating: 1, count: n+1)
    for kIdx in 1...k
    {
        for nIdx in 0...n
        {
            for i in 0...nIdx
            {
                dp[kIdx][nIdx] += dp[kIdx-1][nIdx-i]
                dp[kIdx][nIdx] %= 1000000000
            }
        }
    }
    print(dp[k][n]%1000000000)
}
BOJ_2225()
