import Foundation
typealias Coord         = (x : Int, y : Int)
typealias Element       = (point : Coord, isMelt: Bool)
let direction : [Coord] = [(-1,0),(1,0),(0,1),(0,-1)]
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

func isChangingCheeseAir(_ coord : Coord,_ isEsposedAir : inout Bool,_ map : inout mapInfo,_ visited : inout [[Bool]])
{
    for (dx,dy) in direction
    {
        let (nx,ny) = (coord.x+dx,coord.y+dy)
        if map.map[ny][nx] == -1
        {
            isEsposedAir = true
            return
        }
    }
}

func changeCheeseAir(_ coord : Coord, _ m : inout mapInfo, _ visited : inout [[Bool]])
{
    var queue        = [coord]
    var index        = 0
    var isExposedAir = false
    queue.append(coord)
    
    while queue.count != index
    {
        let (curX,curY) = queue[index]
        index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX+dx,curY+dy)
            if !visited[ny][nx] && m.map[ny][nx] == 0
            {
                visited[ny][nx] = true
                queue.append((nx,ny))
                isChangingCheeseAir((nx,ny), &isExposedAir, &m, &visited)
            }
        }
    }
    if isExposedAir
    {
        for (x,y) in queue
        {
            m.map[y][x] = -1
        }
    }
}

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

func MeltingCheese(_ coord : Coord, _ m : inout mapInfo, _ visited : inout [[Bool]], _ airQueue : inout [Coord])
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
            }else if !visited[ny][nx] && m.map[ny][nx] == 0
            {
                visited[ny][nx] = true
                airQueue.append((nx,ny))
            }
        }
    }
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
    var airQueue  = [Coord]()
    var airIndex  = 0
    while isRunning
    {
        var visited  = Array(repeating: Array(repeating:false, count:m.width), count : m.height)
        airChange((0,0), &m, &visited)
        time += 1
        //var airCheck = visited
        isRunning    = false
        for y in 0..<m.height
        {
            for x in 0..<m.width
            {
                if m.map[y][x] == 1 && !visited[y][x]
                {
                    visited[y][x] = true
                    isRunning     = true
                    MeltingCheese((x,y), &m, &visited,&airQueue)
                }
            }
        }
//        while airQueue.count != airIndex
//        {
//            let (x,y) = airQueue[airIndex]
//            airIndex += 1
//            if !airCheck[y][x]
//            {
//                airCheck[y][x] = true
//                changeCheeseAir((x,y), &m, &airCheck)
//            }
//        }
        print()
        let _ =
        {
            for y in 0..<m.height
            {
                var temp = ""
                for x in 0..<m.width
                {
                    temp += m.map[y][x] == 1 ? " \(m.map[y][x]) " : "\(m.map[y][x]) "
                }
                print(temp)
            }
        }
        print()
    }
    print(time - 1)
}
BOJ_2638()
