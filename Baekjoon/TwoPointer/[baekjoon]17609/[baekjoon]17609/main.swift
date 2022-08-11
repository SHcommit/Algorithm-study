import Foundation

func BOJ_17609()
{
    let n = Int(readLine()!)!
    var ans = ""
    for _ in 0..<n
    {
        let str = readLine()!.map{String($0)}
        var left = 0, right = str.count - 1 ,check = 0
        while left < right
        {
            if str[left] == str[right]
            {
                left  += 1
                right -= 1
            }
            else
            {
                var newLeft  = left + 1, newRight = right
                while(newLeft<newRight)
                {
                    if str[newLeft] != str[newRight]
                    {
                        check += 1
                        break
                    }
                    newLeft  += 1
                    newRight -= 1
                }
                newLeft  = left
                newRight = right - 1
                while(newLeft<=newRight)
                {
                    if str[newLeft] != str[newRight]
                    {
                        check += 1
                        break
                    }
                    newLeft += 1
                    newRight -= 1
                }
                if check == 0
                {
                    check += 1
                }
                break
            }
        }
        if ans == ""
        {
            ans += "\(check)"
        }
        else
        {
            ans += "\n\(check)"
        }
    }
    print(ans)
}
BOJ_17609()
