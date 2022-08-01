import Foundation

func BOJ_1316()
{
    let n = Int(readLine()!)!
    var cnt = 0
    let (a,z) : (Character,Character) = ("a","z")
    var curString = "a"
    for _ in 0..<n
    {
        let str = readLine()!.map{String($0)}
        var check = Array(repeating: false, count: Int(z.asciiValue! - a.asciiValue!)+1)
        var isAns = true
        for char in str
        {
            var index = Int(exactly: Character(char).asciiValue! - a.asciiValue!)!
            if check[index] == false
            {
                curString = char
                check[index] = true
            }
            else if check[index]
            {
                if curString == char
                {
                    continue
                }
                else
                {
                    isAns = false
                    break
                }
            }
        }
        if isAns
        {
            cnt += 1
        }
    }
    print(cnt)
}
BOJ_1316()
