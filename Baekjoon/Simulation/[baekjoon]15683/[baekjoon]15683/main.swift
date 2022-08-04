import Foundation
/*
 ㅋㅋ 초기에는 그냥
 상 하 좌 우 일단 시야각 탐색하고 (아기상어 문제처럼)
 cctv 종류에 따라 그리디하게 최적의 값을 선택해서 탐색해 나갔는데 이게.. 음 예를들어 cctv == 3일때 왼 위 랑 위 오른쪽 이 cctv시야가 같다고
 가정했을 때 그냥 무저건 왼 위만 해버려서..
 그리고 또 이게 무조건 cctv가 많이 탐색할 수 록 좋을 것 같아서 sort해줬는데 그래도 2랑 3, 1일때.. 작은게 우선시 할 때 cctv값이 차이나는게 있더라고..
 
 4 6
 2 6 0 3 0 2
 0 0 0 0 0 0
 0 0 0 0 0 0
 0 0 0 0 6 1
 correct = 8 , 난 차꾸 9
 
 3 6
 0 5 5 0 2 0
 0 0 2 0 0 3
 0 0 0 0 0 0
 correct = 2, wrong = 3
 
 그래서 그냥 무...완전한 경우를 파악하며 시도했다....
 */
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
//func cctvSight(_ point : point,_ arrow : inout [Int], _ info : mapInfo)
//{
//    let (cctvX,cctvY) = (point.x,point.y)
//
//    for i in 0..<direction.count
//    {
//        var curX = cctvX, curY = cctvY
//        while true
//        {
//            curX = curX + direction[i].x
//            curY = curY + direction[i].y
//            if curX < 0 || curX > info.width - 1 || curY < 0 || curY > info.height - 1 || info.map[curY][curX] == 6
//            {
//                break
//            }
//            else if info.map[curY][curX] == 0
//            {
//                arrow[i] += 1
//            }
//        }
//    }
//}

func onCctv(_ point : point, arrow i : Int, _ info : mapInfo,_ map : inout[[Int]]){
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
        else if map[curY][curX] == 0
        {
            map[curY][curX] = -1
        }
    }

}

func cctvWorking(_ index : Int,_ info : mapInfo, map : [[Int]], _ ans : inout Int)
{
    if index == info.cctvList.count
    {
        var count = 0
        for y in 0..<info.height
        {
            for x in 0..<info.width
            {
                if map[y][x] == 0
                {
                    count += 1
                }
            }
        }
        if count < ans
        {
            ans = count
            return
        }
        return
    }
    let (cctvX,cctvY) = info.cctvList[index]
    //var arrow = Array(repeating: 0, count: 4)
//    cctvSight((cctvX,cctvY), &arrow, info)
//    var (left,right,up,down) = (arrow[0],arrow[1],arrow[2],arrow[3])
    var m = map
    switch map[cctvY][cctvX]
    {
    case 1:
        for i in 0..<4
        {
            m = map
            onCctv((cctvX,cctvY), arrow: i, info, &m)
            cctvWorking(index + 1, info, map: m, &ans)
        }
        break;
    case 2:
        onCctv((cctvX,cctvY), arrow: 0, info,&m)
        onCctv((cctvX,cctvY), arrow: 1, info,&m)
        cctvWorking(index+1, info, map: m, &ans)
        var m2 = map
        onCctv((cctvX,cctvY), arrow: 2, info,&m2)
        onCctv((cctvX,cctvY), arrow: 3, info,&m2)
        cctvWorking(index+1, info, map: m2, &ans)
        break;
    case 3:
        onCctv((cctvX,cctvY), arrow: 0, info, &m)
        var m2 = m
        onCctv((cctvX,cctvY), arrow: 2, info,&m)
        cctvWorking(index+1, info, map: m, &ans)
        onCctv((cctvX,cctvY), arrow: 3, info, &m2)
        cctvWorking(index+1, info, map: m2, &ans)
        var m3 = map
        onCctv((cctvX,cctvY), arrow: 1, info,&m3)
        var m4 = m3
        onCctv((cctvX,cctvY), arrow: 2, info,&m3)
        cctvWorking(index+1, info, map: m3, &ans)
        onCctv((cctvX,cctvY), arrow: 3, info, &m4)
        cctvWorking(index+1, info, map: m4, &ans)
        break;
    case 4:
        var m2 = map
        var m3 = map
        var m4 = map
        onCctv((cctvX,cctvY), arrow: 0, info, &m)
        onCctv((cctvX,cctvY), arrow: 1, info, &m)
        onCctv((cctvX,cctvY), arrow: 2, info, &m)
        cctvWorking(index+1, info, map: m, &ans)
        onCctv((cctvX,cctvY), arrow: 0, info, &m2)
        onCctv((cctvX,cctvY), arrow: 1, info, &m2)
        onCctv((cctvX,cctvY), arrow: 3, info, &m2)
        cctvWorking(index+1, info, map: m2, &ans)
        onCctv((cctvX,cctvY), arrow: 0, info, &m3)
        onCctv((cctvX,cctvY), arrow: 2, info, &m3)
        onCctv((cctvX,cctvY), arrow: 3, info, &m3)
        cctvWorking(index+1, info, map: m3, &ans)
        onCctv((cctvX,cctvY), arrow: 1, info, &m4)
        onCctv((cctvX,cctvY), arrow: 2, info, &m4)
        onCctv((cctvX,cctvY), arrow: 3, info, &m4)
        cctvWorking(index+1, info, map: m4, &ans)
        break;
    case 5:
        onCctv((cctvX,cctvY), arrow: 0, info,&m)
        onCctv((cctvX,cctvY), arrow: 1, info,&m)
        onCctv((cctvX,cctvY), arrow: 2, info,&m)
        onCctv((cctvX,cctvY), arrow: 3, info,&m)
        cctvWorking(index+1, info, map: m, &ans)
        break;
    default:
        break;
    }
}

