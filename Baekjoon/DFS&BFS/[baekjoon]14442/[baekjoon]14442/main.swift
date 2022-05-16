import Foundation

func BOJ_14442(){
    let hwk    = readLine()!.split(separator: " ").map{Int(String($0))!}
    let height = hwk[0]
    let width  = hwk[1]
    let k      = hwk[2]
    
    var visit  = Array(repeating: Array(repeating: Array(repeating: false, count: k + 1), count: width), count: height)
    var map    = Array(repeating: [Int](), count: height)
    
    for y in 0..<height{
        map[y] = readLine()!.map{Int(String($0))!}
    }
    var queue : [((Int,Int,Int),Int)] = [((0,0,1),0)]
    let direction  = [(-1,0),(1,0),(0,1),(0,-1)]
    visit[0][0][0] = true
    var index      = 0
    while queue.count != index {
        let ((curX,curY,result),wallBreak) = queue[index]
        if (curX == width - 1) && (curY == height - 1) {
            print(result)
            return
        }
        for (dx,dy) in direction{
            let (nx,ny) = (dx + curX, dy + curY)
            if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1 { continue }
            if visit[ny][nx][wallBreak] == false{
                if map[ny][nx] == 0 {
                    visit[ny][nx][wallBreak] = true
                    queue.append(((nx,ny,result + 1),wallBreak))
                }else if map[ny][nx] == 1 && wallBreak != k{
                    visit[ny][nx][wallBreak + 1] = true
                    queue.append(((nx,ny,result + 1),wallBreak + 1))
                }
            }
        }
        index += 1
    }
    print(-1)
    return
}

BOJ_14442()
