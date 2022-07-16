import Foundation
//탐색하기 위한 방향
let direction     = [(0,-1),(1,0),(-1,0),(0,1)]

/*
  Info :맵의 정보가 담겨있는 클래스
 
    - Param height : 세로
    - Param width  : 가로
    - Param k      : 벽을 부술 수 있는 횟수
    - Param map    : 0(길)과 1(벽)이 담긴 맵
 */
class mapInfo
{
    let height : Int
    let width  : Int
    let k      : Int
    var map    : [[Int]]
    init()
    {
        let hwk = readLine()!.split(separator: " ").map{Int(String($0))!}
        height  = hwk[0]
        width   = hwk[1]
        k       = hwk[2]
        map     = Array(repeating:[Int](),count:height)
        for y in 0..<height
        {
            map[y] = readLine()!.map{Int(String($0))!}
        }
    }
}

/*
 Info : (0,0)에서 (N,M)까지 최단 경로로 이동 할 때 벽을 부수면서 이동 시 최단 경로가 존재한다면
        최대 k개까지 벽을 부수면서 이동 할 수 있다.
 
    - Param queue   : [(x : Int, y : Int, curWallBreak : Int, state : Int)]
        x,y = 방문 좌표, 그때 벽 부순 누적횟수 curWallBreak, 이 때의 최단 거리 state
    - Param index   : 큐를 훑기 위한 인덱스
    - Param visited : [curWallBreak카운트][y좌표][x좌표]
        3차원 배열로 선언. 벽을 부술 시 curWallBreak + 1 을 하면서 맵 방문 표시를 함(중복 탐색 방지)
 */
func BFS(_ info : mapInfo) -> Int
{
    var queue   = [(0,0,0,1)]
    var index   = 0
    var visited = Array(repeating: Array(repeating: Array(repeating: false, count: info.width), count: info.height), count: info.k + 1)
    visited[0][0][0] = true
    
    /*
      1 1 1
      0
      인 경우 답 = 1
     */
    if 0 == info.width - 1 && 0 == info.height - 1
    {
        return 1
    }
    while queue.count != index
    {
        //탐색할 좌표 등등 받아옴
        let (curX,curY,curBreak, state) = queue[index]
        index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX+dx,curY+dy)
            if nx < 0 || nx > info.width - 1 || ny < 0 || ny > info.height - 1 || visited[curBreak][ny][nx]
            {
                continue
            }
            //만약 길이라면?
            if info.map[ny][nx] == 0 && !visited[curBreak][ny][nx]
            {
                //답인가?!
                if nx == info.width - 1 && ny == info.height - 1
                {
                    return state + 1
                }
                //방문처리!!
                visited[curBreak][ny][nx] = true
                queue.append((nx,ny,curBreak,state + 1))
            }
            // 벽이라면? + visited[curBreak + 1]일때도 중복해서 방문하지 않았다면?
            else if info.map[ny][nx] == 1 && info.k  > curBreak && !visited[curBreak+1][ny][nx]
            {
                visited[curBreak + 1][ny][nx] = true
                queue.append((nx,ny,curBreak + 1, state + 1))
            }
        }
    }
    return -1
}
func BOJ_14442(){
    let m = mapInfo()
    print(BFS(m))
}
BOJ_14442()
