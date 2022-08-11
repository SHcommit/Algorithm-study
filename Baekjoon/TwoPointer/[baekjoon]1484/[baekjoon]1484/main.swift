import Foundation
/*
    G = 성원이가 놀랜 몸무게 차이
    cur = 현재 성원이가 측정한 몸무게
    think = 이전에 성원이가 기억 했었던 몸무게
 */
func BOJ_1484()
{
    let G        = Int(readLine()!)!
    var cur = 2, think = 1
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

