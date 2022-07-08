import Foundation
//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-2133-%ED%83%80%EC%9D%BC-%EC%B1%84%EC%9A%B0%EA%B8%B0-%EB%AC%B8%EC%A0%9C-%EC%99%84%EC%A0%84-%EB%BF%8C%EC%88%98%EA%B8%B0
/**
 * 이 문제 풀면서 변수는.....
 * n==4이면
 * 원래 2칸씩 나눠서 dp[2]가 아닌 새로운 2개의 ㅋ 디자인과
 *
 * n==6 이면
 * 원래 4칸일때 있었던 신기한.. 반으로 쪼갤 수없는 2개의 디자인 + 6개일때 또한 2개씩 3번 나눌수 없는
 * 유일한 디자인 한개 * 상하 바뀐게 존재한다는거다.
 *
 * n == 8이면
 * 원래 4일때 신기 + 6일때 신기 + 8일때 연속적인 디자인으로인해 2칸씩 쪼갤 수 없는 새로운 디자인이 2개 생긴다는 것이다ㅏ..
 * 의 반복이다. 12쪽이나 패턴을 그렸다.ㅠㅠㅠ'';;
 */
func BOJ_2133()
{
    var n  = Int(readLine()!)!
    var dp = Array(repeating: 0, count: 31)
    dp[0] = 1
    dp[2] = 3
    for i in stride(from: 4, through: 30, by: 2)
    {
        dp[i] = dp[2]*dp[i-2]
        for j in stride(from: i - 4, through: 0, by: -2)
        {
            dp[i] += 2*dp[j]
        }
    }
    print(dp[n])
}
BOJ_2133()
