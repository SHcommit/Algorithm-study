import Foundation

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
 0111
 0000
 출력
 15
 */

//이거 1 받으면 -1로 바꾸자
var NM        = readLine()!.split(separator: " ").map{Int(String($0))!}
var height    = NM[0]
var width     = NM[1]
var street       = Array(repeating: [Int](), count: height)
var visit     = Array(repeating: Array(repeating: false, count: width), count: height)
var wallBreak = 1
var moveCnt   = -1 // ( 0 , 0 )부터 시작하니까
var direction = [(-1,0),(1,0),(0,1),(0,-1)]
var finish = false
for y in 0..<height{
    street[y] = readLine()!.map{return Int(String($0))! == 1 ? -1 : 0}
}

//여기서 벽을 부술수있는 횟수가있다면,,
/*
 bool prevWallBreak 이거 == false에서 true만들고
 0   1 있다면 dfs는 좌, 아래 탐색한다고하면 우선 좌가 1일때 임시 wallBreak를 써서 0 만들고
       dfs호출, 이때 그 다음 wallBreak == 0 && prevWallBreak == true 일때 direct 탐색에 map[ny][nx] == 0이 있다면
 1     prevWallCheck = false처리하고 계속탐색근데안되,, 그러면
       이제
 //마지막에 도착하면 finish == true하고 finish true면 그냥 다 return
 //아 이거 bfs로해야하네,,
 0 0 0
 0 0 0 0
 여기서..
 */


func bfs(paramX x: Int, paramY y : Int, map : inout [[Int]], visited v : inout [[Bool]]){
    var queue = [(x,y)]
    var index = 0
    if finish {
        return
    }
    while(queue.count != index)
    {
        if finish {
            break
        }
        let (curX,curY) = queue[index]
        index += 1
        for (dx,dy) in direction
        {
            let nx = dx + curX
            let ny = dy + curY
            if borderCheck(x: nx, y: ny){
                continue
            }
            if wallBreak == 1
            {
                if v[ny][nx] == false && map[ny][nx] == -1
                {
                    wallBreak -= 1
                    v[ny][nx] = true
                    map[ny][nx] = map[curY][curX] + 1
                    queue.append((nx,ny))
                }else
                {
                    // 벽 wallBreak == 1이지만 길일 경우 탐색!
                    if v[ny][nx] == false && map[ny][nx] != -1{
                    v[ny][nx] = true
                    map[ny][nx] = map[curY][curX] + 1
                        queue.append((nx,ny))
                    }
                }
            }else
            {
                //여기선 -1이면 무저건 종료되는거임!!
                //만약 벽 부수는 거 다썻다면!!!
                //이 때 부순 벽이 이전 벽이라면? prevWallBreak == true
                //근데 이전벽 안따져도되는게, 이미 임시 맵만들고 거기서 0 만들어버림,, 그럼 prevWallBreak 필요없을듯,,
                if v[ny][nx] == false && map[ny][nx] == 0
                {
                    if (ny == height - 1) && ( nx == width - 1 ){
                        finish = true
                        map[ny][nx] = map[curY][curX] + 1
                        moveCnt = map[ny][nx]
                        break;
                    }
                    v[ny][nx] = true
                    map[ny][nx] = map[curY][curX] + 1
                    queue.append((nx,ny))
                }
            }
            
        }
        
    }
}

func borderCheck(x: Int,y: Int) -> Bool{
    if x < 0 || x > width - 1 || y < 0 || y > height - 1 {
        return true
    }
    return false
}
street[0][0] = 1
bfs(paramX: 0, paramY: 0, map: &street, visited: &visit)
print(moveCnt)
