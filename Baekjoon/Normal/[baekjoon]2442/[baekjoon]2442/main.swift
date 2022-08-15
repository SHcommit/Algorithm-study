import Foundation
/**
    이문제는 코드뒤에 공백이 없어야 한다.
 */
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
        print((star[0...(right-1)]).reduce(""){"\($0)\($1)"})
    }
}
BOJ_2442()
