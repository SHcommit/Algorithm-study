import Foundation
/**
    왜 에러나지? ...
 */
let ab = readLine()!.split{$0==" "}.map{Int(String($0))!}
let listA = readLine()!.split{$0==" "}.map{Int(String($0))!}
    let listB = readLine()!.split{$0==" "}.map{Int(String($0))!}
var left  = 0 , right = 0
var ans   = ""
while left < ab[0] && right < ab[1]
{
    if listA[left] > listB[right]
    {
        ans += "\(listB[right]) "
        right += 1
    }
    else
    {
        ans += "\(listA[left]) "
        left += 1
    }
}
//    if left == ab[0]
//    {
//        ans += listB[right..<ab[1]].reduce(""){"\($0)\($1) "}
//    }
//    else
//    {
//        ans += listA[right..<ab[0]].reduce(""){"\($0)\($1) "}
//    }

while left < ab[0]
{
    ans += "\(listA[left]) "
    left += 1
}
while right < ab[1]
{
    ans += "\(listB[right]) "
    right += 1
}
print(ans)
