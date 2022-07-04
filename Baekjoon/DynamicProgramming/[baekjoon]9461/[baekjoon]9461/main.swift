import Foundation
//좀 길어지더라고 규칙을 찾는게 중요한 것 같다.
func BOJ_9461()
{
    var n   = Int(readLine()!)!
    var arr = [Int]()
    var dp  = Array(repeating: 0, count: 101)
    var res = ""
    for _ in 0..<n
    {
        arr.append(Int(readLine()!)!)
    }
    dp[1] = 1
    dp[2] = 1
    dp[3] = 1
    dp[4] = 2
    dp[5] = 2
    for i in 0..<n
    {
        
        if dp[arr[i]] == 0 && arr[i] > 5
        {
            for i in 6...arr[i]
            {
                dp[i] = dp[i-1] + dp[i-5]
            }
        }
        res += "\(dp[arr[i]])\n"
    }
    print(res)
}
BOJ_9461()
