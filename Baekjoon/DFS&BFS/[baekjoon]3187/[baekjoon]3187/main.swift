//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-3187-%EC%96%91%EC%B9%98%EA%B8%B0-%EA%BF%8D-%EB%AC%B8%EC%A0%9C-%ED%92%80%EC%9D%B4
import Foundation
typealias Element = (x: Int, y : Int)
let direction     = [(-1,0),(1,0),(0,1),(0,-1)]
/*
  울타리 정보
 */
class rect
{
    let width  : Int
    let height : Int
    
    init()
    {
        let hw = readLine()!.split(separator: " ").map{Int(String($0))!}
        width  = hw[1]
        height = hw[0]
    }
}
/*
  특정 양, 늑대가 있는 좌표가 point 매개변수로 전달 됨
  이 좌표를 기준으로
    특정 범위 안에서 양이 더 많은지 =>  tempSheep에 저장
                 늑대가 더 많은지 => tempWolf에 저장
  후 bfs탐색을 종료 할 경우 문제의 조건에 따라 양이 잡아먹는지 아님 늑대가 잡아먹는지 결정됨 그 값은 매개변수 sheep or wolf에 저장
 */
func BFS(_ point : Element, _ r : rect ,_ wolf : inout Int, _ sheep : inout Int, _ visited : inout [[Bool]], _ map : [[String]])
{
    var queue     = [point]
    var index     = 0
    var tempWolf  = 0
    var tempSheep = 0
    visited[point.y][point.x] = true
    
    if map[point.y][point.x] == "v"
    {
        tempWolf += 1
    }
    else
    {
        tempSheep += 1
    }
    while queue.count != index
    {
        let (curX,curY) = queue[index]
        index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX+dx, curY+dy)
            if nx < 0 || nx > r.width - 1 || ny < 0 || ny > r.height - 1
            {
                continue
            }
            if !visited[ny][nx] && map[ny][nx] != "#"
            {
                visited[ny][nx] = true
                queue.append((nx,ny))
                if map[ny][nx] == "v"
                {
                    tempWolf += 1
                    continue
                }
                if map[ny][nx] == "k"
                {
                    tempSheep += 1
                    continue
                }
            }
        }
    }
    if tempSheep > tempWolf
    {
        sheep += tempSheep
    }
    else
    {
        wolf += tempWolf
    }
        
}

/*
 
    - Parma r       : 울타리 가로세로 정보
    - Parma map     : 울타리 안 정보
    - Parma sheep   : 살아남은 양의 누적 개수
    - Parma wolf    : 살아남은 늑대의 누적 개수
    - Parma list    : 양과 늑대의 좌표가 담긴 list 타입 == Element
    - Parma index   : 위에서 list배열을 탐색하기 위한 index
    - Parma visited : 중복 탐색을 방지하귀 위한 방문 체크
 */
func BOJ_3187()
{
    let r       = rect()
    var map     = Array(repeating: [String](),count: r.height)
    var sheep   = 0
    var wolf    = 0
    var list    = [Element]()
    var index   = 0
    var visited = Array(repeating: Array(repeating: false, count: r.width), count: r.height)
    //초기에 늑대, 양 좌표를 list에 저장
    for y in 0..<r.height
    {
        map[y] = readLine()!.map{String($0)}
        for x in 0..<r.width
        {
            if map[y][x] == "v" || map[y][x] ==  "k"
            {
                list.append((x,y))
            }
        }
    }
    // 양, 늑대 좌표가 담긴list탐색을 전부 실행 이때 visited를 통해 중복된 탐색을 안함
    while list.count != index
    {
        let curPoint = list[index]
        index += 1
        if !visited[curPoint.y][curPoint.x]
        {
            BFS(curPoint, r, &wolf, &sheep, &visited, map)
        }

    }
    print("\(sheep) \(wolf)")
}
BOJ_3187()
