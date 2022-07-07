import Foundation
let direction = [1,2,3,4,5,6]
/**
 음..
 맵을 2차원 배열로 1~100까지 초기화를 했고,
 일단 사다리와 뱀 위치를 입력받으면 2차원배열에 맞게
 ((nNumber - 1) % 10, (nNumber - 1) / 10) 이런식으로 번환해주었다.
 이후 visited를 선언해서 방문한 지점을 체크해가며 문제를 풀었는데..
 생각보다 간단하게 코드를 구현한 분들이 많았다.ㅠㅠ
 */
func bfs(_ map : [[Int]])
{
    var visited = Array(repeating: false, count: 101)
    var queue   = [(0,0,0)]
    visited[1]  = true
    var index   = 0
    var curTime = 0
    while queue.count != index
    {
        let (curX,curY,time) = queue[index]
        index += 1
        if curTime == time
        {
            curTime += 1
        }
        for next in 1...6
        {
            let nNumber = map[curY][curX] + next
            if nNumber > 100
            {
                continue
            }
            if nNumber == 100
            {
                print(time + 1)
                return
            }
            if !visited[nNumber]
            {
                visited[nNumber] = true
                let (nx,ny) = ((nNumber - 1) % 10, (nNumber - 1) / 10)
                queue.append((nx,ny,time + 1))
            }
        }
    }
}

func BOJ_16928()
{
    var map  = Array(repeating: Array(repeating: 0, count: 10), count: 10)
    let nm   = readLine()!.split(separator: " ").map{Int(String($0))!}
    let n    = nm[0]
    let m    = nm[1]
    for y in 0..<10
    {
        for x in 0..<10
        {
            map[y][x] = y * 10 + x + 1
        }
    }
    for _ in 0..<n
    {
        let cur_up      = readLine()!.split(separator: " ").map{Int(String($0))!}
        let (curX,curY) = ((cur_up[0] - 1) % 10, (cur_up[0] - 1) / 10)
        map[curY][curX] = cur_up[1]
    }
    for _ in 0..<m
    {
        let cur_down      = readLine()!.split(separator: " ").map{Int(String($0))!}
        let (curX,curY) = ((cur_down[0] - 1) % 10, (cur_down[0] - 1) / 10)
        map[curY][curX]   = cur_down[1]
    }
    bfs(map)
}
BOJ_16928()
