import Foundation

func BOJ_1149()
{
    var n   = Int(readLine()!)!
    var arr = Array(repeating: [Int](), count: n + 1)
    for i in 1...n
    {
        arr[i] = readLine()!.split(separator: " ").map{Int($0)!}
    }
    if n == 2
    {
        arr[n][0] += arr[n-1][1]
        arr[n][1] += arr[n-1][0]
        print(arr[n][0] < arr[n][1] ? arr[n][0] : arr[n][1])
        return
    }
    for i in 2...n
    {
        arr[i][0] += arr[i - 1][1] < arr[i - 1][2] ? arr[i - 1][1] : arr[i - 1][2]
        arr[i][1] += arr[i - 1][2] < arr[i - 1][0] ? arr[i - 1][2] : arr[i - 1][0]
        arr[i][2] += arr[i - 1][0] < arr[i - 1][1] ? arr[i - 1][0] : arr[i - 1][1]
    }
    var min = arr[n][0]
    min = min < arr[n][1] ? min : arr[n][1]
    min = min < arr[n][2] ? min : arr[n][2]
    print(min)
}
BOJ_1149()
