import Foundation
func binarySearch(_ target : Int, _ sequence : inout [Int])
{
    var left = 0, right = sequence.count
    while left < right
    {
        let mid = (left+right)/2
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
func BOJ_1365()
{
    let _ = Int(readLine()!)!
    let line = readLine()!.split(separator:" ").map{Int(String($0))!}
    var sequence = [line[0]]
    for i in 1..<line.count
    {
        if sequence.last! < line[i]
        {
            sequence.append(line[i])
        }
        else
        {
            binarySearch(line[i], &sequence)
        }
    }
    print(line.count - sequence.count)
}
BOJ_1365()
