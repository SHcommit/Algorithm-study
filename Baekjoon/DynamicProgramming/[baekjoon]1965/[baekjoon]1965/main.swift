import Foundation
/*
 dp인데 lis로 풀었지 헤헷
 */
func binarySearch(_ target: Int, _ seq : inout [Int])
{
    var left = 0 , right = seq.count - 1
    while left < right
    {
        let mid = (left+right)/2
        if target > seq[mid]
        {
            left = mid + 1
        }
        else
        {right = mid}
    }
    seq[right] = target
}

func BOJ_1965()
{
    let n   = Int(readLine()!)!
    let box = readLine()!.split(separator:" ").map{Int(String($0))!}
    var seq = [box[0]]
    for i in 1..<n
    {
        if seq.last! < box[i]
        {
            seq.append(box[i])
        }
        else
        {
            binarySearch(box[i], &seq)
        }
    }
    print(seq.count)
}
BOJ_1965()
