import Foundation
let directon           = [(-1,0),(1,0),(0,-1),(0,1)]
typealias Element      = (x : Int, y : Int, time : Int)
typealias sharkType = (x : Int, y : Int, size : Int, exp : Int)

/**
  그러니까
 약간의 정리.
 문제를 햇갈린게 상어가 만약에 탐색할때 가장 작은거만 탐색하는건데 난 같은거도 먹지는 않는데 먹는다는?? 가정을 해서 쉽게 문제를 이해하지 못했음.,
 
 결국 bfs를 사용할때는 상어가 동시에 이동해서 먹이를 먹도록 그런 bfs 탐색을 하는게 아니라 특정 상어 위치에서!! 먹이가 존재할때까지 bfs탐색을 통해
 탐색하는데.
 
 4 3 2 1
 0 0 0 0
 0 0 9 0
 1 2 3 4
 
 여기서 (4,0)이랑 (0,4) 두가지 경우가 잇는데 이럴 땐 좌 먼저 갈지 우 먼저 갈지 했갈렸는데
 일단 문제에서 1마리면 그거먹는데 2마리면 (가장 가까운 물고기가 많다면~) 이러면 위에꺼 근데 3마리 이상 있으면 그땐 가장 왼쪽..
 상어의 특정 위치에서 bfs 탐색을 하면서 먹을수있는 먹이를 list에 저장하는데 여기서 거리가 최소인거 이와 동시에 list의 좌표에 들어있는 게 둘다 같은 위쪽방향일땐 왼쪽거, 만약 위쪽이 아니면 위쪽꺼!! 먹는 방식으로 sort를 지정해야 한다..
 */
func BFS(_ n : Int,_ isRunning : inout Bool,_ time : inout Int, _ shark : inout sharkType, _ map : inout [[Int]])
{
    var visited  = Array(repeating: Array(repeating: false, count: n), count: n)
    var queue    = [Element]()
    var eatList  = [Element]()
    var index    = 0
    //상어 현 x,y위치 그리고 이동 거리 0
    queue.append((shark.x,shark.y, 0))
    visited[shark.y][shark.x] = true
    
    while queue.count != index
    {
        let (curX,curY,curTime) = queue[index]
        index += 1
        for (dx,dy) in directon
        {
            let (nx,ny) = (curX+dx, curY+dy)
            if nx < 0 || nx > n - 1 || ny < 0 || ny > n - 1
            {
                continue
            }
            if map[ny][nx] <= shark.size && !visited[ny][nx]
            {
                if map[ny][nx] == 0 || map[ny][nx] == shark.size
                {
                    visited[ny][nx] = true
                    queue.append((nx,ny,curTime + 1))
                }
                else if map[ny][nx] < shark.size
                {
                    eatList.append((nx,ny,curTime + 1))
                    visited[ny][nx] = true
                }
            }
        }
    }
    if !eatList.isEmpty
    {
        eatList.sort
        {
            if $0.time == $1.time
            {
                if $0.y == $1.y
                {
                    //위에꺼
                    //맨처음 좌측위 는 4,0 우하 는 0,4 잖아.. 0이 작아야해 위니까
                    return $0.x < $1.x
                }
                else
                {
                    //왼쪽꺼부터 만약에 아 안같으면 어 위에ㅐ 두개있으면 왼쪽 그리고 위가 안같으면 무조건 위!!
                    return $0.y < $1.y
                }
            }
            else
            {
                return $0.time < $1.time
            }
        }
        let eat = eatList.first!
        if shark.size > map[eat.y][eat.x]
        {
            time += eat.time
            isRunning = true
            if shark.size == shark.exp + 1
            {
                shark = ((eat.x,eat.y,shark.size + 1, 0))
            }
            else
            {
                shark = ((eat.x,eat.y,shark.size, shark.exp + 1))
            }
            map[shark.y][shark.x] = 0
        }
    }
}
func BOJ_16236()
{
    let n     = Int(readLine()!)!
    var map   = Array(repeating: [Int](), count: n)
    var shark : sharkType = (0,0,2,0)
    var time  = 0
    var isRunning = true
    for y in 0..<n
    {
        map[y] = readLine()!.split(separator:" ").map{Int(String($0))!}
        if map[y].contains(9)
        {
            let x = map[y].firstIndex(of: 9)
            shark = (x!,y,2,0)
            map[y][x!] = 0
        }
    }
    while isRunning
    {
        isRunning = false
        BFS(n, &isRunning, &time, &shark, &map)
    }
    print(time)
}
BOJ_16236()
