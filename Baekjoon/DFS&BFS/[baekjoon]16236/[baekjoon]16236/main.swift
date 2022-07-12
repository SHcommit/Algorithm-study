import Foundation
//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-16236-%EC%95%84%EA%B8%B0-%EC%83%81%EC%96%B4-%EB%AC%B8%EC%A0%9C-%EB%BF%8C%EC%88%98%EA%B8%B0?category=1089781

//탐색 방향
let directon           = [(-1,0),(1,0),(0,-1),(0,1)]

/*
    - param Element   : ( x 탐색 좌표, y 탐색 좌표, time 최소 거리)
    - param sharkType : ( x 샤크 있는곳, y 샤크 있는곳, size 현재 샤크 크기, exp 특정 크기 일 때 샤크가 먹이 먹은개수)
 */
typealias Element      = (x : Int, y : Int, time : Int)
typealias sharkType = (x : Int, y : Int, size : Int, exp : Int)

/*
    TODO : 상어가 위치한 곳에서부터 시작해서 bfs탐색을 하며 먹을 수 있는 물고기를 찾아 나선다.
            문제에서 언급된 조건에 의해 최소거리 이면서도 최소 거리에서 물고기가 2개, or 3개 이상일 때 가장 최적의 물고기를 먹을 수
            있도록 먹이를 sorting한다.
 
    - param visited : 중복된 방문 피하기 위해 방문 체크
    - param queue   : 상어가 이동 할 수 있는 좌표들 저장
    - param eatList : 상어가 특정 최소 거리일 때 먹을 수 있는 물고기들 전부 저장
    - param index   : queue배열을 탐색하기 위한 인덱스
 
    추후 eatList에서 소팅이 가장 중요함. 이 문제의 핵심?!
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
    
    /*
     * 만약 eatList(먹이를 먹을 수 있는 좌표)가 비어있지않다면 샤크는 계속해서 먹이를 먹을 수 있으므로
        isRunning = true!!
     
     * 같은 시간(== 같은 최소 거리 일 때)
     * 리스트에 원소.y가 그림 4의 경우라면? 둘다 위에인데 ? 그럼 맨 왼쪽꺼!!
     
     * 그게 아니면 맨 위에 좌표
     
     * 그게 아니라면 최소거리(time)가 낮은 것 부터
     */
    if !eatList.isEmpty
    {
        eatList.sort
        {
            if $0.time == $1.time
            {
                if $0.y == $1.y
                {
                    return $0.x < $1.x
                }
                else
                {
                    return $0.y < $1.y
                }
            }
            else
            {
                return $0.time < $1.time
            }
        }
        // 최적의 먹잇감을 샤크가 먹고 그 좌표로 샤크의 위치를 대체합니다. 이때 래밸업 할 것인가 겸치만 증가할 것인가?
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

/*
    - param n         : 맵 크기
    - param map       : 맵 정보
    - param shark.    : 샤크의 저장 위치 ( 추후 map에서 샤크의 초기 위치 9 -> 0 으로 바꾼다.)
    - param time      : 샤크의 이동 거리
    - param isRunning : 샤크가 먹이를 먹을 수 있는가?
                            샤크가 먹이를 먹을 수 있으면 true 더이상 eatList에 원소가 없다면 탐색 종료
 */
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
 상어의 특정 위치에서 bfs 탐색을 하면서 먹을수있는 먹이를 list에 저장하는데 여기서 거리가 최소인거 이와 동시에 list의 좌표에 들어있는 게 둘다 같은 위쪽방향일땐 왼쪽거, 만약 위쪽이 아니면 위쪽꺼!!  먹는 방식으로 sort를 지정해야 한다..
 */
