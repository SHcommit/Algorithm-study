import Foundation

func BOJ_2440()
{
    for i in stride(from:Int(readLine()!)!,through:1,by : -1)
    {
        var sum = ""
        for _ in 0..<i
        {
            sum += "*"
        }
        print(sum)
    }
}
BOJ_2440()
