import Foundation
func binarySearch(_ target : Int, _ seq : inout [Int])
{
    var left = 0 , right = seq.count - 1
    while left < right
    {
        let mid = (left+right)/2
        if seq[mid] < target
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
func BOJ_1818()
{
    let n    = Int(readLine()!)!
    let book = readLine()!.split(separator:" ").map{Int(String($0))!}
    var seq  = [book[0]]
    for i in 1..<n
    {
        if book[i] > seq.last!
        {
            seq.append(book[i])
        }
        else
        {
            binarySearch(book[i], &seq)
        }
    }
    print(n-seq.count)
}
BOJ_1818()
