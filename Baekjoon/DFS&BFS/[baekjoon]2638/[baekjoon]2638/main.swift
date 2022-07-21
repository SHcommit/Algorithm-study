//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-2638-%EC%B9%98%EC%A6%88-%EA%B1%B0%EB%B6%81%EC%9D%B4-%EA%B0%99%EC%9D%80-%EB%82%B4-%EC%BD%94%EB%93%9C-%EA%B0%9C%EC%84%A0%EC%8B%9C%ED%82%A4%EA%B8%B0import Foundation
//탐색할 좌표
typealias Coord         = (x : Int, y : Int)
//탐색 방향
let direction : [Coord] = [(-1,0),(1,0),(0,1),(0,-1)]
//맵 정보
class mapInfo
{
    let width  : Int
    let height : Int
    var map    : [[Int]]
    init()
    {
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        height    = input[0]
        width     = input[1]
        map       = Array(repeating:[Int](),count:height)
        for i in 0..<height
        {
            map[i] = readLine()!.split(separator:" ").map{Int(String($0))!}
        }
    }
}
func airChange(_ coord : Coord,_ isRunning : inout Bool,_ m : inout mapInfo, _ visited : inout [[Int]])
{
    var queue = [(coord.x,coord.y)]
    var index = 0
    visited[coord.y][coord.x] = -1
    while queue.count != index
    {
        let (curX,curY) = queue[index]
        index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX+dx,curY+dy)
            if nx<0||nx>m.width-1||ny<0||ny>m.height-1 { continue }
            if visited[ny][nx] == -1
            {
                continue
            }
            if m.map[ny][nx] == 1
            {
                visited[ny][nx] += 1
                isRunning = true
            }
            else
            {
                visited[ny][nx] = -1
                queue.append((nx,ny))
            }
        }
    }
}

func BOJ_2638()
{
    var m         = mapInfo()
    var time      = 0
    var isRunning = true
    while isRunning
    {
        time += 1
        isRunning    = false
        var visited = Array(repeating: Array(repeating: 0, count: m.width), count: m.height)
        airChange((0,0),&isRunning, &m, &visited)
        for y in 0..<m.height
        {
            for x in 0..<m.width
            {
                if visited[y][x] >= 2
                {
                    m.map[y][x] = 0
                }
            }
        }
    }
    print(time - 1)
}
BOJ_2638()
