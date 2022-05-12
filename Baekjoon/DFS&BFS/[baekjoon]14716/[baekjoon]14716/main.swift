import Foundation

/**
 * @param : filter     = 1과 0으로 필터링된 현수막
 * @param : vidited = 탐색 방문 여부
 * @param : word    = 단어 수
 */
class model{
    let height  : Int
    let width   : Int
    var filter  : [[Int]]
    var visited : [[Bool]]
    var word    : Int
    init(){
        let MN  = readLine()!.split(separator: " ").map{Int(String($0))!}
        height  = MN[0]
        width   = MN[1]
        word    = 0
        filter  = Array(repeating: [Int](), count: height)
        visited = Array(repeating: Array(repeating: false, count: width), count: height)
    }
}
// 현수막의 글자를 0과 1로 변환하는 함수
func filtering(height : Int, map : inout [[Int]]){
    for y in 0..<height{
        map[y] = readLine()!.split(separator: " ").map{Int(String($0))!}
    }
}
// 현수막의 범위를 초과하여 탐색하는가?
func edgeCheck(nx : Int, ny : Int, width : Int, height : Int) -> Bool{
    if ny < 0 || ny > height - 1  || nx < 0 || nx > width - 1{
        return true
    }
    return false
}
// deep first search 탐색!!
func dfs(_ x :Int ,_ y : Int, width : Int, height : Int , visit : inout [[Bool]], filter : inout [[Int]]){
    let direction = [(1,0),(1,1),(1,-1),(0,1),(0,-1),(-1,0),(-1,-1),(-1,1)]
    
    for (dx,dy) in direction{
        let (nx,ny) = (dx + x, dy + y)
        if edgeCheck(nx: nx, ny: ny, width: width, height: height){ continue }
        if !visit[ny][nx] && filter[ny][nx] == 1 {
            visit[ny][nx] = true
            dfs(nx, ny,width: width,height: height, visit: &visit, filter: &filter)
        }
    }
}

//entry point
func BOJ_14716(){
    var m = model()
    filtering(height: m.height, map: &m.filter)
    
    for y in 0..<m.height{
        for x in 0..<m.width{
            if !m.visited[y][x] && m.filter[y][x] == 1 {
                m.visited[y][x] = true
                m.word += 1
                
                dfs(x,y,width: m.width, height: m.height, visit: &m.visited, filter: &m.filter)
            }
        }
    }
    print(m.word)
}

BOJ_14716()
