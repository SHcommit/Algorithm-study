import Foundation
typealias Element = (curNum : Int, command : String)

class Q
{
    var queue : [Element]
    var index : Int
    init()
    {
        queue = [Element]()
        index = 0
    }
}
class calculator
{
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
}
func BFS(_ start : Int, _ end : Int, res : inout String)
{
    let calculator = calculator()
    var visited    = Array(repeating: false, count: 10000)
    let q          = Q()
    
    q.queue.append((start,""))
    while q.queue.count != q.index
    {
        let (curNumber, command) = q.queue[q.index]
        visited[curNumber] = true
        q.index += 1
        if curNumber == end
        {
            res += command + "\n"
            return
        }
        var nNumber = calculator.D(curNumber)
        if !visited[nNumber]
        {
            q.queue.append((nNumber, command + "D"))
            visited[nNumber] = true
        }
        
        nNumber = calculator.S(curNumber)
        if !visited[nNumber]
        {
            q.queue.append((nNumber, command + "S"))
            visited[nNumber] = true
        }
        
        nNumber = calculator.L(curNumber)
        if !visited[nNumber]
        {
            q.queue.append((nNumber, command + "L"))
            visited[nNumber] = true
        }
        
        nNumber = calculator.R(curNumber)
        if !visited[nNumber]
        {
            q.queue.append((nNumber, command + "R"))
            visited[nNumber] = true
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



