import Foundation
/**
 * 토마토 보관중  M x N(가 x 세) x h
 * 이번엔 높이까지 추가됨
 *
 * 창고에는 잘 익은것 익지않은 것 두 가지 종류가 존재
 * 하루가 지나면 익은. 토마토를 기준으로 익지 않은 토마토들이 익게됨
 * 이때 상 하 좌 우 + 위 아래까지
 *      이때 대각선으로 익는 토마토는 없고 혼자 익는 토마토도 없음
 *
 * 창고에 보관된 토마토들이 며칠 지났을 경우 다 익는지 알고시퍼
 * 근데 상자에는 일부 토마토가 안들어있을수도있어
 *-----------------------*-----------------------*-----------------------*-----------------------
 *입력
 *MN 과 h ( 2 ≤ M ≤ 100, 2 ≤ N ≤ 100, 1 ≤ H ≤ 100 )
 *두번째줄부터 **가장 밑의 상자**부터 가장 위의 상자까지 저장된 토마토들의 정보 주어짐
 *
 *1은 익은 토마토. 0은 익지 않은 토마토. -1은 토마토 안들어있음
 */
func edgeCheck(nx : Int,ny : Int ,nz :Int,width : Int, height : Int, n : Int) -> Bool{
    if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1 || nz < 0 || nz > n - 1 {
        return true
    }
    return false
}

func bfs(width : Int, height: Int, boxCount zCount : Int,box box : inout [[[Int]]], visit : inout [[[Bool]]], queue : inout [(Int,Int,Int)]){
    let dictionary = [(-1,0,0),(1,0,0),(0,1,0),(0,-1,0),(0,0,1),(0,0,-1)]
    var index      = 0
    
    while queue.count != index {
        let (curX,curY,curZ) = queue[index]
//test(map: box, w: width, h: height, c: zCount)
        for (dx,dy,dz) in dictionary{
            let (nx,ny,nz) = (curX + dx, curY + dy, curZ + dz)
            if edgeCheck(nx: nx, ny: ny, nz: nz, width: width, height: height, n: zCount){
                continue
            }
            if visit[nz][ny][nx] == false && box[nz][ny][nx] == 0{
                visit[nz][ny][nx] = true
                box[nz][ny][nx] = box[curZ][curY][curX] + 1
                queue.append((nx,ny,nz))
            }
        }
        index += 1
    }
}
func BOJ_7569(){
    let WHN    = readLine()!.split(separator: " ").map{Int(String($0))!}
    let width  = WHN[0]
    let height = WHN[1]
    let n      = WHN[2]
    var result = 0
    var box    = Array(repeating: Array(repeating: [Int](), count: height), count: n)
    var visit  = Array(repeating: Array(repeating: Array(repeating: false, count: width), count: height), count: n)
    var queue  = [(Int,Int,Int)]()
    
    for z in 0..<n{
        for y in 0..<height{
            box[z][y] = readLine()!.split(separator: " ").map{Int(String($0))!}
        }
    }
//test(map: box, w: width, h: height, c: n)
    //익은 토마토들을 큐에 집어넣음
    for z in 0..<n{
        for y in 0..<height{
            for x in 0..<width{
                if visit[z][y][x] == false && box[z][y][x] == 1{
                    queue.append((x,y,z))
                }
            }
        }
    }
    
    bfs(width: width, height: height, boxCount: n, box: &box, visit: &visit, queue: &queue)
    
    for z in 0..<n{
        for y in 0..<height{
            for x in 0..<width{
                if box[z][y][x] == 0 {
                    print(-1)
                    return
                }
                if box[z][y][x] > result{
                    result = box[z][y][x]
                }
            }
        }
    }
    print(result == 0 ? 1 : result - 1)
    
}
/*
func test(map : [[[Int]]],w : Int,h : Int, c : Int){
    print()
    for z in 0..<c{
        for y in 0..<h{
            var res = ""
            for x in 0..<w{
                res += "\(map[z][y][x]) "
            }
            print(res)
        }
        print()
    }
    print()
    print()
}*/

BOJ_7569()
