import Foundation
// 좌 우 상 하 대각선 탐색
let direction = [(-1,0),(1,0),(0,1),(0,-1),(-1,-1),(-1,1),(1,-1),(1,1)]
/**
 * height = N
 * width  = M
 * map   = 상어 1 과 상어가 없는 0이 들어있는 맵 정보
 */
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
/**
 * 메모리 초과 걸리지 않도록 이전에 탐색한 곳은 visited 체크를 통해 더이상 큐에 넣지 않았다.
 */
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
    //완전 탐색
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
