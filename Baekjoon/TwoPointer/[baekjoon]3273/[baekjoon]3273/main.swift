import Foundation

func BOJ_3273()
{
    let n    = Int(readLine()!)!
    let list = readLine()!.split(separator:" ").map{Int(String($0))!}.sorted(by: <)
    let x    = Int(readLine()!)!
    var sum  = 0 ,cnt = 0, left = 0, right = list.count - 1 
    while left < right
    {
        sum = list[left]+list[right]
        if sum >= x
        {
            if sum == x
            {
                cnt += 1
            }
            right -= 1
        }
        else
        {
            left += 1
        }
    }
    print(cnt)
}
BOJ_3273()
