import Foundation
//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-1541-%EC%9E%83%EC%96%B4%EB%B2%84%EB%A6%B0-%EA%B4%84%ED%98%B8
func BOJ_1541()
{
    var str      = readLine()!.split(separator: "-")
    var sumList  = Array(repeating: 0, count: str.count)
    var answer   = 0
    for i in 0..<str.count
    {
        var temp = str[i].split(separator: "+")
        temp.forEach
        {
            sumList[i] += Int($0)!
        }
    }
    answer = sumList[0]
    for i in 1..<sumList.count
    {
        answer -= sumList[i]
    }
    print(answer)
}
BOJ_1541()
