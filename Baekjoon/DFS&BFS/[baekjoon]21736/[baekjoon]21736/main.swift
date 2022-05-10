import Foundation

var HW = readLine()!.split(separator: " ").map{Int(String($0))!}
var height = HW[0]
var width = HW[1]
var direction = [(-1,0),(1,0),(0,-1),(0,1)]
var peopleCount = 0
var visit = Array(repeating: Array(repeating: false, count: width), count: height)
var map = Array(repeating: [String](), count: height)

for y in 0..<height{
    map[y] = readLine()!.map{String($0)}
}

func bfs(paramX x : Int,paramY y: Int, map : [[String]]){
    var queue = [(x,y)]
    visit[y][x] = true
    var index = 0
    while(queue.count != index){
        let (curX, curY) = queue[index]
        index += 1
        for (dx, dy ) in direction{
            let nx = dx + curX
            let ny = dy + curY
            if isOutEdge(paramX: nx, paramY: ny){
                continue
            }
            if map[ny][nx] == "P" && visit[ny][nx] == false{
                visit[ny][nx] = true
                peopleCount += 1
                queue.append((nx,ny))
            }
            if map[ny][nx] == "O" && visit[ny][nx] == false{
                visit[ny][nx] = true
                queue.append((nx,ny))
            }
        }
    }
}
func isOutEdge(paramX x : Int, paramY y : Int) -> Bool{
    if x < 0 || x > width - 1 || y < 0 || y > height - 1 {
        return true
    }
    return false
}

func solution(){
    for y in 0..<height{
        for x in 0..<width{
            if map[y][x] == "I"{
                bfs(paramX: x, paramY: y, map: map)
                if peopleCount == 0 {
                    print("TT")
                }else{
                    print(peopleCount)
                }
                break
            }
        }
    }
}

solution()
