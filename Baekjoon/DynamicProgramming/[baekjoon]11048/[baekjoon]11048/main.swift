import Foundation

func BOJ_11048()
{
    let hw = readLine()!.split(separator:" ").map{Int(String($0))!}
    let (height,width) = (hw[0],hw[1])
    var rooms = Array(repeating:[Int](), count: height)
    for i in 0..<height
    {
        rooms[i] = readLine()!.split(separator:" ").map{Int(String($0))!}
    }
    var dp = Array(repeating: Array(repeating: 0, count: width+1), count: height+1)
    for y in 1...height
    {
        for x in 1...width
        {
            dp[y][x] = max(dp[y-1][x-1] ,dp[y-1][x], dp[y][x-1]) + rooms[y-1][x-1]
        }
    }
    print(dp[height][width])
}
BOJ_11048()
