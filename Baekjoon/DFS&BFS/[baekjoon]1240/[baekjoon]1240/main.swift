import Foundation
typealias Element = (Int,Int)
class graph
{
    let n : Int
    let m : Int
    var graph : [[Element]]
    init()
    {
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        n         = input[0]
        m         = input[1]
        graph     = Array(repeating: [Element](), count: n + 1)
        for _ in 0..<n-1
        {
            let nodes_weight = readLine()!.split(separator: " ").map{Int(String($0))!}
            let fNode        = nodes_weight[0]
            let secNode      = nodes_weight[1]
            let weight       = nodes_weight[2]
            graph[fNode].append((secNode,weight))
            graph[secNode].append((fNode,weight))
        }
    }
}
func BFS(_ sNode : Int, _ eNode : Int, _ res : inout String, _ g : graph)
{
    //튜플 두번째는 누적 weight가 들어감
    var queue = [(sNode,0)]
    var index = 0
    var visited = Array(repeating: false, count: g.n + 1)
    visited[sNode] = true
    while queue.count != index
    {
        let (curNode,curWeight) = queue[index]
        index += 1
        if curNode == eNode
        {
            res += "\(curWeight)\n"
            return
        }
        for (nNode,nWeight) in g.graph[curNode]
        {
            if !visited[nNode]
            {
                visited[nNode] = true
                queue.append((nNode, curWeight + nWeight))
            }
        }
    }
}
func BOJ_1240()
{
    var res = ""
    var g   = graph()
    for _ in 0..<g.m
    {
        var distTwoNode = readLine()!.split(separator: " ").map{Int(String($0))!}
        let sNode  = distTwoNode[0]
        let eNode  = distTwoNode[1]
        BFS(sNode, eNode, &res, g)
    }
    print(res)
}
BOJ_1240()
