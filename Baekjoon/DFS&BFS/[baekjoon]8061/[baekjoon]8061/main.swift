//  [baekjoon]8061
//  Created by 양승현 on 2022/04/21.

import Foundation

var input = readLine()!.split(separator: " ").map{Int($0)!}
var map = Array(repeating: [Int](), count: input[0])
var res = ""

for y in 0..<input[0]{
    map[y] = readLine()!.map{Int(String($0))!}
}
var direction = [(-1,0),(1,0),(0,1),(0,-1)]

BFS()

for y in 0..<input[0]{
    for x in 0..<input[1]{
        map[y][x] -= 1
        res += "\(map[y][x]) "
    }
    res += "\n"
}
print(res)

private func BFS(){
    var index = 0;
    var queue = [(Int,Int)]()
    
    for y in 0..<input[0]{
        for x in 0..<input[1]{
            if map[y][x] == 1 {
                queue.append((x,y))
            }
            
        }
    }
    
    while(queue.count != index){
        let (x,y) = queue[index]
        
        for (nx,ny) in direction{
            let dx = nx + x
            let dy = ny + y
            if dx < 0 ||  dx > input[1] - 1 || dy < 0 || dy > input[0] - 1 {
                continue
            }
            if map[dy][dx] == 0 {
                map[dy][dx] = map[y][x] + 1
                queue.append((dx,dy))
            }
        }
        index += 1
    }
}
