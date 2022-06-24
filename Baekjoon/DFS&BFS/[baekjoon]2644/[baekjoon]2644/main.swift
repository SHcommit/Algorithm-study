import Foundation

//음.. 트리는 이문제는 트리로 표현하기까지가 좀 시간이 걸렸어
// 근데 뭐 딕셔너리보다 동적 배열도 ㄱㅊ은거같규~,,~
typealias relation = (Int, Int)

func bfs(res : inout Int, find : relation,n : Int, list : [[Int]])
{
    var queue = [Int]()
    var visit = Array(repeating: 0, count: n + 1)
    var index = 0
    queue.append(find.1)
    visit[0] = 1
    visit[find.1] = 1
    while queue.count != index
    {
        var person = queue[index]
        if person == find.0
        {
            res = visit[person] - 1
            return
        }
        index += 1
        for i in list[person]
        {
            if visit[i] == 0
            {
                queue.append(i)
                visit[i] = visit[person] + 1
            }
        }
    
    }
}
func BOJ_2644()
{
    let n = Int(readLine()!)!
    var res = -1
    var list = Array(repeating: [Int](), count: n + 1)
    var need : relation
    = {
        var input = readLine()!.split(separator: " ").map{Int(String($0))!}
        return (input[0],input[1])
    }()
    let count = Int(readLine()!)!
    
    for i in 0..<count
    {
        var input = readLine()!.split(separator: " ").map{Int($0)!}
        list[input[0]].append(input[1])
        list[input[1]].append(input[0])
    }
    bfs(res: &res, find: need,n :n, list: list)
    
    print(res)
}
BOJ_2644()
