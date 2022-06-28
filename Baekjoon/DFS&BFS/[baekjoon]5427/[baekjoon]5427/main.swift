import Foundation

typealias qElement = (Int,Int,Int)

func isOutEdge(_ nx : Int, _ ny : Int, _ curX : Int, _ curY : Int, _ width: Int, _ height : Int, building : [[String]], isEscape : inout Bool) -> Bool
{
    if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1
    {
        if building[curY][curX] == "@"
        {
            isEscape = true
            return false
        }
        return true
    }
    return false
}
func fire(_ width : Int, _ height : Int, _ x: Int, _ y : Int, _ prevTime : Int, _ time : Int, _ visited : inout [[Bool]], _ building : inout [[String]], _ queue : inout[qElement])
{
    let direction = [(-1,0),(1,0),(0,1),(0,-1)]
    var temp      = false
    
    for (dx,dy) in direction
    {
        let (nx, ny) = (dx + x, dy + y)
        if isOutEdge(nx, ny, x, y, width, height, building: building, isEscape: &temp)
        {
            continue
        }
        if visited[ny][nx] == false && building[ny][nx] == "."
        {
            visited[ny][nx]  = true
            queue.append((nx,ny,prevTime + 1))
            building[ny][nx] = "*"
        }
//        if visited[ny][nx] == true && building[ny][nx] == "@"
//        {
//            building[ny][nx] = "*"
//        }
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
            
//            var _ = {
//                for y in 0..<height
//                    {
//                    var test = ""
//                    for x in 0..<width
//                        {
//                            test += building[y][x] + " "
//                        }
//                    print(test)
//                }
//            }()
        }
        for (dx, dy) in direction
        {
            let (nx,ny) = (curX + dx, curY + dy)
            if isOutEdge(nx, ny, curX, curY, width, height, building: building, isEscape: &isEscape)
            {
                continue
            }
            if isEscape == true
            {
                res += "\(time)\n"
                return
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
