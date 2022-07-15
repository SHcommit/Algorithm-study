import Foundation
let direction = [(-1,0),(1,0),(0,1),(0,-1)]
class mapInfo
{
    let height : Int
    let width  : Int
    var map    : [[String]]
    init(_ queue : inout [(Int,Int)])
    {
        let hw = readLine()!.split(separator:" ").map{Int(String($0))!}
        height = hw[0]
        width  = hw[1]
        map    = Array(repeating:[String](),count:height)
        for y in 0..<height
        {
            map[y] = readLine()!.map{String($0)}
            for x in 0..<width
            {
                if map[y][x] == "o" || map[y][x] == "v"
                {
                    queue.append((x,y))
                }
            }
        }
    }
}
func BFS(_ x : Int, _ y : Int,_ wolf : inout Int, _ sheep : inout Int, m : mapInfo, _ visited : inout [[Bool]])
{
    var queue     = [(x,y)]
    var index     = 0
    var tempWolf  = 0
    var tempSheep = 0
    while queue.count != index
    {
        let (curX,curY) = queue[index]
        if m.map[curY][curX] == "v"
        {
            tempWolf += 1
        }
        else if m.map[curY][curX] == "o"
        {
            tempSheep += 1
        }
        index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX+dx,curY+dy)
            if nx < 0 || nx > m.width - 1 || ny < 0 || ny > m.height - 1
            {
                continue
            }
            if m.map[ny][nx] != "#" && !visited[ny][nx]
            {
                visited[ny][nx] = true
                queue.append((nx,ny))
            }
        }
    }
    if tempSheep > tempWolf
    {
        sheep += tempSheep
    }
    else
    {
        wolf += tempWolf
    }
}
func BOJ_3184()
{
    var queue   = [(Int,Int)]()
    var index   = 0
    var wolf    = 0
    var sheep   = 0
    var m       = mapInfo(&queue)
    var visited = Array(repeating: Array(repeating: false, count: m.width), count: m.height)
    while queue.count != index
    {
        let (curX,curY) = queue[index]
        index += 1
        if !visited[curY][curX]
        {
            visited[curY][curX] = true
            BFS(curX, curY, &wolf, &sheep, m: m, &visited)
        }
        
    }
    print("\(sheep) \(wolf)")
}
BOJ_3184()
