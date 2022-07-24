import Foundation

//세로 가로 대각
let direction : [(x:Int,y:Int)] = [(0,1),(1,0),(1,1)]

func dfs(_ x : Int, _ y : Int,_ n : Int, _ cross : Bool,_ width : Bool,_ dp : inout [[Int]], _ map : [[Int]]) -> Int
{
    if x==n-1 && y==n-1
    {
        return 1
    }
    if (x == n-1 && width) || ( y == n-1 && !width && !cross)
    {
        return 0
    }
    dp[y][x] = 0
    for i in 0..<direction.count
    {
        let (nx,ny) = (x+direction[i].x,y+direction[i].y)
        if nx<0||nx>n-1||ny<0||ny>n-1||map[ny][nx] == 1
        {
            continue
        }
        if i == 0
        {
            if width{ continue }
            dp[y][x] += dfs(nx,ny,n,false,false,&dp,map)
        }
        else if i == 1
        {
            if !width && !cross
            {
                continue
            }
            dp[y][x] += dfs(nx, ny, n, false, true, &dp, map)
        }
        else if i == 2
        {
            if map[y+1][x] == 1 || map[y][x+1] == 1
            {
                continue
            }
            dp[y][x] += dfs(nx, ny, n, true, false, &dp, map)
        }
    }
    return dp[y][x]
}
func BOJ_17070()
{
    let n = Int(readLine()!)!
    var dp = Array(repeating: Array(repeating: -1,count:n),count:n)
    var map = Array(repeating: [Int](), count: n)
    for i in 0..<n
    {
        map[i] = readLine()!.split(separator:" ").map{Int(String($0))!}
    }
    dp[0][1] = dfs(1, 0, n,false, true, &dp, map)
    print(dp[0][1])
}
BOJ_17070()

