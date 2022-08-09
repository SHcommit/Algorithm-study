import Foundation
//func binarySearch(_ target: Int, _ seq : inout [Int])
//{
//    var left = 0, right = seq.count - 1
//    while left < right
//    {
//        let mid = (left+right)/2
//        if seq[mid] < target
//        {
//            left = mid + 1
//        }
//        else
//        {
//            right = mid
//        }
//    }
//    seq[right] = target
//}
func BOJ_2631()
{
    let n    = Int(readLine()!)!
    var list = [Int]()
    for _ in 0..<n
    {
        list.append(Int(readLine()!)!)
    }
    var seq  = [list[0]]
    for i in 1..<n
    {
        if seq.last! < list[i]
        {
            seq.append(list[i])
        }
        else
        {
            binarySearch(list[i], &seq)
        }
    }
    print(n - seq.count)
//    var dp = Array(repeating: 0, count: n)
//    for i in 0..<n
//    {
//        dp[i] = 1
//        for j in 0..<i
//        {
//            if list[j] < list[i] && dp[j]+1 > dp[i]
//            {
//                dp[i] = dp[j] + 1
//            }
//        }
//    }
//    var ans = 0
//    for i in 0..<n
//    {
//        if ans < dp[i]
//        {
//            ans = dp[i]
//        }
//    }
//    print(ans)
}
BOJ_2631()
