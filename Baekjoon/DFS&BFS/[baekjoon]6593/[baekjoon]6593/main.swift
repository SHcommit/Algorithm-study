import Foundation

// 설명 : https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-6593-%EC%83%81%EB%B2%94-%EB%B9%8C%EB%94%A9

/**
 * @param Element  : 현재 탐색중인 x지점, y지점, 층 저장
 * @param direction : 좌,우,상,하,아래,위 탐색하는 next좌표 구하기 전 direction입니다.
 */
typealias Element = (x: Int, y : Int, floor : Int)
let direction     = [(-1,0,0),(1,0,0),(0,1,0),(0,-1,0),(0,0,-1),(0,0,1)]

/**
 * 빌딩의 주요 정보가 들어있습니다.
 * @param width  : 특정 층 빌딩 가로
 * @param height : 특정 층 빌딩 세로
 * @param floor    : 빌딩 전체 층 수
 */
class mapInfo
{
    let width     : Int
    let height    : Int
    let floor     : Int
    init()
    {
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        floor     = input[0]
        height    = input[1]
        width     = input[2]
    }
}

/**
 * 상범이의 탈출 과정!
 * 중간에 return하지못할 경우 Trapped!
 *
 * @param queue : 탐색 가능한 좌표 저장
 * @param index  : queue탐색하기 위한 index
 *
 * 탐색 지점이 "E"인 경우 현재 분 저장 후 return
 */
func escape(_ info : mapInfo, _ start : Element, _ end : Element, _ res : inout String, _ building : [[[String]]], _ visited : inout [[[Int]]])
{
    var queue    = [Element]()
    var index    = 0
    queue.append(start)
    visited[start.floor][start.y][start.x] = 1
    while(queue.count != index)
    {
        let (curX,curY,curFloor) = queue[index]
        index += 1
        for (dx,dy,dFloor) in direction
        {
            let (nx,ny,nFloor) = (curX+dx, curY+dy, curFloor+dFloor)
            if nx < 0 || nx > info.width - 1 || ny < 0 || ny > info.height - 1 || nFloor < 0 || nFloor > info.floor - 1
            {
                continue
            }
            if building[nFloor][ny][nx] == "E"
            {
                res += "Escaped in \(visited[curFloor][curY][curX]) minute(s).\n"
                return
            }
            if visited[nFloor][ny][nx] == 0 && building[nFloor][ny][nx] == "."
            {
                visited[nFloor][ny][nx] = visited[curFloor][curY][curX] + 1
                queue.append((nx,ny,nFloor))
            }
        }
    }
    res += "Trapped!\n"
}

/**
 * @param res : 결과 저장
 */
func BOJ_6593()
{
    var res       = ""
    
    /**
     * @param info        : 맵 정보
     * @param building : 빌딩 정보
     * @param visited   : bfs 탐색을 통해 탐색중인 x분 갱신
     * @param start       : 상범이 시작 위치 (x , y , i 층)
     * @param end        : 상범이 도착 위치 (x , y , i 층)
     */
    while true
    {
        let info = mapInfo()
        var building = Array(repeating: [[String]](), count: info.floor)
        var visited  = Array(repeating: Array(repeating: Array(repeating: 0, count: info.width), count: info.height), count: info.floor)
        var start    = (0,0,0)
        var finish   = (0,0,0)
        if info.floor == 0 { break }
        for i in 0..<info.floor
        {
            building[i] =
            {
                var tempMap = Array(repeating: [String](), count: info.height)
                for y in 0..<info.height
                {
                    let mapLine = readLine()!.map{String($0)}
                    tempMap[y] = mapLine
                    for x in 0..<info.width
                    {
                        if tempMap[y][x] == "S"
                        {
                            start = (x,y,i)
                        }
                        if tempMap[y][x] == "E"
                        {
                            finish = (x,y,i)       
                        }
                    }
                }
                return tempMap
            }()
            //매 층 이후에 엔터 있어서 readLine()처리
            readLine()!
        }
        escape(info, start, finish, &res, building, &visited)
    }
    print(res)
}
BOJ_6593()
