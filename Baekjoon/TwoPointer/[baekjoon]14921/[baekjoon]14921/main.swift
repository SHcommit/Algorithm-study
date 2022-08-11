import Foundation

func BOJ_14921()
{
    let n    = Int(readLine()!)!
    let list = readLine()!.split(separator:" ").map{Int(String($0))!}.sorted()
    var left = 0 , right = list.count - 1
    var ans  = 200_000_001
    //한 용액을 두번 쓸 수 없으니까
    while left < right
    {
        let sum = list[left]+list[right]
        if sum < 0
        {
            left += 1
        }
        else
        {
            right -= 1
        }
        if abs(ans) > abs(sum)
        {
            ans = sum
        }
    }
    print(ans)
}
BOJ_14921()

