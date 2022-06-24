import Foundation

class move
{
    var location : Int
    var teleport : Int
    var front    : Int
    var back     : Int
    init(_ location : Int)
    {
        self.location = location
        teleport      = location * 2
        front         = location + 1
        back          = location - 1
    }
}

class location
{
    var subin  : Int
    var sister : Int
    init()
    {
        if let input = readLine()
        {
            let subin_sister = input.split(separator: " ").map{Int($0)!}
            subin  = subin_sister[0]
            sister = subin_sister[1]
        }else
        {
            subin  = -1
            sister = -1
        }
    }
}

func findSister(_ location : location, _ second : inout Int)
{
    
    var queue   = [(Int,Int)]()
    var index   = 0
    var visited = Array(repeating: false, count: 100001)
    var prevSec = 0
    visited[0]  = true
    queue.append((location.subin,second))
    visited[location.subin] = true
    
    while queue.count != index
    {
        let locate = queue[index].0
        let nSec   = queue[index].1
        index += 1
        var moved  = move(locate)
        if nSec == second { second += 1 }
        if moved.teleport == location.sister ||
            moved.back == location.sister ||
            moved.front == location.sister
        {
            return
        }
        if moved.teleport > 0 && moved.teleport < 100001
        {
            if !visited[moved.teleport]
            {
                queue.append((moved.teleport,nSec + 1))
                visited[moved.teleport] = true
            }
        }
        if moved.front > 0 && moved.front < 100001
        {
            if !visited[moved.front]
            {
                queue.append((moved.front, nSec + 1))
                visited[moved.front] = true
            }
        }
        if moved.back > 0 && moved.back < 100001
        {
            if !visited[moved.back]
            {
                queue.append((moved.back,nSec + 1))
                visited[moved.back] = true
            }
        }
    }
}
func BOJ_1609()
{
    let location = location()
    var second   = 0
    if location.sister == location.subin
    {
        print(0)
        return
    }
    findSister(location, &second)
    print(second)
}
BOJ_1609()
