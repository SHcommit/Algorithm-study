import Foundation
//탐색할 좌표
typealias Coord         = (x : Int, y : Int)
//치즈 탐색 할 좌표와 그 좌표가 녹아야 하는지 여부
typealias Element       = (point : Coord, isMelt: Bool)
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
//외부공기와 마주한 내부 공기가 있는가?
func airChange(_ coord : Coord,_ m : inout mapInfo, _ visited : inout [[Bool]])
{
    var queue = [(coord.x,coord.y)]
    var index = 0
    visited[coord.y][coord.x] = true
    if m.map[coord.y][coord.x] == 0
    {
        m.map[coord.y][coord.x] = -1
    }
    while queue.count != index
    {
        let (curX,curY) = queue[index]
        index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX+dx,curY+dy)
            if nx<0||nx>m.width-1||ny<0||ny>m.height-1 { continue }
            //이 조건은 외부공기와 마주한 내부 공기이다.
            if !visited[ny][nx] && m.map[ny][nx] == 0
            {
                visited[ny][nx] = true
                m.map[ny][nx]   = -1
                queue.append((nx,ny))
            }
            else if !visited[ny][nx] && m.map[ny][nx] == -1
            {
                visited[ny][nx] = true
                queue.append((nx,ny))
            }
        }
    }
}

// 치즈가 녹을 가능성이 있는가?
func isMelting(_ coord : Coord, _ map : mapInfo) -> Bool
{
    var cnt = 0
    for (dx,dy) in direction
    {
        let (nx,ny) = (coord.x+dx,coord.y+dy)
        if map.map[ny][nx] == -1
        {
            cnt += 1
        }
        if cnt >= 2
        {
            return true
        }
    }
    return false
}
//치즈를 탐색하며 치즈가 녹는지의 여부를 체크해 치즈를 녹인다.
func MeltingCheese(_ coord : Coord, _ m : inout mapInfo, _ visited : inout [[Bool]])
{
    var queue = [Element]()
    var index = 0
    queue.append((coord,isMelting(coord, m)))
    while queue.count != index
    {
        let ((curX,curY), _ ) = queue[index]
        index += 1
        direction.forEach
        {
            let (nx,ny) = (curX+$0.x , curY+$0.y)
            if nx<0||nx>m.width-1||ny<0||ny>m.height-1 { return }
            if !visited[ny][nx] && m.map[ny][nx] == 1
            {
                visited[ny][nx] = true
                if isMelting((nx,ny), m)
                {
                    queue.append(((nx,ny), true))
                }
                else
                {
                    queue.append(((nx,ny),false))
                }
            }
        }
    }
    //녹을 치즈들을 녹인다.
    for ((x,y),isMelt) in queue
    {
        if isMelt
        {
            m.map[y][x] = -1
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
        var visited  = Array(repeating: Array(repeating:false, count:m.width), count : m.height)
        airChange((0,0), &m, &visited)
        time += 1
        isRunning    = false
        //완전탐색을 통해 치즈를 찾는다.
        for y in 0..<m.height
        {
            for x in 0..<m.width
            {
                if m.map[y][x] == 1 && !visited[y][x]
                {
                    visited[y][x] = true
                    isRunning     = true
                    MeltingCheese((x,y), &m, &visited)
                }
            }
        }
    }
    print(time - 1)
}
BOJ_2638()
