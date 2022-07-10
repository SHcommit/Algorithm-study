import Foundation
let direction = [(-1,0),(1,0),(0,1),(0,-1),(-1,-1),(-1,1),(1,-1),(1,1)]
class mapInfo
{
    let height : Int
    let width  : Int
    var map    : [[Int]]
    init()
    {
        let nm     = readLine()!.split(separator: " ").map{Int(String($0))!}
        height = nm[0]
        width  = nm[1]
        map    = Array(repeating: [Int](), count: height)
        for i in 0..<height
        {
            map[i] = readLine()!.split(separator: " ").map{Int(String($0))!}
        }
    }
}
func BFS(_ x : Int,_ y : Int, _ m : mapInfo, _ res : inout Int)
{
    var visited   = Array(repeating: Array(repeating: false, count: m.width), count: m.height)
    var queue     = [(x,y,0)]
    var index     = 0
    visited[y][x] = true
    while queue.count != index
    {
        let (curX,curY,prevTime) = queue[index]
        index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX+dx, curY+dy)
            if nx < 0 || nx > m.width - 1 || ny < 0 || ny > m.height - 1
            {
                continue
            }
            if m.map[ny][nx] == 1
            {
                res = max(res,prevTime + 1)
                return
            }
            if !visited[ny][nx] && m.map[ny][nx] == 0
            {
                queue.append((nx,ny,prevTime + 1))
                visited[ny][nx] = true
            }
        }
    }
    
}
func BOJ_17086()
{
    var result = 0
    let mapInfo = mapInfo()
    for y in 0..<mapInfo.height
    {
        for x in 0..<mapInfo.width
        {
            if mapInfo.map[y][x] == 0
            {
                BFS(x, y, mapInfo, &result)
            }
        }
    }
    print(result)
}
BOJ_17086()
