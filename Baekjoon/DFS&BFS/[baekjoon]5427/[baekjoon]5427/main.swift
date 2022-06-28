import Foundation

typealias qElement = (Int,Int,Int)

func fire(_ width : Int, _ height : Int, _ x: Int, _ y : Int, _ prevTime : Int, _ time : Int, _ visited : inout [[Bool]], _ building : inout [[String]], _ queue : inout[qElement])
{
    let direction = [(-1,0),(1,0),(0,1),(0,-1)]
    for (dx,dy) in direction
    {
        let (nx, ny) = (dx + x, dy + y)
        if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1
        {
            continue
        }
        if visited[ny][nx] == false && building[ny][nx] == "."
        {
            visited[ny][nx]  = true
            queue.append((nx,ny,prevTime + 1))
            building[ny][nx] = "*"
        }
    }
}
func escape(_ width : Int, _ height : Int, _ time : inout Int, _ res : inout String, _ isEscape : inout Bool, _ visited: inout [[Bool]], _ building : inout [[String]], _ queue : inout [qElement])
{
    let direction = [(-1,0),(1,0),(0,1),(0,-1)]
    while !queue.isEmpty
    {
        let (curX,curY,prevTime) = queue.removeFirst()
        if prevTime == time
        {
            time += 1
        }
        if building[curY][curX] == "*"
        {
            fire(width, height, curX, curY,prevTime, time, &visited, &building, &queue)
        }
        for (dx, dy) in direction
        {
            let (nx,ny) = (curX + dx, curY + dy)
            if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1
            {
                if building[curY][curX] == "@"
                {
                    isEscape = true
                    res += "\(time)\n"
                    return
                }
                continue
            }
            if building[ny][nx] == "." && !visited[ny][nx]
            {
                visited[ny][nx] = true
                building[ny][nx] = "@"
                queue.append((nx,ny,prevTime + 1))
            }
        }
    }
}

func BOJ_5427()
{
    let n   = Int(readLine()!)!
    var res = ""
    
    for _ in 0..<n
    {
        var isEscape = false
        let wh       = readLine()!.split(separator: " ").map{Int(String($0))!}
        let width    = wh[0]
        let height   = wh[1]
        var time     = 0
        var building = Array(repeating: [String](), count: height)
        var visited  = Array(repeating: Array(repeating: false, count: width), count: height)
        var queue    = [qElement]()
        for y in 0..<height
        {
            building[y] = readLine()!.map{String($0)}
        }
        for y in 0..<height
        {
            for x in 0..<width
            {
                if building[y][x] == "*" || building[y][x] == "@"
                {
                    queue.append((x,y,0))
                    visited[y][x] = true
                }
            }
        }
        escape(width, height, &time, &res, &isEscape, &visited, &building, &queue)
        if !isEscape
        {
            res += "IMPOSSIBLE\n"
        }
    }
    print(res)
}
BOJ_5427()
