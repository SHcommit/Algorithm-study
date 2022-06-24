import Foundation

/**
 * 이 클래스를 통해서 특정 location에 대한 텔레포트, 한칸 앞, 한칸 뒤 연산이 실행됩니다.
 * @param location : 현재 위치
 * @param teleport : 현재 위치 *=2
 * @param front      : 현재 위치 += 1
 * @param back      : 현재 위치 -= 1
 */
class move
{
    var location : Int
    var teleport : Int
    var front    : Int
    var back     : Int
    init(_ location : Int)
    {
        self.location = location
        teleport      = location * 2
        front         = location + 1
        back          = location - 1
    }
}
/**
 * 최초 수빈과 동생의 위치를 입력받는 함수입니다.
 */
class locationDTO
{
    var subin  : Int
    var sister : Int
    init()
    {
        if let input = readLine()
        {
            let subin_sister = input.split(separator: " ").map{Int($0)!}
            subin  = subin_sister[0]
            sister = subin_sister[1]
        }else
        {
            subin  = -1
            sister = -1
        }
    }
}
/**
 * 동생을 찾기위한 탐색(bfs)!! 이 일어나는 함수입니다.
 * @param queue   :  (특정 위치, 시간)
 * @param index    : 큐를 탐색하기 위한 index
 * @param visited   : 특정 위치 방문 기록
 * @param prevSec : 이전 시간 체크!
 *
 * queue에 저장된 시간에 따라서 현재시간이 아니라면 계속적으로 큐에서 원소를 찾아 수빈이가 이동합니다.
 * -> bfs를 구현하기 위해 시간 개념 도입!!
 *
 * 그리고 moved의 멤버변수들은 범위가 1~ 100,000 범위여야 합니다.
 * ㅠㅠ;; 범위 나오는거 항상 반례 생각안하고 무조건 제출했다가 항상틀리네요.
 * 꼼꼼해져야겠어요+_+
 */
func findSister(_ location : locationDTO, _ second : inout Int)
{
    
    var queue   = [(Int,Int)]()
    var index   = 0
    var visited = Array(repeating: false, count: 100001)
    var prevSec = 0
    visited[0]  = true
    queue.append((location.subin,second))
    visited[location.subin] = true
    
    while queue.count != index
    {
        let locate = queue[index].0
        let nSec   = queue[index].1
        index += 1
        var moved  = move(locate)
        if nSec == second { second += 1 }
        if moved.teleport == location.sister ||
            moved.back == location.sister ||
            moved.front == location.sister
        {
            return
        }
        if moved.teleport > 0 && moved.teleport < 100001
        {
            if !visited[moved.teleport]
            {
                queue.append((moved.teleport,nSec + 1))
                visited[moved.teleport] = true
            }
        }
        if moved.front > 0 && moved.front < 100001
        {
            if !visited[moved.front]
            {
                queue.append((moved.front, nSec + 1))
                visited[moved.front] = true
            }
        }
        if moved.back > 0 && moved.back < 100001
        {
            if !visited[moved.back]
            {
                queue.append((moved.back,nSec + 1))
                visited[moved.back] = true
            }
        }
    }
}
func BOJ_1609()
{
    let location = locationDTO()
    var second   = 0
    if location.sister == location.subin
    {
        print(0)
        return
    }
    findSister(location, &second)
    print(second)
}
BOJ_1609()
