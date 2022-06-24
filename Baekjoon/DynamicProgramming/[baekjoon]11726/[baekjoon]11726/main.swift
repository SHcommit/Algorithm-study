import Foundation
// 이 문제는 dp를 구할때 경우의수가 점점 많아져서
// 새로운 타일 n을 구하기 전에 패턴 % 10007을 해야한다.
func BOJ_11726()
{
    var n  = Int(readLine()!)!
    var dp = Array(repeating: 0, count: n + 2)
    dp[1]  = 1
    dp[2]  = 2
    if n > 2
    {
        for i in 3...n
        {
            dp[i] = (dp[i-1] + dp[i-2]) % 10007
        }
    }
    print(dp[n])
}
BOJ_11726()
