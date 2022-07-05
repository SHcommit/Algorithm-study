import Foundation
typealias Element = (node : Int, value : Int)
func BFS(_ node : Int, _ n : Int, _ dist : inout [Int], _ list : [[Int]])
{
    var visited = Array(repeating: false, count: n + 1)
    var queue   = [(Int,Int)]()
    
    queue.append((node,0))
    
    var index   = 0
    visited[node]  = true
    
    while queue.count != index
    {
        let (curNode, curValue) = queue[index]
        index += 1
        for nNode in list[curNode]
        {
            if !visited[nNode]
            {
                visited[nNode] = true
                queue.append((nNode,curValue + 1))
            }
        }
    }
    dist[node] = queue[queue.count - 1].1
}
func BOJ_2660()
{
    var n = Int(readLine()!)!
    var list = Array(repeating: [Int](), count: n + 1)
    var dist = Array(repeating: 0, count: n + 1)
    
    while true
    {
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        let p1 = input[0]
        let p2 = input[1]
        if p1 == -1
        {
            break
        }
        list[p1].append(p2)
        list[p2].append(p1)
    }
    
    for node in 1...n
    {
        BFS(node, n, &dist, list)
    }
    var min      = 9999999
    var minCount = 0
    var res      = ""
    for node in 1...n
    {
        if min > dist[node]
        {
            min      = dist[node]
            minCount = 0
            res      = ""
        }
        if min == dist[node]
        {
            res      += "\(node) "
            minCount += 1
        }
    }
    print("\(min) \(minCount)")
    print(res)
}
BOJ_2660()
