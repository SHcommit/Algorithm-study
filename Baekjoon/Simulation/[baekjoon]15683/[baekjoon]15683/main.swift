import Foundation
typealias point = (x:Int,y:Int)
//left == 0,right == 1,up == 2,down == 3
let direction   : [point] = [(-1,0),(1,0),(0,1),(0,-1)]
class mapInfo
{
    let height   : Int
    let width    : Int
    var map      : [[Int]]
    var cctvList : [point]
    init()
    {
        let hw   = readLine()!.split(separator:" ").map{Int(String($0))!}
        height   = hw[0]
        width    = hw[1]
        map      = Array(repeating: [Int](), count: height)
        cctvList = [point]()
        for y in 0..<height
        {
            map[y] = readLine()!.split(separator:" ").map{Int(String($0))!}
            for x in 0..<width
            {
                if map[y][x] >= 1 && map[y][x] <= 5
                {
                    cctvList.append((x,y))
                }
            }
        }
    }
}
func cctvSight(_ point : point,_ arrow : inout [Int], _ info : mapInfo)
{
    let (cctvX,cctvY) = (point.x,point.y)
    
    for i in 0..<direction.count
    {
        var curX = cctvX, curY = cctvY
        while true
        {
            curX = curX + direction[i].x
            curY = curY + direction[i].y
            if curX < 0 || curX > info.width - 1 || curY < 0 || curY > info.height - 1 || info.map[curY][curX] == 6
            {
                break
            }
            else if info.map[curY][curX] == 0
            {
                arrow[i] += 1
            }
        }
    }
}

func onCctv(_ point : point, arrow i : Int, _ info : inout mapInfo){
    let (cctvX,cctvY) = (point.x,point.y)
    
    var curX = cctvX, curY = cctvY
    while true
    {
        curX = curX + direction[i].x
        curY = curY + direction[i].y
        if curX < 0 || curX > info.width - 1 || curY < 0 || curY > info.height - 1 || info.map[curY][curX] == 6
        {
            break
        }
        else if info.map[curY][curX] == 0
        {
            info.map[curY][curX] = -1
        }
    }

}

func BOJ_15683()
{
    var info = mapInfo()
//    info.cctvList.sort
//    {
//        if info.map[$0.y][$0.x] > info.map[$1.y][$1.x]
//        {
//            return true
//        }
//        else {return false}
//    }
    var index = 0
    while info.cctvList.count != index
    {
        let (cctvX,cctvY) = info.cctvList[index]
        var map  = info.map
        var arrow = Array(repeating: 0, count: 4)
        index += 1
        cctvSight((cctvX,cctvY), &arrow, info)
        var (left,right,up,down) = (arrow[0],arrow[1],arrow[2],arrow[3])
        
        switch map[cctvY][cctvX]
        {
        case 1:
            var temp = max(left, right, up, down)
            for i in 0..<4
            {
                if temp == arrow[i]
                {
                    onCctv((cctvX,cctvY), arrow: i, &info)
                    break;
                }
            }
            break;
        case 2:
            if left+right >= up+down
            {
                onCctv((cctvX,cctvY), arrow: 0, &info)
                onCctv((cctvX,cctvY), arrow: 1, &info)
            }
            else
            {
                onCctv((cctvX,cctvY), arrow: 2, &info)
                onCctv((cctvX,cctvY), arrow: 3, &info)
            }
            break;
        case 3:
            if left > right
            {
                onCctv((cctvX,cctvY), arrow: 0, &info)
                if up > down
                {
                    onCctv((cctvX,cctvY), arrow: 2, &info)
                    break;
                }
                onCctv((cctvX,cctvY), arrow: 3, &info)
            }
            else
            {
                onCctv((cctvX,cctvY), arrow: 1, &info)
                if up > down
                {
                    onCctv((cctvX,cctvY), arrow: 2, &info)
                    break;
                }
                onCctv((cctvX,cctvY), arrow: 3, &info)
            }
            break;
            //left == 0,right == 1,up == 2,down == 3
        case 4:
            let temp = arrow.sorted(by: <)
            var flag = false
            for i in 0..<4
            {
                if arrow[i] == temp[0] && !flag
                {
                    flag = true
                    continue
                }
                onCctv((cctvX,cctvY), arrow: i, &info)
            }
            break;
        case 5:
            onCctv((cctvX,cctvY), arrow: 0, &info)
            onCctv((cctvX,cctvY), arrow: 1, &info)
            onCctv((cctvX,cctvY), arrow: 2, &info)
            onCctv((cctvX,cctvY), arrow: 3, &info)
            break;
        default:
            break;
        }
    }
    var ans = 0
    for y in 0..<info.height
    {
        for x in 0..<info.width
        {
            if info.map[y][x] == 0
            {
                ans += 1
            }
        }
    }
    print(ans)

}
BOJ_15683()
