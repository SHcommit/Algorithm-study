import Foundation

typealias qElement = (p : point, time: Int)
// 좌표
class point
{
    var x : Int
    var y : Int
    init(_ x : Int, _ y : Int)
    {
        self.x = x
        self.y = y
    }
}
//고슴도치 이동 좌표와 물이 차는 위치 좌표 담을 큐
class queue
{
    var q : [qElement]
    var index : Int
    init()
    {
        q = [qElement]()
        index = 0
    }
}
/**
 * forest 크기
 */
class rect
{
    var width  : Int
    var height : Int
    init()
    {
        if let hw = readLine()
        {
            let input = hw.split(separator: " ").map{Int($0)!}
            height = input[0]
            width  = input[1]
        }else
        {
            width  = -1
            height = -1
        }
    }
}

//범위 벗어났는가?
func isOutForest(p : point, rect: rect) -> Bool
{
    if p.x < 0 || p.x > rect.width - 1 || p.y < 0 || p.y > rect.height - 1
    {
        return true
    }
    return false
}
/**
 * 고슴도치의 목숨이 담긴 함수
 * 이 함수에서 while문이 끝나기 전까지 return 을 안하면 고슴도치의 운명은.... ㅠㅠ
 */
func escape(rect : rect, time : inout Int,fallIn : inout Bool, dochiQ : inout queue, waterQ : inout queue, forest : [[String]], direction : [(Int,Int)], visited : inout [[Bool]])
{
    
    while dochiQ.q.count != dochiQ.index
    {
        let (curPoint,prevTime) = dochiQ.q[dochiQ.index]
        if prevTime == time { time += 1 }
        dochiQ.index += 1
        
        flood(rect: rect, time: time, fallIn: &fallIn, queue: &waterQ, forest: forest, direction: direction, visited: &visited)

        
        for (dx,dy) in direction
        {
            let (nx,ny) = (curPoint.x + dx, curPoint.y + dy)
            if isOutForest(p: point(nx, ny), rect: rect) { continue }
            
            if forest[ny][nx] == "D"
            {
                return
            }
            
            if forest[ny][nx] == "." && !visited[ny][nx]
            {
                visited[ny][nx] = true
                dochiQ.q.append((point(nx, ny),prevTime + 1))
            }
        }
    }
    fallIn = true
}
// 숲에 매 분마다 물이 (주위로)범람함
func flood(rect : rect, time : Int, fallIn : inout Bool, queue : inout queue, forest : [[String]], direction : [(Int,Int)], visited : inout [[Bool]])
{
    while queue.q.count != queue.index
    {
        let (curPoint,prevTime) = queue.q[queue.index]
        if prevTime == time { return }
        queue.index += 1
        
        for (dx,dy) in direction
        {
            let (nx,ny) = (curPoint.x + dx, curPoint.y + dy)
            if isOutForest(p: point(nx, ny), rect: rect) || forest[ny][nx] == "D" || forest[ny][nx] == "X" { continue }
            
            if forest[ny][nx] == "." && !visited[ny][nx]
            {
                visited[ny][nx] = true
                queue.q.append((point(nx, ny),prevTime + 1))
            }
        }
    }
}

/**
 * @param direction : 특정 좌표가 이동할 수 있는 범위
 * @param rect         : 숲(맵) 크기 info
 * @param forest      : 숲(맵)
 * @param visited     : 방문했는가?
 * @param dochiQ    : 도치가 이동할 곳
 * @param waterQ    : 물이 범람하는 곳
 * @param fallIn        : 도치가 물에 빠졌는가?
 * @param time        : 분 체크
 */
func BOJ_3055()
{
    let direction = [(-1,0),(1,0),(0,1),(0,-1)]
    
    let rect      = rect()
    var forest    = Array(repeating: [String](), count: rect.height)
    var visited   = Array(repeating: Array(repeating: false, count: rect.width), count: rect.height)
    var dochiQ    = queue()
    var waterQ    = queue()
    var fallIn    = false
    var time      = 0
    
    // 도치 위치와 물 위치 받음
    for y in 0..<rect.height
    {
        if let col = readLine()
        {
            forest[y] = col.map{String($0)}
        }
        for x in 0..<rect.width
        {
            if forest[y][x] == "S"
            {
                dochiQ.q.append((point(x, y), 0))
                visited[y][x] = true
            } else if forest[y][x] == "*"
            {
                waterQ.q.append((point(x,y),0))
            }
        }
    }
    
    //도치의 여정
    escape(rect: rect, time: &time, fallIn: &fallIn, dochiQ: &dochiQ, waterQ: &waterQ, forest: forest, direction: direction, visited: &visited)
    
    print(fallIn == true ? "KAKTUS" : "\(time)")
}
BOJ_3055()
