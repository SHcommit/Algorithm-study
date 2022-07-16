import Foundation

func BOJ_9251()
{
    let str1 = readLine()!.map{String($0)}
    let str2 = readLine()!.map{String($0)}
    var dp   = Array(repeating: Array(repeating: 0, count:str1.count+1) ,count:str2.count+1)
    for y in 1...str2.count
    {
        for x in 1...str1.count
        {
            if str2[y-1] == str1[x-1]
            {
                dp[y][x] = dp[y-1][x-1] + 1
            }
            else
            {
                dp[y][x] = max(dp[y][x-1], dp[y-1][x])
            }
        }
    }
    print(dp[str2.count][str1.count])
}
BOJ_9251()
