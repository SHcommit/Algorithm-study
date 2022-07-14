import Foundation
typealias Element = (x: Int, y : Int)
let direction     = [(-1,0),(1,0),(0,1),(0,-1)]
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
            }
            else if map[ny][nx] == 0 && fixed[ny][nx] > fixed[curY][curX]
            {
                fixed[ny][nx] = fixed[curY][curX] + 1
            }
            queue.append((nx,ny))
        }
    }
    print(fixed[n-1][n-1])
}
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
