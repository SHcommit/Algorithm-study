import Foundation
//탐색할 x,y좌표 그때의 진행 상황
typealias point = (x:Int,y:Int,time:Int)
//탐색할 방향
let direction   = [(-1,0),(1,0),(0,1),(0,-1)]
//최소시간 저장
var result      = 2501

/**
 TODO : 맵의 정보를 저장하는 클래스
 
 - Param n : 맵 크기
 - Param totalCnt : 선택해야 할 바이러스 M개 개수
 - Param map : 맵 정보
 - Param list : 맵에서 바이러스를 놓을 수 있는 좌표들 저장
 */
class mapInfo
{
    let n        : Int
    let totalCnt : Int
    var map      : [[Int]]
    var list     : [point]
    init()
    {
        let input = readLine()!.split(separator:" ").map{Int(String($0))!}
        n         = input[0]
        totalCnt  = input[1]
        map       = Array(repeating: [Int](), count: n)
        list      = [point]()
        for y in 0..<n
        {
            map[y] = readLine()!.split(separator:" ").map{Int(String($0))!}
            for x in 0..<n
            {
                if map[y][x] == 2
                {
                    list.append((x,y,0))
                }
            }
        }
    }
}

/**
 dfs를 통해 특정 index를 선택했다면 queue에 삽입될 것이고 해당 큐를 통해 바이러스가 퍼짐
 
 - parameter m: 맵 정보.
 - parameter visited: (중복 방문 안되기 위해) 방문 체크.
 - parameter queue: 선택된 바이러스 좌표들.
 
 # Notes: #
 1. 만약 바이러스가 선택됬음에도 바이러스가 퍼지지 않는 칸이 있을 수 있다.
    그래서 마지막에 완전 탐색으로 파악해준다.
 */
func bfs(_ m : mapInfo, _ visited : inout [[Bool]], _ queue : inout [point])
{
    var index = 0
    var time  = 0
    while queue.count != index
    {
        let (curX,curY,prevTime) = queue[index]
        index += 1
        if time == prevTime
        {
            time += 1
        }
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX+dx,curY+dy)
            if nx<0||nx>m.n-1||ny<0||ny>m.n-1||visited[ny][nx] { continue }
            if m.map[ny][nx] != 1
            {
                visited[ny][nx] = true
                queue.append((nx,ny,prevTime+1))
            }
        }
    }
    if time > result
    {
        return
    }
    for y in 0..<m.n
    {
        for x in 0..<m.n
        {
            if !visited[y][x] && m.map[y][x] != 1
            {
                return
            }
        }
    }
    result = time
}

/**
 바이러스들이 있는 list에서 M개의 바이러스를 선택하기 위한 함수
 
 - parameter index: 선택될 숫자의 시작.
 - parameter curCnt: dfs함수 실행될 때 현재 몇개의 index들을 선택했는지?
 - parameter selected: 선택된 숫자들을 체크하는 배열.
 - parameter map: 맵 정보. 여기에 바이러스가 놓일 좌표들이 있는 list가 있음
 
 # Notes: #
 1. if curCnt == m.totalCnt
    만약 바이러스 놓을 수 있는 특정 개수를 선택했다면
    queue에 그 바이러스들 추가시키고 bfs탐색하기!!
 */
func dfs(_ index : Int,_ curCnt : Int,_ selected : inout [Bool],_ m : mapInfo )
{
    if curCnt == m.totalCnt
    {
        var queue   = [point]()
        var visited = Array(repeating:Array(repeating:false,count:m.n),count:m.n)
        for i in 0..<m.list.count
        {
            if selected[i]
            {
                let (x,y,time) = m.list[i]
                visited[y][x] = true
                queue.append((x,y,time))
            }
        }
        bfs(m, &visited, &queue)
        return
    }
    for i in index..<m.list.count
    {
        if selected[i] { continue }
        selected[i] = true
        dfs(i+1,curCnt+1, &selected, m)
        selected[i] = false
    }
}

// m = 맵 정보
// dfs호출 시 시작은 index 0 부터!! 이때 현재 선택된 개수도 0부터
func BOJ_17141()
{
    let m        = mapInfo()
    var selected = Array(repeating:false,count:m.list.count)
    dfs(0,0, &selected, m)
    print(result == 2501 ? -1 : result - 1)
}
BOJ_17141()
