import Foundation

func BOJ_1484()
{
    let G        = Int(readLine()!)!
    var isAnswer = true , cur = 2, think = 1
    var ans      = ""
    while think < cur
    {
        let diff = cur*cur - think*think
        if diff < G
        {
            cur += 1
        }
        else
        {
            think  += 1
            if diff == G
            {
                if ans == ""
                {
                    ans += "\(cur)"
                }
                else
                {
                    ans += "\n\(cur)"
                }
            }
        }
    }
    print(ans.isEmpty == true ? "-1" : ans)
}
BOJ_1484()

