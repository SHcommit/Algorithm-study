import Foundation
/**
 * 이 문제는 계단을 1 / 1,2 / 1,2,3 / 1,2,3,4 로 오를 때 dp를 적용시킬 수 있는
 * 최대값을 요구하는 패턴을 dp로 저장하면서 구해나가는 것이다.
 */
func BOJ_2579()
{
    let maxNum = 301
    let n    = Int(readLine()!)!
    var list = Array(repeating: 0, count: maxNum)
    var dp   = list
    for i in 1...n
    {
        list[i] = Int(readLine()!)!
    }

    dp[1] = list[1]
    dp[2] = list[1] + list[2]
    dp[3] = max(dp[1] + list[3], list[2] + list[3])

    if n > 3
    {
        for i in 4...n
        {
            dp[i] = max(dp[i-2] , dp[i-3] + list[i-1]) + list[i]
        }
    }
    print(dp[n])
}
BOJ_2579()
