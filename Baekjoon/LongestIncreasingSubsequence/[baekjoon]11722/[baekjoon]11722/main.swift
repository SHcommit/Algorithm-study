/*
 우왕..
 LIS와 반대로.
 일단 seq.last보다 작으면 추가!! 크면 이진탐색으로 큰 곳 찾아줘
 근데 여기서 seq는 크면 클수록 왼쪽에 있기에 left right 설정 잘 해주어야함.
 */
import Foundation
func binarySearch(_ target : Int, _ seq : inout [Int] )
{
    var left = 0 , right = seq.count - 1
    while left<right
    {
        let mid = (left+right)/2
        if target < seq[mid]
        {
            left = mid + 1
        }
        else
        {
            right = mid
        }
    }
    seq[right]=target
}
func BOJ_11722()
{
    let n    = Int(readLine()!)!
    let list = readLine()!.split(separator:" ").map{Int(String($0))!}
    var seq  = [list[0]]
    for i in 1..<n
    {
        if list[i] < seq.last!
        {
            seq.append(list[i])
        }
        else
        {
            binarySearch(list[i], &seq)
        }
    }
    print(seq.count)
}
BOJ_11722()
