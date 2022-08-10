import Foundation
//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-2230-%EC%88%98-%EA%B3%A0%EB%A5%B4%EA%B8%B0-%EB%AC%B8%EC%A0%9C-%EB%BF%8C%EC%88%98%EA%B8%B0
func BOJ_2230()
{
    let NM   = readLine()!.split(separator:" ").map{Int(String($0))!}
    let n    = NM[0], m = NM[1]
    var list = [Int]()
    var ans  = 2000000001
    for _ in 0..<n
    {
        list.append(Int(readLine()!)!)
    }
    list.sort()
    var left = 0 , right = 0
    while left < n && right < n
    {
        let diff = list[right]-list[left]
        if diff < m
        {
            right += 1
        }
        else if diff >= m
        {
            left += 1
            ans = min(diff,ans)
        }
    }
    print(ans)
}

BOJ_2230()