func BOJ_15683()
{
    var info = mapInfo()
    var index = 0
    var ans  = 9999999
//    info.cctvList.sort
//        {
//            if info.map[$0.y][$0.x] > info.map[$1.y][$1.x]
//            {
//                return true
//            }
//            else {return false}
//        }
    cctvWorking(0, info, map: info.map, &ans)
//    while info.cctvList.count != index
//    {
//        let (cctvX,cctvY) = info.cctvList[index]
//        var map  = info.map
//        var arrow = Array(repeating: 0, count: 4)
//        index += 1
//        cctvSight((cctvX,cctvY), &arrow, info)
//        var (left,right,up,down) = (arrow[0],arrow[1],arrow[2],arrow[3])
        
//        switch map[cctvY][cctvX]
//        {
//        case 1:
//            var temp = max(left, right, up, down)
//            for i in 0..<4
//            {
//                if temp == arrow[i]
//                {
//                    onCctv((cctvX,cctvY), arrow: i, &info)
//                    break;
//                }
//            }
//            break;
//        case 2:
//            if left+right >= up+down
//            {
//                onCctv((cctvX,cctvY), arrow: 0, &info)
//                onCctv((cctvX,cctvY), arrow: 1, &info)
//            }
//            else
//            {
//                onCctv((cctvX,cctvY), arrow: 2, &info)
//                onCctv((cctvX,cctvY), arrow: 3, &info)
//            }
//            break;
//        case 3:
//            if left > right
//            {
//                onCctv((cctvX,cctvY), arrow: 0, &info)
//                if up > down
//                {
//                    onCctv((cctvX,cctvY), arrow: 2, &info)
//                    break;
//                }
//                onCctv((cctvX,cctvY), arrow: 3, &info)
//            }
//            else
//            {
//                onCctv((cctvX,cctvY), arrow: 1, &info)
//                if up > down
//                {
//                    onCctv((cctvX,cctvY), arrow: 2, &info)
//                    break;
//                }
//                onCctv((cctvX,cctvY), arrow: 3, &info)
//            }
//            break;
//            //left == 0,right == 1,up == 2,down == 3
//        case 4:
//            let temp = arrow.sorted(by: <)
//            var flag = false
//            for i in 0..<4
//            {
//                if arrow[i] == temp[0] && !flag
//                {
//                    flag = true
//                    continue
//                }
//                onCctv((cctvX,cctvY), arrow: i, &info)
//            }
//            break;
//        case 5:
//            onCctv((cctvX,cctvY), arrow: 0, &info)
//            onCctv((cctvX,cctvY), arrow: 1, &info)
//            onCctv((cctvX,cctvY), arrow: 2, &info)
//            onCctv((cctvX,cctvY), arrow: 3, &info)
//            break;
//        default:
//            break;
//        }
//    }
    print(ans == 9999999 ? 0 : ans)

}
BOJ_15683()
