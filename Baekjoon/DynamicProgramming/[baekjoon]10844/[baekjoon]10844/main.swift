import Foundation
/*
    이 문제는 계단을 더해갈때 % 1,000,000,000 하지 않고 n=100일때 구하면 n=68번째일때쯤 오버플로우가 발생함.
    계단수란 전,후 숫자 차이가 1 나는 수를 계단수라함!!
 */
extension Array where Element : Comparable{
    func sum() -> Int
    {
        var value = 0
        self.forEach
        {
            value += $0 as! Int
        }
        return value % 1000000000
    }
}
func BOJ_10844()
{
    let n  = Int(readLine()!)!
    var dp = Array(repeating: Array(repeating: 0, count: 10) , count: n+1)
    for i in 1...n
    {
        if i == 1
        {
            dp[i] = [0,1,1,1,1,1,1,1,1,1]
            continue
        }
        for j in 0..<10
        {
            if j == 0
            {
                dp[i][j] += (dp[i-1][j+1]) % 1000000000
            }
            else if j != 0 && j != 9
            {
                dp[i][j] += (dp[i-1][j-1] + dp[i-1][j+1]) % 1000000000
            }else
            {
                dp[i][j] += (dp[i-1][j-1]) % 1000000000
            }
        }
    }
    print(dp[n].sum())
}
BOJ_10844()
