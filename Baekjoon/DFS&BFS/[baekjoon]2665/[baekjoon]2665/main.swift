//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-2665-%EB%AF%B8%EB%A1%9C-%EB%A7%8C%EB%93%A4%EA%B8%B0-%EB%AC%B8%EC%A0%9C-%ED%92%80%EC%9D%B4%EC%99%80-%EB%B0%98%EB%A1%80

import Foundation
typealias Element = (x: Int, y : Int)
let direction     = [(-1,0),(1,0),(0,1),(0,-1)]
/*
    - Param queue : 방 탐색할 좌표
    - Param index : 큐 훑을 index
    - Param fixed : 맵을 탐색할 때 이전에 (검->흰)으로 바꾼 개수가 적은 값으로 값을 갱신해 나갔다.
    
 */
func BFS(_ n : Int, _ map : inout [[Int]])
{
    var queue = [Element]()
    var index = 0
    var fixed = Array(repeating:Array(repeating:9999, count:n),count:n)
    fixed[0][0] = 0
    queue.append((0,0))
    while queue.count != index
    {
        let (curX,curY) = queue[index]
        index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX+dx,curY+dy)
            if nx<0 || nx>n-1 || ny<0 || ny>n-1
            {
                continue
            }
           
            if map[ny][nx] == 1 && fixed[ny][nx] > fixed[curY][curX]
            {
                fixed[ny][nx] = fixed[curY][curX]
                queue.append((nx,ny))
            }
            else if map[ny][nx] == 0 && fixed[ny][nx] > fixed[curY][curX]
            {
                fixed[ny][nx] = fixed[curY][curX] + 1
                queue.append((nx,ny))
            }
        }
    }
    print(fixed[n-1][n-1])
}

/*
    - Param n   : 맵 크기
    - Param map : (흰,검은 방)맵 정보
 */
func BOJ_2665()
{
    let n   = Int(readLine()!)!
    var map = Array(repeating: [Int](),count : n)
    for i in 0..<n
    {
        map[i] = readLine()!.map{Int(String($0))!}
    }
    BFS(n, &map)
}
BOJ_2665()



