//https://www.acmicpc.net/problem/3055

import Foundation
/**
 * 고슴도치 : S
 * 비버       : D
 * 물          : *
 * 돌          : X
 *
 * S는 D로 최대한 빨리 도망가 홍수 피하려고 한다.
 *
 * 고슴도치는 물이 찰 예정인 칸으로 이동할 수 없다.
 * 즉, 다음 시간에 물이 찰 예정인 칸으로 고슴도치는 이동할 수 없다. 이동할 수 있으면 고슴도치가 물에 빠지기 때문이다.
 */


class rect
{
    let height : Int
    let width  : Int
    init()
    {
        let HW = readLine()!.split(separator: " ").map{Int($0)!}
        height = HW[0]
        width  = HW[1]
    }
}

func isOutEdge(x : Int, y : Int, rect : rect) -> Bool
{
    if x < 0 || x > rect.width - 1 || y < 0 || y > rect.height - 1
    {
        return true
    }
    return false
}
func flowing(rect : rect, forest : inout [[String]],visit : inout [[Int]], fallIn : inout Bool, arrive : inout Bool, queue: inout [(Int,Int)], index : inout Int, day : Int)
{
    let direction = [(-1,0),(1,0),(0,1),(0,-1)]
    while queue.count != index
    {
        let (curX, curY) = queue[index]
        if visit[curY][curX] != day
        {
            break
        }
        index += 1
        for (dx,dy) in direction
        {
            let (nx, ny) = (curX + dx, curY + dy)
            //해야할거는  방문체크랑 index랑 그다음 맵 차이가 1만 나야한다는거지,,
            if isOutEdge(x: nx, y: ny, rect: rect){ continue }
            if visit[ny][nx] == 0 && forest[ny][nx] == "."
            {
                if visit[curY][curX] == day
                {
                    queue.append((nx,ny))
                    visit[ny][nx] = visit[curY][curX] + 1
                    forest[ny][nx] = "*"
                }
            }
            else if visit[ny][nx] == 0 && forest[ny][nx] == "S"
            {
                return
            }
        }
    }
}

func escape(rect : rect ,forest : inout [[String]], visit : inout [[Int]], fallIn : inout Bool, arrive: inout Bool, queue: inout [(Int,Int)] , index : inout Int, day : Int)
{
    let direction = [(-1,0),(1,0),(0,1),(0,-1)]
    /**
     * 만약 0,0 대입됬다면. 1
     * 0,1 과 1,0.              2
     * 그리고 0,2 는 3인데 이게 안ㄴ되니까 큐에 집어넣지 않아 그래고 처음에
     */
    while(queue.count != index)
    {
        let (curX,curY) = queue[index]
        if visit[curY][curX] != day
        {
            break
        }
        index += 1
        for (dx,dy) in direction
        {
            let (nx, ny) = (curX + dx, curY + dy)
            //해야할거는  방문체크랑 index랑 그다음 맵 차이가 1만 나야한다는거지,,
            if isOutEdge(x: nx, y: ny, rect: rect){ continue }
            if visit[ny][nx] == 0 && forest[ny][nx] == "."
            {
                if visit[curY][curX] == day
                {
                    queue.append((nx,ny))
                    visit[ny][nx] = visit[curY][curX] + 1
                    forest[ny][nx] = "D"
                }
            }
            else if visit[ny][nx] == 0 && forest[ny][nx] == "S"
            {
                visit[ny][nx] = visit[curY][curX] + 1
                arrive = true
                fallIn = false
                return
            }
        }
    }
}

func BOJ_3055()
{
    let r            = rect()
    var fallIn       = false
    var arrive       = false
    var forest       = Array(repeating: [String](), count: r.height)
    var escapeStart  = (0,0)
    var escapeVisit  = Array(repeating: Array(repeating: 0, count: r.width), count: r.height)
    var escapeQueue  = [(Int,Int)]()
    var escapeIndex  = 0
    var flowingVisit = escapeVisit
    var flowingStart = (0,0)
    var flowingQueue = [(Int,Int)]()
    var flowingIndex = 0
    var day          = 0
    
    for y in 0..<r.height
    {
        forest[y] = readLine()!.map{String($0)}
    }
    for y in 0..<r.height
    {
        for x in 0..<r.width
        {
            if forest[y][x] == "D"
            {
                escapeStart = (x,y)
            }
            if forest[y][x] == "*"
            {
                flowingStart = (x,y)
            }
        }
    }
    
    escapeVisit[escapeStart.1][escapeStart.0] = 1
    flowingVisit[flowingStart.1][flowingStart.0] = 1
    escapeQueue.append(escapeStart)
    flowingQueue.append(flowingStart)

    while !arrive
    {
        day += 1
        escape(rect : r, forest: &forest, visit: &escapeVisit, fallIn: &fallIn, arrive: &arrive,queue: &escapeQueue, index: &escapeIndex,day: day)
        if arrive
        {
             break
        }
        flowing(rect : r, forest: &forest, visit: &flowingVisit, fallIn: &fallIn, arrive: &arrive, queue: &flowingQueue,index: &flowingIndex, day: day)
    }
    print(fallIn == true ? "KAKTUS" : "\(day)")
}
BOJ_3055()
