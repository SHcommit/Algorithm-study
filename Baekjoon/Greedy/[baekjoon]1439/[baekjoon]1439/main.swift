import Foundation

func BOJ_1439()
{
    let num = readLine()!.map{String($0)}
    var ans = 0
    var prevNum = num[0]
    num.forEach()
    {
        if prevNum != $0
        {
            if prevNum == num[0]
            {
                prevNum = $0
                ans += 1
            }
            else
            {
                prevNum = $0
            }
        }
        
    }
    print(ans)
}
BOJ_1439()
