import Foundation

func bfs(_ n: Int)
{
    // n : 탐색할 숫자, "\(n) " 연산처리된 숫자, 0 : 누적 연산 횟수
    var queue = [(n,"\(n) ",0)]
    // queue에 저장될 숫자를 중복 방문하지 않게 하기 위한 visited 체크
    var visited = Array(repeating: false , count : n+1)
    visited[n] = true
    var index = 0
    //연산 횟수 측정하기 위한 변수
    var curCnt = 0
    while index != queue.count
    {
        let (num,ans,count) = queue[index]
        if num == 1
        {
            print(count)
            print(ans)
            return
        }
        if curCnt == count
        {
            curCnt += 1
        }
        index += 1
        if num % 3 == 0 && num / 3 >= 1 && !visited[num/3]
        {
            visited[num/3] = true
            queue.append((num/3,ans+"\(num/3) ",count+1))
        }
        if num % 2 == 0 && num / 2 >= 1 && !visited[num/2]
        {
            visited[num/2] = true
            queue.append((num/2,ans+"\(num/2) ",count+1))
        }
        if num-1 >= 1 && !visited[num-1]
        {
            visited[num-1] = true
            queue.append((num-1,ans+"\(num-1) ",count+1))
        }
    }
}
func BOJ_12852()
{
    let n = Int(readLine()!)!
    bfs(n)
}
BOJ_12852()
