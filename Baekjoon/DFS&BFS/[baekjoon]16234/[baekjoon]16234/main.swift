import Foundation

//x,y 좌표
typealias Element = (Int,Int)

//탐색 방향
let direction     = [(-1,0),(1,0),(0,1),(0,-1)]

/**
 * @param queue     : '연합'에 속한 나라들의 좌표가 저장됨
 * @param index       : queue를 탐색하기 위한 index (재사용 good)
 * @param totalSum : 연합에 속한 나라들을 탐색해 갈때 즉시 totalSum으로 연합 에 포함되는 인구수 다 더함.
 *                  추후 queue.count를 통해 연합 국가 개수 파악 가능!!
 */
class Q
{
    var queue    : [Element]
    var index    : Int
    var totalSum : Int
    init()
    {
        queue    = [Element]()
        index    = 0
        totalSum = 0
    }
}

/**
 * N x N 땅의 정보가 들어있습니다.
 *
 * @param n               : 나라 크기
 * @param minMove  : L조건 최소 이동 가능한 인구수
 * @param maxMove : R조건 최대 이동 가능한 인구수
 * @param map          : 나라들 인구수 있음
 */
class mapInfo
{
    let n       : Int
    let minMove : Int
    let maxMove : Int
    var map     : [[Int]]
    init()
    {
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        n       = input[0]
        minMove = input[1]
        maxMove = input[2]
        map     = Array(repeating: [Int](), count: n)
        for i in 0..<n
        {
            map[i] = readLine()!.split(separator: " ").map{Int(String($0))!}
        }
    }
}

/**
 * 아래 메인 문장에서 연합국가의 조건이 된다면 bfs탐색을 통해 q에 연합 국가 좌표들 모두 저장
 * visited 를 통해 q에 중복되는 나라 좌표는 있을 수가 없음
 * 또한 q의 totalSum에 방문되는 연합 국가 인구수를 모조리 더함!!
 */
func bfs(_ land : mapInfo, _ visited : inout [[Bool]], _ q : inout Q)
{
    let (x,y) = q.queue[q.index]
    q.totalSum += land.map[y][x]
    
    while(q.queue.count != q.index)
    {
        let (curX,curY) = q.queue[q.index]
        q.index += 1
        for (dx,dy) in direction
        {
            let (nx,ny) = (curX + dx, curY + dy)
            if nx < 0 || nx > land.n - 1 || ny < 0 || ny > land.n - 1
            {
                continue
            }
            if !visited[ny][nx]
            {
                let rc = abs(land.map[ny][nx] - land.map[curY][curX])
                if rc >= land.minMove && rc <= land.maxMove
                {
                    q.totalSum += land.map[ny][nx]
                    
                    visited[ny][nx] = true
                    q.queue.append((nx,ny))
                }
            }
        }
    }
}
/**
 * @param land         : 국가 인구수들 저장됨
 * @param day          : 날
 * @param canMove : 국가들 간 연합 조건에 부합되는 국가가 있는가? 있다면 true
 */
func BOJ_16234()
{
    var land = mapInfo()
    var day  = 0
    var canMove = true
    /**
     * while문 시작하자마자 canMove를 false 함으로 나라들 모두 탐색했을 때 canMove = true가 되지 않으면
     * 인구이동 할 연합국가가 없는것으로 간주. 종료됨.
     *
     * 매번 queueList를 초기화 해주는데 이때마다 새로 연합국가가되는 나라들의 좌표들을 갖는 n개의 연합 들이 저장됨
     */
    while canMove
    {
        var visited   = Array(repeating: Array(repeating: false, count: land.n), count: land.n)
        var queueList = [Q]()
        canMove       = false
        for y in 0..<land.n
        {
            for x in 0..<land.n
            {
                if !visited[y][x]
                {
                    var queue = Q()
                    //이 flag는 연합국가가 있다면? true로 하고 나중에 queueList에 bfs로 연합국가를 탐색한 후에 queue를 집어 넣기 위한 변수
                    var flag  = false
                    for (dx,dy) in direction
                    {
                        let (nx,ny) = (x + dx, y + dy)
                        if nx < 0 || nx > land.n - 1 || ny < 0 || ny > land.n - 1
                        {
                            continue
                        }
                        let rc = abs(land.map[ny][nx] - land.map[y][x])
                        if rc >= land.minMove && rc <= land.maxMove
                        {
                            flag      = true
                            canMove   = true
                            visited[y][x] = true
                            queue.queue.append((x,y))
                            bfs(land, &visited, &queue)
                            break
                        }
                    }
                    if flag == true
                    {
                        queueList.append(queue)
                    }
                }
            }
        }
        /**
         * 만약 canMove가 true면 연합국가가 존재하는 것이므로
         * 연합국가의 평균값을 land.map에 새로 할당!!
         */
        if canMove
        {
            day += 1
            for i in 0..<queueList.count
            {
                queueList[i].totalSum = queueList[i].totalSum/queueList[i].queue.count
                queueList[i].index = 0
                while queueList[i].queue.count != queueList[i].index
                {
                    let (curX,curY) = queueList[i].queue[queueList[i].index]
                    queueList[i].index += 1
                    land.map[curY][curX] = queueList[i].totalSum
                }
            }
        }
    }
    print(day)
}
BOJ_16234()
