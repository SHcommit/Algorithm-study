import Foundation

func BOJ_1912()
{
    let n = Int(readLine()!)!
    var list =
    {
        return readLine()!.split(separator: " ").map{Int(String($0))!}
    }()
    for i in 1..<n
    {
        if list[i] < 0
        {
            if list[i-1] + list[i] > list[i] && list[i - 1] + list[i] > 0
            {
                list[i] += list[i-1]
            }
        }
        else if list[i-1] > 0
        {
            list[i] += list[i-1]
        }
    }
    print(list.max()!)
}
BOJ_1912()
