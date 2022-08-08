import Foundation
/*
 문제 풀 때 초기 sum값 주의.
 https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-2470-%EB%91%90-%EC%9A%A9%EC%95%A1-%EB%AC%B8%EC%A0%9C-%EB%BF%8C%EC%88%98%EA%B8%B0
 */
func BOJ_2470()
{
    let n = Int(readLine()!)!
    var list = readLine()!.split(separator:" ").map{Int(String($0))!}
    list.sort(by: <)
    
    // 투 포인터
    var left = 0 , right = list.count - 1
    var sum  = 2000000001
    
    //(sum과 left, right 인덱스 저장)
    var ans  : (sum:Int,l:Int,r:Int) = (sum,left,right)
    while left<right
    {
        sum = list[left]+list[right]
        if sum > 0
        {
            if ans.sum > sum
            {
                ans = (sum,left,right)
            }
            right -= 1
        }
        else if sum < 0
        {
            if ans.sum > abs(sum)
            {
                ans = (abs(sum),left,right)
            }
            left += 1
        }
        else
        {
            print("\(list[left]) \(list[right])")
            return
        }
    }
    print("\(list[ans.l]) \(list[ans.r])")
}
BOJ_2470()

