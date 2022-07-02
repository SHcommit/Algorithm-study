import Foundation

class Q
{
    var queue   : [Int]
    var index   : Int
    init()
    {
        queue = [Int]()
        index = 0
    }
}
class FSGUD
{
    let totalFloor  : Int
    let startFloor  : Int
    let arriveFloor : Int
    let upFloor     : Int
    let DownFloor   : Int
    init()
    {
        let FSGUD = readLine()!.split(separator: " ").map{Int(String($0))!}
        totalFloor  = FSGUD[0]
        startFloor  = FSGUD[1]
        arriveFloor = FSGUD[2]
        upFloor     = FSGUD[3]
        DownFloor   = FSGUD[4]
    }
}
func BFS(_ info : FSGUD, _ res : inout String)
{
    var q       = Q()
    var visited = Array(repeating: 0, count: info.totalFloor + 1)
    visited[info.startFloor] = 1
    let direction = [info.upFloor, -info.DownFloor]
    q.queue.append(info.startFloor)
    
    while q.queue.count != q.index
    {
        let curFloor = q.queue[q.index]
        if curFloor == info.arriveFloor
        {
            res = "\(visited[curFloor] - 1)"
            return
        }
        q.index += 1
        for dFloor in direction
        {
            let nFloor = dFloor + curFloor
            if nFloor < 1 || nFloor > info.totalFloor
            {
                continue
            }
            if visited[nFloor] == 0
            {
                q.queue.append(nFloor)
                visited[nFloor] = visited[curFloor] + 1
            }
        }
    }
}
func BOJ_5014()
{
    let info = FSGUD()
    var res  = "use the stairs"
    BFS(info, &res)
    print(res)
}
BOJ_5014()
