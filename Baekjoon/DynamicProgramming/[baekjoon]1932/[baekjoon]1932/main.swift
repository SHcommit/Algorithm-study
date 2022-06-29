import Foundation

func BOJ_1932()
{
    let n    = Int(readLine()!)!
    var list = Array(repeating: [Int](), count: n)
    for i in 0..<n
    {
        list[i] = readLine()!.split(separator: " ").map{Int(String($0))!}
    }
    for i in 1..<n
    {
        for j in 0..<i+1
        {
            if j == 0
            {
                list[i][j] += list[i-1][j]
            }
            else if j == i
            {
                list[i][j]+=list[i-1][j-1]
            }else
            {
                list[i][j]+=max(list[i-1][j],list[i-1][j-1])
            }
        }
    }
    print(list[n-1].max()!)
}
BOJ_1932()
