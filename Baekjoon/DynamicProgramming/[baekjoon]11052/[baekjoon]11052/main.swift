import Foundation
/**
 * visit my tistory
 *
https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-11052-%EC%B9%B4%EB%93%9C-%EA%B5%AC%EB%A7%A4%ED%95%98%EA%B8%B0
 */
/**
 * n   = 민규가 살 카드 개수
 * list = 카드팩(index)에 금액 들어있음
 * dp = 특정 카드개수에서 최대 경우의수로 선택된 금액 저장
 */
func BOJ_11052()
{
    let n    = Int(readLine()!)!
    var list = [0]
    var dp   = list
    list.append(contentsOf: readLine()!.split(separator: " ").map{Int(String($0))!})
    
    for i in 1...n
    {
        var j = i
        dp.append(list[i])
        while j >= i / 2
        {
            dp[i] = max(dp[i], dp[j] + dp[i-j])
            j -= 1
        }
    }
    print(dp[n])
}
BOJ_11052()
