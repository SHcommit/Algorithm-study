import Foundation

typealias qElement = (Int,Int)
typealias vElement = [[Bool]]

let direction = [(-1,0),(1,0),(0,1),(0,-1)]

class mapInfo
{
    var width  : Int
    var height : Int
    var map    : [[Int]]
    init()
    {
        let n  = Int(readLine()!)!
        width  = n
        height = n
        map    = Array(repeating: [Int](), count: height)
        for i in 0..<height
        {
            map[i] = readLine()!.split(separator: " ").map{Int(String($0))!}
        }
        
    }
}
class Q
{
    var queue : [qElement]
    var index : Int
    init()
    {
        queue = [(qElement)]()
        index = 0
    }
}
/**
 * 그냥 bfs 탐색입니다.
 * @param q                : 섬 < 1 > 을 탐색하기 위해서 선언된 큐
 * @param detectedQ : 섬과 인접하면서 0인 지점을 저장하는 큐입니다. 추후 이 detectedQ를 needDetectedQueue에 저장하면서 섬 바깥 좌표들을 첫번째 다리로 놓으면서
 *                 최소 다리 연결 개수를 찾아가는 findBridge 함수에 꼭 있어야 할 큐입니다.
 *  여기서 initialaDetected는 모든 섬의 정보를 체크함으로 메인 문장의 완전 탐색구간에서 딱 n가지의 섬만 needDetectedQueue에 저장할 수 있도록 도와줍니다.
 * 이 함수의 매개변수 point는 섬의 최초로 발 이 닿은 좌표입니다. 이 좌표를 기준으로 특정한 섬의 위치를 bfs탐색을 통해 파악해 갑니다.
 * 이때 특정한 point에 대해서 탐색된 특정한 섬의 모양? 정보들은 visited에 저장됩니다.
 * 함수 다 끝나면 needDetectedQueue 에 저장.
 */
func bfs(_ point : qElement, _ m : inout mapInfo, _ visited : inout [[Bool]],_ initialDetected : inout [[Bool]], needDetectedQueue nDQ : inout [Q])
{
    let q         = Q()
    let detectQ   = Q()
    q.queue.append((point.0,point.1))
    while q.queue.count != q.index
    {
        let (curX,curY) = q.queue[q.index]
        q.index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX + dx, curY + dy)
            if nx < 0 || nx > m.width - 1 || ny < 0 || ny > m.height - 1
            {
                continue
            }
            if !visited[ny][nx] && m.map[ny][nx] == 1
            {
                initialDetected[ny][nx] = true
                visited[ny][nx]       = true
                q.queue.append((nx,ny))
            }
            else if !visited[ny][nx] && m.map[ny][nx] == 0 && m.map[curY][curX] == 1
            {
                visited[ny][nx] = true
                detectQ.queue.append((nx,ny))
            }
        }
    }
    nDQ.append(detectQ)
}

/**
 * 주어진 최소 연결 선과
 * 특정한 nDQIndex에 따른 특정한 섬의 방문, 맵 정보를 바탕으로
 * minBridgeCount 보다 크거나 같으면 함수 종료.
 * 작은 경우를 찾는 함수입니다.
 *
 */
func findBridge(_ minBridgeCount : inout Int,_ visited : [[Bool]], _ m : mapInfo, q : Q)
{
    var tempMap = m.map
    while q.queue.count != q.index
    {
        let (curX,curY) = q.queue[q.index]
        if tempMap[curY][curX] == 0
        {
            tempMap[curY][curX] += 1
        }
        q.index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX + dx, curY + dy)
            if nx < 0 || nx > m.width - 1 || ny < 0 || ny > m.height - 1
            {
                continue
            }
            if !visited[ny][nx] && tempMap[ny][nx] == 1
            {
                if minBridgeCount > tempMap[ny][nx]
                {
                    minBridgeCount = tempMap[curY][curX]
                    return
                }
            }
            else if !visited[ny][nx] && tempMap[ny][nx] == 0
            {
                tempMap[ny][nx] = tempMap[curY][curX] + 1
                q.queue.append((nx,ny))
            }
            if minBridgeCount != 9999 && tempMap[ny][nx] > minBridgeCount
            {
                return
            }
        }
    }
}

/**
 * @param : m                = 맵의 정보가 담겨있습니다.
 * @param : visited         = 첫번째 ~ n번째 섬만 방문체크 하기 위한 Bool 타입의 배열입니다.
 * @param : tempVisited = 각 섬에 방문한 Bool 타입을 visited 배열에 저장하기 위해 임시적으로 만든 Bool  타입의 배열입니다.
 *                  ( 한번의 bfs(섬 탐색) 가 끝나면 visited에 tempVisited에 넣고 다시 false로 초기화합니다.)
 *                  bfs에 의해 방문 할 섬 정보만 체크합니다
 * @param : needDetectedQueue = 이것은 이제 bfs탐색을 통해 섬 주위에 인접한 0을 탐색 리스트로 정합니다. 각 섬마다 섬 주위의 0 좌표가 달라서 이렇게 배열로 선언했습니다.
 *                         (visited 배열과 needDetectedQueue 배열은 한쌍이라고 보시면 됩니다)
 * @param : nDQIndex                  = 이건 이제 각 섬마다 needDetectedQueue (탐색해야 할 바다) , visited( 섬의 정보를 갖고 있음 ) 탐색하기 위해서 선언된 index 입니다.
 * @param : minBridgeCount        = 최소 탐색 횟수를 저장합니다.
 * @param : firstDetected              = 이건 특정 한 섬만 저장하는 tempVisited와 달리 전체적으로 섬의 총 위치를 저장합니다. 이걸 통해서 처음에 맵의 완전탐색을 했을 때
 *                          needDetectedQueue가 딱 n개의 섬 정보만 저장 할 수 있습니다.
 */
func BOJ_2146()
{
    var m                 = mapInfo()
    var visited           = [vElement]()
    var tempVisited       = Array(repeating: Array(repeating: false, count: m.width), count: m.height)
    var needDetectedQueue = [Q]()
    var nDQIndex          = 0
    var minBridgeCount    = 9999
    var initialDetected   = tempVisited
    for y in 0..<m.height
    {
        for x in 0..<m.width
        {
            if m.map[y][x] == 1 && !initialDetected[y][x]
            {
                initialDetected[y][x] = true
                tempVisited[y][x]   = true
                bfs((x,y), &m, &tempVisited, &initialDetected,needDetectedQueue: &needDetectedQueue)
                visited.append(tempVisited)
                tempVisited = Array(repeating: Array(repeating: false, count: m.width), count: m.height)
            }
        }
    }
    while(needDetectedQueue.count != nDQIndex)
    {
        findBridge(&minBridgeCount, visited[nDQIndex], m, q: needDetectedQueue[nDQIndex])
        nDQIndex += 1
    }
    print(minBridgeCount)
}
BOJ_2146()
