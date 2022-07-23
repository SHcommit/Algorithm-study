import Foundation
typealias point = (x: Int,y: Int, height: Int)
let direction   = [(-1,0),(1,0),(0,1),(0,-1)]

class rectInfo
{
    let height : Int
    let width  : Int
    var map    : [[Int]]
    init()
    {
        let input = readLine()!.split(separator:" ").map{Int(String($0))!}
        height    = input[0]
        width     = input[1]
        map       = Array(repeating:[Int](),count:height)
        for i in 0..<height
        {
            map[i] = readLine()!.split(separator:" ").map{Int(String($0))!}
        }
    }
}

func dfs(_ curPoint : point, _ info : rectInfo,_ dp : inout [[Int]]) -> Int
{
    if dp[curPoint.y][curPoint.x] != -1
    {
        return dp[curPoint.y][curPoint.x]
    }
    if curPoint.x == info.width-1 && curPoint.y == info.height-1
    {
        return 1
    }
    dp[curPoint.y][curPoint.x] = 0
    for (dx,dy) in direction
    {
        let (nx,ny) = (curPoint.x+dx,curPoint.y+dy)
        if nx<0||nx>info.width-1||ny<0||ny>info.height-1
        {
            continue
        }
        if info.map[ny][nx] < curPoint.height
        {
            dp[curPoint.y][curPoint.x] += dfs((nx,ny,info.map[ny][nx]), info,&dp)
        }
    }
    return dp[curPoint.y][curPoint.x]
}
func BOJ_1520()
{
    var info = rectInfo()
    var dp   = Array(repeating: Array(repeating: -1, count: info.width), count: info.height)
    print(dfs((0,0,info.map[0][0]), info, &dp))
}
BOJ_1520()
