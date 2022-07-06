import Foundation
class Q
{
    var queue : [(Int,String)]
    var index : Int
    init()
    {
        queue = [(Int,String)]()
        index = 0
    }
}
func D (_ number : Int) -> Int
{
    return (number*2) % 10000
}
func S (_ number : Int) -> Int
{
    if number == 0
    {
        return 9999
    }
    return number - 1
}
func L (_ number : Int) -> Int
{
    return (number % 1000) * 10 + number/1000
}
func R (_ number : Int) -> Int
{
    return (number % 10) * 1000 + number/10
}
func BFS(_ start : Int, _ end : Int, res : inout String)
{
    var visited = Array(repeating: false, count: 10000)
    let q       = Q()
    
    q.queue.append((start,""))
    while q.queue.count != q.index
    {
        let (curNum, command) = q.queue[q.index]
        visited[curNum] = true
        q.index += 1
        
        for (nNum,nCommand) in [(D(curNum),"D"),(S(curNum),"S"),(L(curNum),"L"),(R(curNum),"R")]
        {
            if nNum == end
            {
                res += command + nCommand + "\n"
                return
            }
             if !visited[nNum]
            {
                 q.queue.append((nNum,command + nCommand))
                 visited[nNum] = true
             }
        }
    }
}
func BOJ_9019()
{
    let n   = Int(readLine()!)!
    var res = ""
    for _ in 0..<n
    {
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        let start = input[0]
        let end   = input[1]
        BFS(start, end, res: &res)
    }
    print(res)
}
BOJ_9019()
