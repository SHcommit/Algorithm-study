import Foundation
typealias Element = (weight : Int, value : Int)
/**
 * 이 문제는 배낭에 물건을 0개부터 n개까지 넣을때, 0weight~ kweight까지 차례적으로 물건을 넣을 때 value가 큰가?? 이전값이 큰가? 를 비교하는 문제..
 * sub-problem을 잘 따져야 한다...
 */

func BOJ_12865()
{
    let nk   = readLine()!.split(separator: " ").map{Int(String($0))!}
    let n    = nk[0]
    let k    = nk[1]
    var list : [Element] = [(0,0)]
    var dp   = Array(repeating: Array(repeating: 0, count: k + 1), count: n + 1)
    
    for i in 1...n
    {
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        list.append((input[0],input[1]))
    }
    
    for i in 1...n
    {
        for j in 1...k
        {
            if list[i].weight <= j
            {
                dp[i][j] = max(dp[i-1][j - list[i].weight] + list[i].value , dp[i-1][j])
            }
            else
            {
                dp[i][j] = dp[i-1][j]
            }
        }
    }
    print(dp[n][k])
}
BOJ_12865()
