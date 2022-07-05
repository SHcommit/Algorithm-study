/*
    https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-18405-%EA%B2%BD%EC%9F%81%EC%A0%81-%EC%A0%84%EC%97%BC
 */

import Foundation

// 탐색할 x좌표, y좌표, 탐색 당시의 시간 저장
typealias Element = (x: Int, y: Int, prevTime : Int)

// 탐색할 방향 [(왼쪽)(오른쪽)(위)(아래)]
let direction     = [(-1,0),(1,0),(0,1),(0,-1)]

/**
 * 특정 virus가 위치한 좌표를 저장할 Q입니다.
 * index를 통해 queue를 탐색해 나갑니다.
 */
class Q
{
    var queue : [Element]
    var index : Int
    init()
    {
        queue = [Element]()
        index = 0
    }
}

/**
 * 초기 바이러스 탐색하는 함수
 * **주의**
 * 이때 특정 바이러스는 1개 이상 존재할 수 있습니다.
 * 이때 구성된 q는 특정한 한개의 바이러스에 대한 좌표 들을 저장하는 큐이므로
 * 추후 qList( 큐 들을 저장하는 배열) 에 저장되어 관리됩니다.
 */
func initialVirus(_ n : Int, _ virus : Int,_ q : inout Q, _ map: [[Int]])
{
    for y in 0..<n
    {
        for x in 0..<n
        {
            if map[y][x] == virus
            {
                q.queue.append((x,y,0))
            }
        }
    }
}

/**
 * qList의 특정한 바이러스
 * 예를들어 바이러스 종류 == 2 이면 qList[1]의 Q클래스는 바이러스 번호 2인 바이러스 좌표들을 갖고 있는데
 *  이 특정 바이러스(예를들어 바이러스 번호 2라 가정했을때)를 담는 queue = qList[1] 이 대입됩니다.
 *
 * 따라서 이 함수는 특정 바이러스 번호의 좌표를 가지고 탐색 시간이 특정한 초 이전에만 탐색되도록 하는 bfs함수입니다.
 */
func bfs(_ n : Int, _ time : inout Int, _ virus : Int, _ s : Int, _ sPoint : (Int,Int), _ map : inout [[Int]], queue : inout Q)
{
    while queue.queue.count != queue.index
    {
        let (curX,curY,prevTime) = queue.queue[queue.index]
        if prevTime == time
        {
            return
        }
        queue.index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX+dx,curY+dy)
            if nx < 0 || nx > n - 1 || ny < 0 || ny > n - 1 { continue }
            if map[ny][nx] == 0
            {
                map[ny][nx] = map[curY][curX]
                
                queue.queue.append((nx,ny,prevTime + 1))
            }
        }
    }
}

/**
 * @param time : 현재 시간
 *      이 시간을 기준으로 bfs()함수가 작업됩니다.
 */
func spreadVirus(_ n : Int, _ kind : Int,_ s : Int,_ sPoint : (Int,Int), _ map : inout [[Int]], _ qList : inout [Q])
{
    var time = 0
    while true
    {
        if time == s + 1
        {
            if map[sPoint.0][sPoint.1] == 0
            {
                print(0)
                return
            }else
            {
                print(map[sPoint.0][sPoint.1])
                return
            }
        }
        //바이러스 종류는 1~ K개 까지 반드시 존재하기 때문에 포문을 통해 bfs탐색을 하고 시간을 증가시킵니다.
        for virus in 0..<kind
        {
            bfs(n, &time, virus + 1, s, sPoint, &map, queue: &qList[virus])
        }
        time += 1
    }
}
/**
 * @param kind    : 바이러스 종류 개수
 * @param map    : 시험관
 * @param qList   : 특정 바이러스의 좌표를 담은 Q클래스의 배열
 * @param s         : 특정 시간
 * @param sPoint : 특정 시간에서 원하는 좌표
 */
func BOJ_18405()
{
    let input = readLine()!.split(separator: " ").map{Int(String($0))!}
    let n     = input[0]
    let kind  = input[1]
    var map   = Array(repeating: [Int](), count: n)
    var qList = Array(repeating: Q(), count: kind)
    for y in 0..<n
    {
        map[y] = readLine()!.split(separator: " ").map{Int(String($0))!}
    }
    let sxy    = readLine()!.split(separator: " ").map{Int(String($0))!}
    let s      = sxy[0]
    let sPoint = (sxy[1] - 1,sxy[2] - 1)
    for virus in 0..<kind
    {
        var queue = Q()
        initialVirus(n, virus + 1, &queue, map)
        qList[virus] = queue
    }
    spreadVirus(n, kind,s,sPoint, &map, &qList)
}
BOJ_18405()
