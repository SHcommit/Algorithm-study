import Foundation

typealias Element = (x : Int,y : Int, num : Int)
let direction     = [(-1,0),(1,0),(0,1),(0,-1)]
let input = readLine()!.split(separator: " ").map{Int(String($0))!}
let height  = input[0]
let width   = input[1]
let Aascii  = UnicodeScalar("A").value
var count   = 1
var map     = Array(repeating: [Int](), count: height)
for i in 0..<height
{
    map[i] = readLine()!.map{Int(UnicodeScalar(String($0))!.value - Aascii)}
}
var visited = Array(repeating: false, count: 26)
visited[map[0][0]] = true
dfs((0,0,count))
print(count)

func dfs(_ element : Element)
{
    count = max(count , element.num)
    for (dx,dy) in direction
    {
        let (nx,ny,curCount) = (element.x + dx, element.y + dy, element.num)
        if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1
        { continue }
        let char = map[ny][nx]
        if !visited[char]
        {
            visited[char] = true
            count = max(count, curCount + 1)
            dfs((nx,ny,curCount + 1))
            visited[char] = false
        }
    }
}

