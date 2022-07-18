import Foundation

/*
    bfs 탐색할 때 요소
    x : 탐색 할 x 좌표
    y : 탐색 할 y 좌표
    front : 탐색할 로봇의 x,y좌표에서 로봇이 바라보고 있는 방향
    count : 누적 명령 횟수
 */
typealias Element = (x: Int, y : Int, front : Int, count : Int)
/*
 원래 주어진 입력에서의 로봇 방향은
  동 : 1, 서 : 2, 남 : 3, 북 : 4
 인데 좀 편하게 다룰려고
  동 : 1, 남 : 2, 서 : 3, 북 : 4로 바꾼 direction을 선언했습니다.
 
 따라서 추후 입력시 받게될 시작칸, 끝칸의 방향을 원본(1~4)에서 전체 1씩 뺀(0~3) 후에,
 서쪽와 남쪽 숫자를 바꿔줍니다.
 */
let direction     : [(x:Int,y:Int)] = [(1,0),(0,1),(-1,0),(0,-1)]

//맵 정보입니다. 길이, 맵 정보 있습니다
class mapInfo
{
    let width  : Int
    let height : Int
    var map    : [[Int]]
    init()
    {
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        width     = input[1]
        height    = input[0]
        map       = Array(repeating: [Int](), count:height)
        for y in 0..<height
        {
            map[y] = readLine()!.split(separator:" ").map{Int(String($0))!}
        }
    }
}

/**
 주어진 문제의 명령 조건 1,2에 따라 맵 안에서 로봇을 시작 지점 부터 도착 지점 까지 탐색 시킵니다!
 
 - parameter m: 맵의 정보.
 - parameter start: 시작 좌표.
 - parameter end: 끝 좌표.
 
 - param queue: 큐! 타입은 Element로 탐색 좌표, 그때 바라보는 방향, 누적 명령 횟수.
 - param index: 큐를 훑기 위한 index.
 - param visit: 특정 좌표에서 로봇의 front에 대한 방문 체크.
 
 # Notes: #
 1. while문 안에서의 for in구문은 로봇의 앞 전진 k == 1~3일때를 파악하는데 만약 맵을 벗어나거나 벽일 경우 그냥 break시켰습니다.
 2. 이제 queue의 특정 탐색 좌표와 로봇이 바라보는 방향에 대해서 좌 우 회전 상태를 queue에 저장시킵니다.
 
 주어진 문제는 무조건 시작지점에서 도착지점으로 도착합니다!
 */
func BFS(_ m : mapInfo, _ start : (x:Int,y:Int,front:Int), _ end : (x:Int,y:Int,front:Int))
{
    var queue = [Element]()
    var index = 0
    var visit = Array(repeating: Array(repeating: Array(repeating: false, count: m.width) , count: m.height) , count: 5)
    
    queue.append((start.x,start.y,start.front,0))
    visit[start.front][start.y][start.x] = true
    while queue.count != index
    {
        let (curX,curY,curFront,curCnt) = queue[index]
        if end.x == curX && end.y == curY && end.front == curFront
        {
            print(curCnt)
            return
        }
        index += 1
        var nx = curX ,ny = curY
        for _ in 0..<3
        {
            nx += direction[curFront].x
            ny += direction[curFront].y
            if nx < 0 || nx > m.width - 1 || ny < 0 || ny > m.height - 1 || m.map[ny][nx] == 1
            {
                break
            }
            if m.map[ny][nx] == 0 && !visit[curFront][ny][nx]
            {
                queue.append((nx,ny,curFront,curCnt + 1))
                visit[curFront][ny][nx] = true
            }
        }
        if !visit[(curFront+1)%4][curY][curX]
        {
            queue.append((curX,curY,(curFront+1)%4,curCnt + 1))
            visit[curFront][curY][curX] = true
        }
        var tempFront = (curFront - 1)%4 == -1 ?  3 : (curFront - 1)%4
        if !visit[tempFront][curY][curX]
        {
            queue.append((curX,curY,tempFront,curCnt+1))
            visit[tempFront][curY][curX] = true
        }
    }
}

/*
 여기서 주의 할 점은 시작, 끝 좌표와 방향을 나에게 유리하게 바꿔주기!
 */
func BOJ_1726()
{
    let m  = mapInfo()
    var tempFront = 0
    let start : (Int,Int,Int) =
    {
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        tempFront = input[2] - 1
        //서쪽이면 남으로 남쪽이면 서쪽으로 바꿈. 이래야 +90, - 90 하기 편함
        if input[2] - 1 == 2
        {
            tempFront = 1
        }
        else if input[2] - 1 == 1
        {
            tempFront = 2
        }
        return (input[1]-1,input[0]-1,tempFront)
    }()
    
    let end : (Int,Int,Int)   =
    {
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        tempFront = input[2] - 1
        //서쪽이면 남으로 남쪽이면 서쪽으로 바꿈. 이래야 +90, - 90 하기 편함
        if input[2] - 1 == 2
        {
            tempFront = 1
        }
        else if input[2] - 1 == 1
        {
            tempFront = 2
        }
        return (input[1]-1,input[0]-1,tempFront)
    }()
    BFS(m, start, end)
}
BOJ_1726()
