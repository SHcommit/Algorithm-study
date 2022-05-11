import Foundation

class coord{
    var x : Int
    var y : Int
    init(x: Int, y: Int){
        self.x = x
        self.y = y
    }
}
func edgeCheck(nx : Int,ny: Int , n : Int) -> Bool{
    if nx < 0 || nx > n - 1 || ny < 0 || ny > n - 1 {
        return true
    }
    return false
}
func bfs(n : Int, start : coord, end : coord, direction : [(Int,Int)]) {
    var visit = Array(repeating: Array(repeating: false, count: n), count: n)
    var chess = Array(repeating: Array(repeating: 0, count: n), count: n)
    var queue = [(start.x,start.y)]
    var index = 0
    var ans   = -1
    visit[start.y][start.x] = true
    
    while(queue.count != index){
        let (curX,curY) = queue[index]
        if (curX == end.x) && (curY == end.y){
            ans = chess[curY][curX]
            break
        }
        for (dx,dy) in direction{
            let (nx,ny) = (curX + dx, curY + dy)
            if edgeCheck(nx: nx, ny: ny, n: n)  { continue }
            if visit[ny][nx] == false {
                visit[ny][nx] = true
                chess[ny][nx] = chess[curY][curX] + 1
                queue.append((nx,ny))
            }
        }
        index += 1
    }
    print(ans)
}
func BOJ_16948(){
    let direction = [(-2,-1),(-2,1),(0,-2),(0,2),(2,-1),(2,1)]
    let n         = Int(readLine()!)!
    let input     = readLine()!.split(separator: " ").map{Int(String($0))!}
    let start     = coord(x: input[0], y: input[1])
    let end       = coord(x: input[2], y: input[3])
    
    bfs(n: n, start: start, end: end, direction: direction)
}

BOJ_16948()
