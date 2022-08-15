
import Foundation
/*
 오.. upperBound
 */
func BOJ_1543()
{
    var doc    = readLine()!
    let target = readLine()!
    var index  = doc.range(of: target)?.upperBound
    var cnt    = 0

    while index != nil
    {
        cnt += 1
        doc = String(doc[index!...])
        index = doc.range(of: target)?.upperBound
    }
    print(cnt)
}
BOJ_1543()
