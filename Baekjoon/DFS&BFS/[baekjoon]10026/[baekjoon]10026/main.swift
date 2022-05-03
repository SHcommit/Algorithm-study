// https://www.acmicpc.net/problem/10026

import Foundation

var n = Int(readLine()!)!
var direction = [(-1,0),(1,0),(0,1),(0,-1)]
var image = Array(repeating: [String](), count: n)

var resImage = 0
var resRGImage = 0
//image는 일반사람, RGImage는 적록색약
//방문했으면 V로!!

for y in 0..<n{
    image[y] = readLine()!.map{String($0)}
}
var RGImage = image

for y in 0..<n{
    for x in 0..<n{
        if image[y][x] != "V"{
            dfs(currentX: x, currentY: y)
            resImage += 1
        }
        if RGImage[y][x] != "V"{
            _RG_dfs(currentX: x, currentY: y)
            resRGImage += 1
        }
    }
}
print("\(resImage) \(resRGImage)")

func dfs(currentX x : Int, currentY y : Int){
    var stack = [(Int,Int)]()
    let char = image[y][x]
    stack.append((x,y))
    while(stack.count != 0){
        let coord = stack.popLast()!
        for (dx,dy) in direction{
            let nx = dx + coord.0
            let ny = dy + coord.1
            if nx < 0 || nx > n - 1 || ny < 0 || ny > n - 1 {
                continue
            }
            if image[ny][nx] == char {
                stack.append((nx,ny))
                image[ny][nx] = "V"
            }
        }

    }
}

func _RG_dfs(currentX x: Int, currentY y : Int){
    var stack = [(Int,Int)]()
    let char = RGImage[y][x]
    var rgWeakness = false
    if char == "R" || char == "G" {
        rgWeakness = true
    }
    stack.append((x,y))
    while(stack.count != 0){
        let coord = stack.popLast()!
        for (dx,dy) in direction{
            let nx = dx + coord.0
            let ny = dy + coord.1
            
            if nx < 0 || nx > n - 1 || ny < 0 || ny > n - 1 {
                continue
            }
            if rgWeakness == true{
                if RGImage[ny][nx] == "R" || RGImage[ny][nx] == "G"{
                    stack.append((nx,ny))
                    RGImage[ny][nx] = "V"
                }
            }else if RGImage[ny][nx] == char {
                stack.append((nx,ny))
                RGImage[ny][nx] = "V"
            }
        }

    }
}


