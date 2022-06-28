import Foundation
/**
 * @param qElement : (x좌표,y좌표, x-y좌표 탐색시 현재 시간)
 */
typealias qElement = (Int,Int,Int)
/**
 * removeFirst()를써서 시간초과 났습니다.
 * 큐에 원소들 삭제 안하고 index로 훑는 방식을 쓰려고 큐 클래스를 만들었습니다.
 */
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
/**
 * 불에 의해 prevTime != (current)Time일때까지
 * 큐에 존재하는 원소들을 통해 빈 지점을 계속해서 탐색해 나갑니다.
 * 만약 prevTime = Time일 경우 1초가 지난 것으로 판단하고 break합니다.
 */
func fire(_ width : Int, _ height : Int, _ time : Int, _ building : inout [[String]], _ queue : inout Queue)
{
    let direction = [(-1,0),(1,0),(0,1),(0,-1)]
    while queue.queue.count != queue.index
    {
        //prevTime == currentTime인가? (1초지난거로 판단)
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
            //빈 지점 불태워~
            if building[ny][nx] == "."
            {
                queue.queue.append((nx,ny,prevTime + 1))
                building[ny][nx] = "*"
            }
            //상근이가 있을 수 있는 케이스인데 이 또한 안되므로 불로 바꾸었습니다.
            if building[ny][nx] == "@"
            {
                building[ny][nx] = "*"
            }
        }
    }
}
/**
 * 상근이의 탈출 입니다.
 * time은 현재시간이고, 앞으로 이 시간이 증가되는데 증가될 때마다
 * fire에 의해 먼저 빈 지역이 불타고
 * 이와 동시에 상근이도 탈출 가능성 있는 지역을 bfs로 queue에 집어넣으면서
 * 매 초마다 상근이가 탈출 할 지점을 찾아서 탈출을 하게 된다면
 *
 *
 * 맵 지역을 벗어나는 것인데 이때 단순하게 맵 지역 벗어나는 체크를 할 때 curX,Y가 "@"이면 탈출 성공으로 간주하고 isEscape 를 true로 바꿨습니다.
 * 만약 escape가 종료되었음에도 isEscape 변수가 false면 상근이는 탈출하지 못한 것이므로 임파써블을 출력하도록 했습니다.
 */
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
