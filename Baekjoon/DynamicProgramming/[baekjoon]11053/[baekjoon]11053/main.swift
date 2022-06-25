import Foundation

func BOJ_11053()
{
    var n = Int(readLine()!)!
    var list = readLine()!.split(separator: " ").map{Int($0)!}
    var dp = Array(repeating: 1, count: n + 1)
    for i in 1..<n
    {
        for j in 0..<i
        {
            if list[j] < list[i]
            {
                dp[i] = max(dp[i], dp[j] + 1)
            }
        }
    }
    print(dp.max()!)
}
BOJ_11053()
