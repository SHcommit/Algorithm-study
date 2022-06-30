import Foundation
func BOJ_13549()
{
    let input   = readLine()!.split(separator: " ").map{Int(String($0))!}
    let start   = input[0]
    let finish  = input[1]
    var queue   = [(start,0)]
    var visited = Array(repeating: false, count: 100001)
    while(!queue.isEmpty)
    {
        let (curPoint,time) = queue.removeFirst()
        if curPoint == finish
        {
            print(time)
            break
        }

        if curPoint * 2 <= 100000 && !visited[curPoint * 2]
        {
            visited[curPoint*2] = true
            queue.append((curPoint*2,time))
        }
        if  curPoint - 1 >= 0 && !visited[ curPoint - 1]
        {
            queue.append((curPoint - 1, time + 1))
            visited[curPoint - 1] = true
        }
        if curPoint + 1 <= 100000 && !visited[curPoint + 1]
        {
            queue.append((curPoint + 1, time + 1))
            visited[curPoint + 1] = true
        }
        
    }
}
BOJ_13549()
