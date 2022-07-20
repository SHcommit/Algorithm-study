import Foundation
typealias Element = (left: Int,right: Int)

func BOJ_2565()
{
    let n        = Int(readLine()!)!
    var line     = [Element]()
    var length   = Array(repeating:1, count: n)
    
    for _ in 0..<n
    {
        let input = readLine()!.split(separator:" ").map{Int(String($0))!}
        line.append((input[0],input[1]))
    }
    line.sort
    {
        if $0.left < $1.left
        {
            return true
        }
        return false
    }
    for i in 0..<n
    {
        for j in 0..<i
        {
            if line[j].right < line[i].right
            {
                length[i] = max(length[i],length[j] + 1)
            }
        }
    }
    print(n - length.sorted()[n-1])
}
BOJ_2565()
