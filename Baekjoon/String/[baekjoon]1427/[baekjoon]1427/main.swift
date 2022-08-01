import Foundation
func binarySearch(_ target : Int, _ seq : inout [Int])
{
    var left = 0, right = seq.count - 1
    while left < right
    {
        let mid = (left+right)/2
        if target < seq[mid]
        {
            left = mid + 1
        }
        else
        {right = mid}
        seq[right] = mid
    }
}
func BOJ_1472()
{
    
    var list = readLine()!.map{Int(String($0))!}
    var ans = [list[0]]
    for i in 0..<list.count
    {
        if list[i] > ans.
    }
}
BOJ_1472()
