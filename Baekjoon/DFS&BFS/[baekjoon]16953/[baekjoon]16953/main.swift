import Foundation

class AB
{
    var a : Int
    var b : Int
    init()
    {
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        a = input[0]
        b = input[1]
    }
}
func bfs(ab : AB, answer : inout Int)
{
    let start  = ab.a
    let finish = ab.b
    var queue  = [(Int,Int)]()
    var index  = 0
    var count  = 0
    queue.append((start,count))
    while queue.count != index
    {
        let (detectNumber,prevCount) = queue[index]
        if prevCount == count
        {
            count += 1
        }
        index += 1
        if detectNumber == finish
        {
            answer = count
            return
        }
        if detectNumber * 2 > finish
        {
            continue
        }else
        {
            queue.append((detectNumber*2, prevCount + 1))
        }
        if detectNumber*10 + 1 > finish
        {
            continue
        }else
        {
            queue.append((detectNumber*10 + 1, prevCount + 1))
        }
    }
}
func BOJ_16953()
{
    var 한글이쓰고싶다네 = AB()
    var answer = -1
    bfs(ab: 한글이쓰고싶다네, answer: &answer)
    print(answer)
}
BOJ_16953()
