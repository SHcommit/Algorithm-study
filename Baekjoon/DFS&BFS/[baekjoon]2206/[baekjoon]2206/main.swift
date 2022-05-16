/**
 * N*M 의 행렬
 * 0 길
 * 1 벽!
 * ( 1 , 1 ) 에서 ( N , M ) 으로 이동
 * 이때 최단 경로로 이동
 * (시작하는 칸, 끝나는 칸도 count)
 * 한 칸에서 이동할 수 있는 경로 == 상하좌우!!
 * 최단 경로가 되기위해 길을 1개 뿌셔도 가능!!
 *      @param wallBreak
 * N M == N은 세로 M은 가로
 *
 예제 입력
6 4
0100
1110
1000
0000
1101
0000
 출력
 15

 */
/*
4 4
0111
0001
0110
0001
 */
import Foundation

func bfs(_ width: Int, _ height : Int,map : inout [[Int]], visit : inout [[[Bool]]]) -> Int{
    let direction  = [(-1,0),(1,0),(0,-1),(0,1)]
    var queue      : [((Int,Int,Int),Int)] = [((0,0,1),0)]
    visit[0][0][0] = true
    var wallBreak  = 0
    var index      = 0
    //wallbreak를 변수로 선언했는데, 그렇게되면 bfs가 재귀적으로 사용될 때 wallBreak는 최초 한번밖에 사용이안됨,,
    while (queue.count != index){
        let ((curX,curY,result),wallBreak) = queue[index]
        
        if (curX == width - 1) && (curY == height - 1) {
            return result
        }
        for (dx,dy) in direction{
            let (nx,ny) = (dx+curX,dy+curY)
            if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1 { continue }
            if visit[ny][nx][wallBreak] == false{
                if map[ny][nx] == 0{
                    visit[ny][nx][wallBreak] = true
                    queue.append(((nx,ny,result + 1),wallBreak))
                }
                else if map[ny][nx] == 1 && wallBreak == 0{
                    visit[ny][nx][wallBreak + 1] = true
                    queue.append(((nx,ny,result + 1),wallBreak + 1))
                }
            }
        }
        index += 1
    }
    return -1
}
func BOJ_2206(){
    let nm     = readLine()!.split(separator: " ").map{Int(String($0))!}
    let width  = nm[1]
    let height = nm[0]
    var map    = Array(repeating: [Int](), count: height)
    var visit  = Array(repeating: Array(repeating: Array(repeating: false, count: 2), count: width), count: height)
    for y in 0..<height{
        map[y] = readLine()!.map{Int(String($0))!}
    }
    print(bfs(width, height, map: &map, visit: &visit))
    
}

BOJ_2206()


