import Foundation

func BOJ_5597()
{
    var list = Array(repeating: false, count: 31)
    for _ in 0..<28
    {
        list[Int(readLine()!)!] = true
    }
    for i in 1...30
    {
        if !list[i]
        {
            print(i)
        }
    }
    
}
BOJ_5597()
