import Foundation

typealias qElement = (Int,Int)
typealias vElement = [[Bool]]
let direction = [(-1,0),(1,0),(0,1),(0,-1)]

class mapInfo
{
    var width  : Int
    var height : Int
    var map    : [[Int]]
    init()
    {
        let n  = Int(readLine()!)!
        width  = n
        height = n
        map    = Array(repeating: [Int](), count: height)
        for i in 0..<height
        {
            map[i] = readLine()!.split(separator: " ").map{Int(String($0))!}
        }
        
    }
}
class Q
{
    var queue : [qElement]
    var index : Int
    init()
    {
        queue = [(qElement)]()
        index = 0
    }
}
func bfs(_ point : qElement, _ m : inout mapInfo, _ visited : inout [[Bool]],_ fisrtDetected : inout [[Bool]], needDetectedQueue nDQ : inout [Q])
{
    let q         = Q()
    let detectQ   = Q()
    q.queue.append((point.0,point.1))
    while q.queue.count != q.index
    {
        let (curX,curY) = q.queue[q.index]
        q.index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX + dx, curY + dy)
            if nx < 0 || nx > m.width - 1 || ny < 0 || ny > m.height - 1
            {
                continue
            }
            if !visited[ny][nx] && m.map[ny][nx] == 1
            {
                fisrtDetected[ny][nx] = true
                visited[ny][nx]       = true
                q.queue.append((nx,ny))
            }
            else if !visited[ny][nx] && m.map[ny][nx] == 0 && m.map[curY][curX] == 1
            {
                visited[ny][nx] = true
                detectQ.queue.append((nx,ny))
            }
        }
    }
    nDQ.append(detectQ)
}

func findBridge(_ minBridgeCount : inout Int,_ visited : [[Bool]], _ m : mapInfo, q : Q)
{
    var tempMap = m.map
    while q.queue.count != q.index
    {
        let (curX,curY) = q.queue[q.index]
        if tempMap[curY][curX] == 0
        {
            tempMap[curY][curX] += 1
        }
        q.index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX + dx, curY + dy)
            if nx < 0 || nx > m.width - 1 || ny < 0 || ny > m.height - 1
            {
                continue
            }
            if !visited[ny][nx] && tempMap[ny][nx] == 1
            {
                if minBridgeCount > tempMap[ny][nx]
                {
                    minBridgeCount = tempMap[curY][curX]
                    return
                }
            }
            else if !visited[ny][nx] && tempMap[ny][nx] == 0
            {
                tempMap[ny][nx] = tempMap[curY][curX] + 1
                q.queue.append((nx,ny))
            }
            if minBridgeCount != 9999 && tempMap[ny][nx] > minBridgeCount
            {
                return
            }
        }
    }
}
func BOJ_2146()
{
    var m                 = mapInfo()
    var visited           = [vElement]()
    var tempVisited       = Array(repeating: Array(repeating: false, count: m.width), count: m.height)
    var needDetectedQueue = [Q]()
    var nDQIndex          = 0
    var minBridgeCount    = 9999
    var firstDetected     = tempVisited
    for y in 0..<m.height
    {
        for x in 0..<m.width
        {
            if m.map[y][x] == 1 && !firstDetected[y][x]
            {
                firstDetected[y][x] = true
                tempVisited[y][x]   = true
                bfs((x,y), &m, &tempVisited, &firstDetected,needDetectedQueue: &needDetectedQueue)
                visited.append(tempVisited)
                tempVisited = Array(repeating: Array(repeating: false, count: m.width), count: m.height)
            }
        }
    }
    while(needDetectedQueue.count != nDQIndex)
    {
        findBridge(&minBridgeCount, visited[nDQIndex], m, q: needDetectedQueue[nDQIndex])
        nDQIndex += 1
    }
    print(minBridgeCount)
}
BOJ_2146()
