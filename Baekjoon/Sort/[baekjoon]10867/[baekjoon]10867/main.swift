import Foundation

func BOJ_10867()
{
    let n = Int(readLine()!)!
    var list = readLine()!.split(separator:" ").map{Int(String($0))!}
    list.sort()
    var ans = [list[0]]
    list.forEach
    {
        if $0 != ans.last!
        {
            ans.append($0)
        }
    }   
    print(ans.reduce(""){"\($0)\($1) "})
}
BOJ_10867()
