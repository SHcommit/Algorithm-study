import Foundation
/**
 주의할 점
 2
 0 0
 이나
 3
 0 0 3
 같은 경우
 ans = 0.
 투 포인터 중에 탐색중인 index와 같은 숫자면 만들 수 없는 경우가 된다.
 */
func BOJ_1253()
{
    let n = Int(readLine()!)!
    let list = readLine()!.split(separator:" ").map{Int(String($0))!}.sorted()
    var ans = 0

    for i in 0..<n
    {
        var left = 0, right = n - 1 , sum = 0
        while left < right
        {
            sum = list[left] + list[right]
            if sum > list[i]
            {
                right -= 1
            }
            else if sum < list[i]
            {
                left += 1
            }else if sum == list[i]
            {
                if i != left && i != right
                {
                    ans += 1
                    break
                }
                else if i == right
                {
                    right -= 1
                }
                else
                {
                    left += 1
                }
            }
        }
    }
    print(ans)
}
BOJ_1253()
