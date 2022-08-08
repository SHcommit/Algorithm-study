//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-14719-%EB%B9%97%EB%AC%BC-%EB%AC%B8%EC%A0%9C-%EB%BF%8C%EC%88%98%EA%B8%B0-2%EA%B0%9C-%EB%B0%98%EB%A1%80-%ED%8F%AC%ED%95%A8
import Foundation

func BOJ_14719()
{
    let hw = readLine()!.split(separator:" ").map{Int(String($0))!}
    let block = readLine()!.split(separator:" ").map{Int(String($0))!}
    
    let (height,width) = (hw[0],hw[1])
    var sum = 0 ,ans = 0
    var left = 0 ,right = 0
    /*
     처음에는 둘러 쌓일 맨 왼쪽 블록이 맨 오른쪽 블록과 같거나 큰 블록이 존재한다는 가정하에
     맨 왼쪽 블록 높이를 기준으로 고인 물을 탐색해 나간다.
     그러다 정말 발견하면 둘러쌓여있는 형태이므로 지금까지 구한 sum을 ans에 더하고 다시 둘러 쌓일 맨 왼쪽 블록의 높이를 둘러 쌓인 맨 오른쪽 블록 높이로 지정하고 위와 같은 연산을 반복.
     */
    for i in 0..<width
    {
        if block[left] > block[i]
        {
            sum += block[left] - block[i]
        }
        else if block[left] <= block[i]
        {
            ans += sum
            sum = 0
            left = i
        }
    }
    right = width - 1
    //만약 위에서 한 가정이 거짓인,, 둘러쌓일 맨 오른쪽 블록 높이가 맨 왼쪽 블록 높이보다 낮다면!!
    //꺼꾸로 탐색을 이어나간다..
    while(left < right)
    {
        for i in stride(from:right,through: left, by: -1)
        {
            if block[right] <= block[i]
            {
                right = i
            }
            else
            {
                ans += block[right] - block[i]
            }
        }
    }
    print(ans)
}
BOJ_14719()
