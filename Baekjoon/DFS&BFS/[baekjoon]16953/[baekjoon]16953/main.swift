import Foundation
/**
 * 호호 bfs 문제!! 원래 bfs는 상하좌우 탐색 조건을 많이 봤었는데 이 문제는
 * 상 하 좌 우가 아닌
 * 현재값 * 2  or  현재값 * 10 + 1   로 목적지(B)로 탐색을 해 나가는 문제이다_)_ ㅎㅎ
 */
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
