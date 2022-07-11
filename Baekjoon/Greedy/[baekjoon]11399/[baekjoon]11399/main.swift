import Foundation

func BOJ_11399()
{
    let n    = Int(readLine()!)!
    var time = readLine()!.split(separator: " ").map{Int(String($0))!}
    var res  = 0 , answer = 0
    time.sort(by: <)
    time.forEach
    {
        res = res + $0
        answer += res
    }
    print(answer)
}
BOJ_11399()
