import Foundation

func BOJ_2441()
{
    let n = Int(readLine()!)!
    var star = Array(repeating: "*", count: n)
    for i in stride(from:n,to:0,by:-1)
    {
        if i < n && i > 0
        {
            let idx = n - i - 1
            star[idx] = " "
        }
    
        print(star.reduce(""){"\($0)\($1)"})
    }
}
BOJ_2441()
