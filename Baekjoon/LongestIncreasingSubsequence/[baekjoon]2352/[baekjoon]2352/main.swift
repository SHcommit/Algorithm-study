import Foundation
/*
  호호 알고보면 LIS문제... 배워야 안다!!
 */
func binarySearch(_ target : Int, _ sequence : inout [Int])
{
    var left = 0 , right = sequence.count - 1, mid = 0
    while left < right
    {
        var mid = (left + right) / 2
        if target > sequence[mid]
        {
            left = mid + 1
        }
        else
        {
            right = mid
        }
    }
    sequence[right] = target
}
func BOJ_2352()
{
    let n = Int(readLine()!)!
    let line = readLine()!.split(separator:" ").map{Int(String($0))!}
    var sequence = [line[0]]
    for i in 1..<n
    {
        if line[i] > sequence.last!
        {
            sequence.append(line[i])
        }
        else
        {
            binarySearch(line[i], &sequence)
        }
    }
    print(sequence.count)
}
BOJ_2352()
