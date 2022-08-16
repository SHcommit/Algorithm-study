import Foundation

func BOJ_16194()
{
    let n = Int(readLine()!)!
    let arr = readLine()!.split{$0==" "}.map{Int($0)!}
    var dp = Array(repeating: 0, count: 10001)
    for i in 0..<n
    {
       dp[i + 1] = arr[i]
    }
    for i in stride(from: 2, through: n, by: 1)
    {
        for j in stride(from: 1, to: i, by: 1)
        {
           dp[i] = dp[i-j] + dp[j] > dp[i] ? dp[i] : dp[i-j] + dp[j]
        }
    }
    print("\(dp[n])")
}
BOJ_16194()

