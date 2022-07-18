import Foundation
//바라보는 방향에 따라 왼쪽으로 전진
let direction  = [(-1,0),(0,-1),(1,0),(0,1)]
//바라보는 방향에 반대로 후진
let backDirect = [(0,1),(-1,0),(0,-1),(1,0)]

//맵 정보
class mapInfo
{
    let width  : Int
    let height : Int
    var map    : [[Int]]
    let start  : (x : Int, y : Int, direct : Int)
    init()
    {
        let input  = readLine()!.split(separator: " ").map{Int(String($0))!}
        height     = input[0]
        width      = input[1]
        let sPoint = readLine()!.split(separator:" ").map{Int(String($0))!}
        start      = (sPoint[1], sPoint[0], sPoint[2])
        map        = Array(repeating: [Int](),count: height)
        for y in 0..<height
        {
            map[y] = readLine()!.split(separator: " ").map{Int(String($0))!}
        }
    }
}

/**
 dfs탐색
 
 - parameter x: 현재 청소 할 x좌표.
 - parameter y: 현재 청소 할 y좌표.
 - parameter front: 로봇 청소기가 바라보는 방향.
 - parameter clean: 청소 누적 횟수.
 - parameter m: 맵 정보.
 
 # Notes: #
 1. 매개변수x,y 를 통해 현재 좌표에서 로봇이 바라보는 방향 front의 왼쪽 방향으로 회전 후 청소할 공간이 있을 때 전진하며 청소를 진행해간다.
 2. 바라보는 방향에서 90도 회전을 4번했는데 더이상 청소할 공간이 없다면
 3. 바라보는 방향 front에 대한 back 작업을 진행한다.
 4. 주의할 점이 맵의 벽이 1로 둘러진 경우만 생각할 게 아니라 맵의 0 0 좌표 일때도 로봇이 존재할 경우가 있다. 예외처리를 잘 해주어야 한다.
 */
func DFS(_ x : Int, _ y : Int, _ front : Int, _ clean : inout Int, _ m : mapInfo, _ visited : inout [[Bool]])
{
    var index = front
    for _ in 0..<4
    {
        let (dx,dy) = direction[index]
        index -= 1
        if index == -1
        {
            index = 3
        }
        let (nx,ny) = (x+dx,y+dy)
        if nx<0||nx>m.width-1||ny<0||ny>m.height-1
        {
            continue
        }
        if m.map[ny][nx] == 0 && !visited[ny][nx]
        {
            visited[ny][nx] = true
            clean += 1
            DFS(nx, ny, index, &clean, m, &visited)
        }
    }

    let (backxD,backyD) = backDirect[front]
    let (backX,backY)   = (x + backxD,y + backyD)
    if backX < 0 || backX > m.width-1 || backY < 0 || backY > m.height-1
    {
        print(clean)
        exit(0)
    }
    if m.map[backY][backX] == 1
    {
        print(clean)
        exit(0)
    }
    else
    {
        DFS(backX, backY, front, &clean, m, &visited)
    }
}
func BOJ_14503()
{
    let m     = mapInfo()
    var clean = 1
    var visited = Array(repeating: Array(repeating: false, count: m.width), count: m.height)
    visited[m.start.y][m.start.x] = true
    DFS(m.start.x, m.start.y, m.start.direct, &clean, m, &visited)
}
BOJ_14503()
