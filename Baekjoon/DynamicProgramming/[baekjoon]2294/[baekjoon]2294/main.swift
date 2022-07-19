import Foundation

func BOJ_2294()
{
    let nk   = readLine()!.split(separator:" ").map{Int(String($0))!}
    let n    = nk[0]
    let k    = nk[1]
    var dp   = Array(repeating: 10001, count: k+1)
    var list = [Int]()
    for _ in 0..<n
    {
        list.append(Int(readLine()!)!)
    }
    dp[0] = 0
    for i in 0..<n
    {
        if list[i] <= k
        {
            for j in list[i]...k
            {
                dp[j] = min(dp[j-list[i]] + 1 , dp[j])
            }
        }
    }
    print(dp[k] == 10001 ? -1 : dp[k])
}
BOJ_2294()
