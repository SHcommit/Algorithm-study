//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-2583-%EC%98%81%EC%97%AD-%EA%B5%AC%ED%95%98%EA%B8%B0
import Foundation
//직사각형 저장할 클래스
class rect{
    var start : coord
    var end   : coord
    init(x1: Int,y1 : Int, x2 : Int, y2 : Int){
        start = coord(x: x1, y: y1)
        end   = coord(x: x2, y: y2)
    }
}
class coord{
    var x : Int
    var y : Int
    init(x : Int, y : Int){
        self.x = x
        self.y = y
    }
}
// map안에 직사각형을 그려주는 함수
func drawRect(map : inout [[Bool]], rectList list : [rect]){
    for i in 0..<list.count{
        for y in list[i].start.y..<list[i].end.y{
            for x in list[i].start.x..<list[i].end.x{
                map[y][x] = true
            }
        }
    }
}

func edgeCheck(nx: Int, ny : Int,height : Int, width : Int) -> Bool{
    if nx < 0 || nx > width - 1 || ny < 0 || ny > height - 1 {
        return true
    }
    return false
}
//bfs탐색
func bfs(x : Int, y : Int , width: Int, height : Int, result : inout [Int], map : inout [[Bool]]){
    var count     = 1
    var queue     = [(x,y)]
    var index     = 0
    let direction = [(-1,0),(1,0),(0,1),(0,-1)]
    
    while queue.count != index {
        let (curX,curY) = queue[index]
        for (dx,dy) in direction{
            let (nx,ny) = (curX + dx, curY + dy)
            if edgeCheck(nx: nx, ny: ny, height: height, width: width) { continue }
            if map[ny][nx] == false {
                map[ny][nx] = true
                count += 1
                queue.append((nx,ny))
            }
        }
        index += 1
    }
    result.append(count)
}
/**
 * @param : rectList = 직사각형의 시작, 끝 좌표를 저장할 배열
 * @param : section = 남은 구역이 몇개 있는지?
 * @param : result = bfs탐색후 결과 저장.
 */
func BOJ_2583(){
    let hwk      = readLine()!.split(separator: " ").map{Int(String($0))!}
    let height   = hwk[0]
    let width    = hwk[1]
    let n        = hwk[2]
    var map      = Array(repeating: Array(repeating: false, count: width + 1), count: height + 1)
    var rectList = [rect]()
    var section  = 0
    var result   = [Int]()
    
    for i in 0..<n{
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        rectList.append(rect(x1: input[0], y1: input[1], x2: input[2], y2: input[3]))
    }
    
    drawRect(map: &map, rectList: rectList)
    
    for y in 0..<height{
        for x in 0..<width{
            if map[y][x] == false {
                section += 1
                map[y][x] = true
                bfs(x: x, y: y, width: width, height: height, result: &result, map: &map)
            }
        }
    }
    print(section)
    print(result.sorted().map{String($0)}.joined(separator: " "))
    
}

BOJ_2583()
