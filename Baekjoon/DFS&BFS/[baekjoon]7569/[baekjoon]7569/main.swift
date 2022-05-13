import Foundation

func edgeCheck(nx : Int,ny : Int ,nz :Int,width : Int, height : Int, n : Int) -> Bool{
    if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1 || nz < 0 || nz > n - 1 {
        return true
    }
    return false
}

func bfs(width : Int, height: Int, boxCount zCount : Int,box : inout [[[Int]]], visit : inout [[[Bool]]], queue : inout [(Int,Int,Int)]){
    let dictionary = [(-1,0,0),(1,0,0),(0,1,0),(0,-1,0),(0,0,1),(0,0,-1)]
    var index      = 0
    
    while queue.count != index {
        let (curX,curY,curZ) = queue[index]
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
//익은 토마토 큐에 추가
func ripedTomato(boxCount : Int, height : Int, width : Int, visit : [[[Bool]]], box : [[[Int]]], queue : inout [(Int,Int,Int)]){
    for z in 0..<boxCount{
        for y in 0..<height{
            for x in 0..<width{
                if visit[z][y][x] == false && box[z][y][x] == 1{
                    queue.append((x,y,z))
                }
            }
        }
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
    //익은 토마토들을 큐에 집어넣음
    ripedTomato(boxCount: n, height: height, width: width, visit: visit, box: box, queue: &queue)
    
    bfs(width: width, height: height, boxCount: n, box: &box, visit: &visit, queue: &queue)
    //결과 출력
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

BOJ_7569()
