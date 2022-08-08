import Foundation

//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-1806-%EB%B6%80%EB%B6%84%ED%95%A9-%EB%AC%B8%EC%A0%9C-%EB%BF%8C%EC%88%98%EA%B8%B0-2%EA%B0%9C-%EB%B0%98%EB%A1%80
func BOJ_1806()
{
    let ns = readLine()!.split(separator:" ").map{Int(String($0))!}
    let n = ns[0], minSum = ns[1]
    let list = readLine()!.split(separator:" ").map{Int(String($0))!}
    
    var right = 0
    var ans = 100001
    var sum = 0
    
    for left in 0..<n
    {
        //최소 합보다 크면 minSum보다 크니까 더이상 sum을 구해나갈 이유가 없다.
        while sum < minSum && right < n
        {
            sum += list[right]
            right += 1
        }
        if sum >= minSum && ans > (right - left)
        {
            ans = right - left
        }
        sum -= list[left]
    }
    print(ans == 100001 ? 0 : ans)
}
BOJ_1806()

