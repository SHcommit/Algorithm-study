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
    }
    seq.insert(target,at:right)
}
func BOJ_1472()
{
    
    var list = readLine()!.map{Int(String($0))!}
    var ans = [list[0]]
    for i in 1..<list.count
    {
        if list[i] < ans.last!
        {
            ans.append(list[i])
        }
        else
        {
            binarySearch(list[i], &ans)
        }
    }
    print(ans.reduce("", {
        first,sec in
        "\(first)\(sec)"}))
    print(ans.reduce("",{"\($0)\($1)"}))
}
BOJ_1472()
