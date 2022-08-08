import Foundation

func BOJ_3273()
{
    let n    = Int(readLine()!)!
    let list = readLine()!.split(separator:" ").map{Int(String($0))!}.sorted(by: <)
    let x    = Int(readLine()!)!
    var sum  = 0 ,cnt = 0
    for left in 0..<n
    {
        var right = left + 1
        while sum<x && right < n
        {
            sum = list[left] + list[right]
            right += 1
        }
        if sum == x
        {
            cnt += 1
        }
    }
    print(cnt)
}
BOJ_3273()
