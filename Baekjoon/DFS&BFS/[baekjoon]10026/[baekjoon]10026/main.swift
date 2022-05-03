// https://www.acmicpc.net/problem/10026

import Foundation

var n = Int(readLine()!)!
var direction = [(-1,0),(1,0),(0,1),(0,-1)]
var image = Array(repeating: [String](), count: n)
/**
 * imgae는 일반인의 시각에서 그룹의 방문을 탐색할 때 사용.
 * RGImage는 적록색약
 * 방문했을 경우 특정 좌표의 명암도가 "R,G,B" - > "V"
 */
var RGImage = image
var rImg = 0
var rRGImg = 0
/**
 * String의 특정 char를 다른 특정 char로 변환하는 함수
 * replacingOccurrences(of:with:)
 * 이때 이 함수를 사용한 문자열은 그대로고, of:with: 조건이 반영된 문자열은 반환이 된다!
 */
for y in 0..<n{
    var colors = readLine()!
    image[y] = colors.map{String($0)}
    colors = colors.replacingOccurrences(of: "G", with: "R")
    RGImage[y] = colors.map{String($0)}
}
/**
 * 이미지에서 모든 구간에 대해 탐색!
 * 이때 dfs를 통해 방문했을 경우 "V"로 바꾸어 방문 완료 표시!
 */
for y in 0..<n{
    for x in 0..<n{
        if image[y][x] != "V"{
            dfs(currentX: x, currentY: y, image: &image)
            rImg += 1
        }
        if RGImage[y][x] != "V"{
            dfs(currentX: x, currentY : y, image: &RGImage)
            rRGImg += 1
        }
    }
}
print("\(rImg) \(rRGImg)")

/**
 * 맨 처음 방문하지 않은 (x,y) 좌표의 문자를 char에 저장하고,
 * char를 기준으로 탐색해야 할 이미지의 색이 char이라면 stack에 저장! -> 탐색의 반복!!
 */
func dfs(currentX x : Int, currentY y : Int, image : inout[[String]]){
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
