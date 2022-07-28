/*
 엇ㅋㅋ 맨 처음 코드길이가 엄청 짧았는데
 1000 입력을 했을 때 cpu 소모량이 40%가 됬다.. 뭐지 엄청 작은 숫잔데
 알고보니 방문처리를 하지않아 중복으로 큐에 넣어 졌나보다. ㅋㅋ./.
 */
import Foundation
func BOJ_14226()
{
    let n       = Int(readLine()!)!
    var queue   = [(1,0,0)] , index = 0 , time = 0
    var visited = Array(repeating: Array(repeating: false, count: 1001), count: 1001)
    visited[1][0]  = true
    while(queue.count != index)
    {
        let (curEmoji,curClip,curTime) = queue[index]
        index += 1
        if curTime == time
        {
            time += 1
        }
        if curEmoji == n
        {
            break
        }
        if curEmoji <= 0 || curEmoji >= 1001 || curClip <= -1 || curClip >= 1001
        {
            continue
        }
        if !visited[curEmoji][curEmoji]
        {
            
            queue.append((curEmoji,curEmoji,curTime + 1))
            visited[curEmoji][curEmoji] = true
        }
        if curEmoji + curClip <= 1000 && !visited[curEmoji+curClip][curClip]
        {
            queue.append((curEmoji+curClip,curClip,curTime + 1))
            visited[curEmoji+curClip][curClip] = true
        }
        
        if !visited[curEmoji-1][curClip]
        {
            queue.append((curEmoji-1,curClip,curTime + 1))
            visited[curEmoji-1][curClip] = true
        }
    }
    print(time - 1)
}
BOJ_14226()
