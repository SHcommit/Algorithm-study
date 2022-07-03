import Foundation
typealias Element = (Int,Int,Int)
let direction = [(-1,0),(1,0),(0,1),(0,-1)]

func dfs(_ element : Element, _ width : Int ,_ height : Int,_ count : inout Int, _ visited : inout [String], _ map : [[String]])
{
    count = max(count , element.2)
    for (dx,dy) in direction
    {
        let (nx,ny,curCount) = (element.0 + dx, element.1 + dy, element.2)
        if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1
        { continue }
        var visit = false
        for str in visited
        {
            if str == map[ny][nx]
            {
                visit = true
                break
            }
        }
        if !visit
        {
            visited.append(map[ny][nx])
            dfs((nx,ny,curCount + 1), width, height, &count, &visited, map)
            visited.removeLast()
        }
    }
}
func BOJ_1987()
{
    let input   = readLine()!.split(separator: " ").map{Int(String($0))!}
    let width   = input[1]
    let height  = input[0]
    var count   = 1
    var map     = Array(repeating: [String](), count: height)
    for i in 0..<height
    {
        map[i] = readLine()!.map{String($0)}
    }
    var visited = [map[0][0]]
    dfs((0,0,count), width, height, &count, &visited, map)
    print(count)
}
BOJ_1987()
