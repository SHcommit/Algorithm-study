import Foundation
typealias Element = (Int,Int)
let direction = [(-1,0),(1,0),(0,1),(0,-1)]
class Q
{
    var queue    : [Element]
    var index    : Int
    var totalSum : Int
    init()
    {
        queue    = [Element]()
        index    = 0
        totalSum = 0
    }
}
class mapInfo
{
    let n       : Int
    let minMove : Int
    let maxMove : Int
    var map     : [[Int]]
    init()
    {
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        n       = input[0]
        minMove = input[1]
        maxMove = input[2]
        map     = Array(repeating: [Int](), count: n)
        for i in 0..<n
        {
            map[i] = readLine()!.split(separator: " ").map{Int(String($0))!}
        }
    }
}
func bfs(_ land : mapInfo, _ visited : inout [[Bool]], _ q : inout Q)
{
    let (x,y) = q.queue[q.index]
    q.totalSum += land.map[y][x]
    
    while(q.queue.count != q.index)
    {
        let (curX,curY) = q.queue[q.index]
        q.index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX + dx, curY + dy)
            if nx < 0 || nx > land.n - 1 || ny < 0 || ny > land.n - 1
            {
                continue
            }
            if !visited[ny][nx]
            {
                let rc = abs(land.map[ny][nx] - land.map[curY][curX])
                if rc >= land.minMove && rc <= land.maxMove
                {
                    q.totalSum += land.map[ny][nx]
                    
                    visited[ny][nx] = true
                    q.queue.append((nx,ny))
                }
            }
        }
    }
}
func BOJ_16234()
{
    var land = mapInfo()
    var day  = 0
    var canMove = true
    while canMove
    {
        var visited   = Array(repeating: Array(repeating: false, count: land.n), count: land.n)
        var queueList = [Q]()
        canMove       = false
        for y in 0..<land.n
        {
            for x in 0..<land.n
            {
                if !visited[y][x]
                {
                    var queue = Q()
                    var flag  = false
                    for (dx,dy) in direction
                    {
                        let (nx,ny) = (x + dx, y + dy)
                        if nx < 0 || nx > land.n - 1 || ny < 0 || ny > land.n - 1
                        {
                            continue
                        }
                        let rc = abs(land.map[ny][nx] - land.map[y][x])
                        if rc >= land.minMove && rc <= land.maxMove
                        {
                            flag      = true
                            canMove   = true
                            visited[y][x] = true
                            queue.queue.append((x,y))
                            bfs(land, &visited, &queue)
                            break
                        }
                    }
                    if flag == true
                    {
                        queueList.append(queue)
                    }
                }
            }
        }
        if canMove
        {
            day += 1
            for i in 0..<queueList.count
            {
                queueList[i].totalSum = queueList[i].totalSum/queueList[i].queue.count
                queueList[i].index = 0
                while queueList[i].queue.count != queueList[i].index
                {
                    let (curX,curY) = queueList[i].queue[queueList[i].index]
                    queueList[i].index += 1
                    land.map[curY][curX] = queueList[i].totalSum
                }
            }
        }
    }
    print(day)
}
BOJ_16234()
