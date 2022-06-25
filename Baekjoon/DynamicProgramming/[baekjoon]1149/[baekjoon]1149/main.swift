import Foundation

func BOJ_1149()
{
    var n   = Int(readLine()!)!
    var arr = Array(repeating: [Int](), count: n + 1)
    for i in 1...n
    {
        arr[i] = readLine()!.split(separator: " ").map{Int($0)!}
    }
    for i in 2...n
    {
        arr[i][0] += min(arr[i-1][1],arr[i - 1][2])
        arr[i][1] += min(arr[i-1][2], arr[i - 1][0])
        arr[i][2] += min(arr[i-1][0],arr[i-1][1])
    }
    print(arr[n].min()!)
}
BOJ_1149()
