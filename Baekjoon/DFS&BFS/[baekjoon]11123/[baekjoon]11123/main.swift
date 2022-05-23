import Foundation

func bfs(x : Int, y : Int, visit : inout [[Bool]],map : inout [[String]], width : Int, height: Int){
    var dictionary = [(-1,0),(1,0),(0,1),(0,-1)]
    var queue = [(x,y)]
    var index = 0;
    while queue.count != index {
        
        let (curX,curY) = queue[index]
        
        for (dx,dy) in dictionary{
            let nx = dx + curX
            let ny = dy + curY
            if (ny < 0 || ny > height - 1 || nx < 0 || nx > width - 1){continue}
            if visit[ny][nx] == false && map[ny][nx] == "#"{
                visit[ny][nx] = true
                queue.append((nx,ny))
            }
        }
        index += 1
    }
}

func BOJ_11123(){
    var n = Int(readLine()!)!
    
    for i in 0..<n{
        
        var count = 0
        let hw = readLine()!.split(separator: " ").map{Int(String($0))!}
        let height = hw[0]
        let width  = hw[1]
        var map = Array(repeating: [String](), count: height)
        
        for i in 0..<height{
            map[i] = readLine()!.map{String($0)}
        }
        var visit = Array(repeating: Array(repeating: false, count: width), count: height)
        
        for y in 0..<height{
            for x in 0..<width{
                if visit[y][x] == false && map[y][x] == "#"{
                    visit[y][x] = true
                    bfs(x: x, y: y, visit : &visit, map: &map, width: width, height: height)
                    count += 1
                }
            }
        }
        print(count)
    }
}


BOJ_11123()
