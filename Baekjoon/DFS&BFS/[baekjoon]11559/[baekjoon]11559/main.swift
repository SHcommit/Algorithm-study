///*
//
//    뿌요.
// 필드에 여러가지 색의 뿌요를 놓는다.
// 중력의 영향 받고 아래 바닥이나 다른 뿌요 나올 때까지 아래로 떨어진다.
//
// 뿌요 놓으담에 같은색뿌요 상하좌우 4개이상으로 연결되면 한번에 없어진다.
//-> 1연쇄 시작
//
// 뿌요들 없어지고 다른 뿌요들있으면  아래로 떨어진다.
// -> 다시 같은색 4개이상뿌요있으면 터진다.
//  터진 후 또 뿌요내려오고 다시 터지을 반복할 때마다 1연쇄 늘어남
//
// 터질수있는 뿌요 여러 그룹이면 동시에 터져야하고 여러그룹 터져도 한번의 연쇄 추가
//
// 연쇄가 무엇인지? -> BFS로 뿌요 터지는 횟수
//
// bfs에 뿌요 터질때 횟수 측정 중요.
//
// 상대방 필드 주여졌을 때 연쇄 *몇번 연속으로 일어날지*
//
//
// 지금 20분 소비
// */
//
//import Foundation
//
//typealias Point = (x: Int, y: Int)
//typealias Element = (p: Point, t: Int)
//
//let direction = [(-1,0),(1,0),(0,1),(0,-1)]
//
//let width = 6, height = 12
//var map = Array(repeating: [String](), count: height)
//for i in 0..<12 {
//    map[i] = readLine()!.map{String($0)}
//}
//var time = 0
//var prevTime = -1
//
//func findBBUYO() {
//    var visited = Array(repeating: Array(repeating: false, count: width), count: height)
//    for y in 0..<height {
//        for x in 0..<width {
//            if !visited[y][x] && ( map[y][x] == "R" || map[y][x] == "G" || map[y][x] == "B" ||
//                                   map[y][x] == "P" || map[y][x] == "Y") {
//
//            }
//        }
//    }
//}
//
//
//func checkSequenceBBUYO(startProint sPoint: Point, startBBUYO: String) {
//    var queue = [Element]()
//    queue.append((sPoint,0))
//}
//
//
//while(time != prevTime) {
//    prevTime = time
//}
//
//
//func isOutOfBound(detect point: Point) -> Bool {
//    if point.x < 0 || point.y < 0 || point.x > width-1 || point.y > height-1 {
//        return true
//    }
//    return false
//}

class Point{
    var x: Int = 10
    var y: Int = 10
    
    func test(fn: (Int,Int)->Void) {
        print("test func start")
        fn(x,y)
        print("test func end")
    }
}


func main() {
    var result = Point()
    var p = Point()
    p.test { result1, result2 in
        result.x = result1
        result.y = result2
    }
    
}

main()
