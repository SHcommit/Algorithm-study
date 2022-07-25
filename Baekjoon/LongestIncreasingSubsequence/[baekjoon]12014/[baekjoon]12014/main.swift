import Foundation
/*
 약간 당황한게 첫날은 무조건 사는 건데..
 어차피 두번째 날이 작으면 이진탐색을 통해 seq가 낮은 거로 교체가 된다.
 */
func binarySearch(_ target : Int, _ seq : inout [Int])
{
    var left = 0, right = seq.count - 1
    while left < right
    {
        let mid = (left + right) / 2
        if target > seq[mid]
        {
            left = mid + 1
        }
        else
        {
            right = mid
        }
    }
    seq[right] = target
}
func BOJ_12014()
{
    var res = ""
    var test = Int(readLine()!)!
    for index in 1...test
    {
        let input = readLine()!.split(separator:" ").map{Int(String($0))!}
        var stock = readLine()!.split(separator:" ").map{Int(String($0))!}
        let (n,k) = (input[0],input[1])
        var seq   = [stock[0]]
        for i in 1..<n
        {
            if stock[i] > seq.last!
            {
                seq.append(stock[i])
            }
            else
            {
                binarySearch(stock[i], &seq)
            }
        }
        res += "Case #\(index)\n" + (seq.count >= k ? "\(1)\n" : "\(0)\n")
    }
    print(res)
}
BOJ_12014()
