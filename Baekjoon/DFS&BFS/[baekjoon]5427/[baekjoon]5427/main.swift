import Foundation

typealias qElement = (Int,Int,Int)
class Queue
{
    var queue : [qElement]
    var index : Int
    init()
    {
        queue = [qElement]()
        index = 0
    }
}
func fire(_ width : Int, _ height : Int, _ time : Int, _ building : inout [[String]], _ queue : inout Queue)
{
    let direction = [(-1,0),(1,0),(0,1),(0,-1)]
    while queue.queue.count != queue.index
    {
        if queue.queue[queue.index].2 == time
        {break}
        let (curX,curY,prevTime) = queue.queue[queue.index]
        queue.index += 1
        for (dx,dy) in direction
        {
            let (nx, ny) = (dx + curX, dy + curY)
            if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1
            {
                continue
            }
            if building[ny][nx] == "."
            {
                queue.queue.append((nx,ny,prevTime + 1))
                building[ny][nx] = "*"
            }
            if building[ny][nx] == "@"
            {
                building[ny][nx] = "*"
            }
        }
    }
}
func escape(_ width : Int, _ height : Int, _ res : inout String, _ isEscape : inout Bool, _ building : inout [[String]], _ queue : inout Queue, _ fQueue : inout Queue)
{
    var time      = 0
    let direction = [(-1,0),(1,0),(0,1),(0,-1)]
    while queue.queue.count != queue.index
    {
        let (curX,curY,prevTime) = queue.queue[queue.index]
        queue.index += 1
        if prevTime == time
        {
            fire(width, height, time, &building, &fQueue)
            time += 1
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
            if building[ny][nx] == "." && building[curY][curX] == "@"
            {
                building[ny][nx] = "@"
                queue.queue.append((nx,ny,prevTime + 1))
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
        var building = Array(repeating: [String](), count: height)
        var queue    = Queue()
        var fireQ    = Queue()
        for y in 0..<height
        {
            building[y] = readLine()!.map{String($0)}
            for x in 0..<width
            {
                if building[y][x] == "@"
                {
                    queue.queue.append((x,y,0))
                }
                if building[y][x] == "*"
                {
                    fireQ.queue.append((x,y,0))
                }
            }
        }
        escape(width, height, &res, &isEscape, &building, &queue, &fireQ)
        if !isEscape
        {
            res += "IMPOSSIBLE\n"
        }
    }
    print(res)
}
BOJ_5427()
