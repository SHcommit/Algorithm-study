import Foundation

func BOJ_2442()
{
    let n    = Int(readLine()!)!
    var star = Array(repeating: " ", count: n*2 - 1)
    var left = n-1, right = n-1
    for _ in 0..<n
    {
        if left == right
        {
            star[left] = "*"
            left  -= 1
            right += 1
        }
        else
        {
            star[left]  = "*"
            star[right] = "*"
            left  -= 1
            right += 1
        }
        var flag = false
        var ans = ""
        for i in 0..<(n*2 - 1)
        {
            if flag && star[i] != "*"
            {
                break
            }
            if star[i] == "*"
            {
                flag = true
            }
            ans += star[i]
            
        }
        print(ans)
    }
}
BOJ_2442()

