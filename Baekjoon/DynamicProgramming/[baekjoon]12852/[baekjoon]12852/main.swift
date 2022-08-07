import Foundation

func bfs(_ n: Int)
{
    var queue = [(n,"\(n) ",0)]
    var visited = Array(repeating: false , count : n+1)
    visited[n] = true
    var index = 0
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
