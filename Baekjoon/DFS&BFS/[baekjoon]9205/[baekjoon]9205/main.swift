import Foundation
typealias point = (x:Int,y:Int)
let direction = [(0,1000),(0,-1000),(1000,0),(-1000,0)]
func bfs(_ start : point, _ end : point, _ storeList : [point],_ res : inout String)
{
    var queue    = [(start.x,start.y)]
    var index    = 0
    var visitedX = Set<Int>()
    var visitedY = Set<Int>()
    visitedX.insert(start.x)
    visitedY.insert(start.y)
    while queue.count != index
    {
        let (curX,curY) = queue[index]
        index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX+dx,curY+dy)
            if nx >= end.x && ny >= end.y
            {
                res += "happy\n"
                return
            }
            if nx > 32767 || nx < -32768 || ny > 32767 || ny < -32768
            {
                continue
            }
            var isStore = false
            for (storeX,storeY) in storeList
            {
                if storeX == nx && storeY == ny
                {
                    isStore = true
                    break
                }
            }
            if isStore
            {
                let (isVisitedX,_) = visitedX.insert(nx)
                let (isVisitedY,_) = visitedY.insert(ny)
                if !isVisitedX || !isVisitedY
                {
                    queue.append((nx,ny))
                }
            }
        }
    }
    res += "sad\n"
}
func BOJ_9205()
{
    let n   = Int(readLine()!)!
    var res = ""
    for _ in 0..<n
    {
        let store = Int(readLine()!)!
        let startPoint = readLine()!.split(separator:" ").map{Int(String($0))!}
        let (startX,startY) = (startPoint[0],startPoint[1])
        var storeList = [(Int,Int)]()
        for _ in 0..<store
        {
            let input = readLine()!.split(separator:" ").map{Int(String($0))!}
            storeList.append((input[0],input[1]))
        }
        let endPoint = readLine()!.split(separator:" ").map{Int(String($0))!}
        let (endX,endY) = (endPoint[0],endPoint[1])
        bfs((startX,startY), (endX,endY), storeList, &res)
    }
    print(res)
}
BOJ_9205()
