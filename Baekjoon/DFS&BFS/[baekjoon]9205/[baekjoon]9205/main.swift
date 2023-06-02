import Foundation

typealias Point = (x: Int, y: Int)
let testCase = Int(readLine()!)!

_=(0..<testCase).map { _ in
  print(isAnswer() ? "happy" : "sad")
}
func isAnswer() -> Bool {
  let n = Int(readLine()!)!
  let inputStart = readLine()!.split{$0==" "}.map { Int(String($0))! }
  let inputStore = (0..<n).map {_ in return readLine()!.split{$0==" "}.map{Int(String($0))!} }
  let inputEnd = readLine()!.split{$0==" "}.map { Int(String($0))!}
  let start = (inputStart[0], inputStart[1])
  let stores: [Point] = (0..<n).map { (inputStore[$0][0], inputStore[$0][1]) }
  var visited = Array(repeating: false, count: 100)
  let end: Point = (inputEnd[0], inputEnd[1])
  var queue: [Point] = [start]
  var idx = 0
  while queue.count != idx {
    var cp = queue[idx]
    if abs(cp.x - end.x) + abs(cp.y - end.y) <= 1000 {
      return true
    }
    for i in 0..<n where !visited[i] {
      let d = abs(cp.x - stores[i].x) + abs(cp.y - stores[i].y)
      if d <= 1000 {
        visited[i] = true
        queue.append((stores[i].x, stores[i].y))
      }
    }
    idx += 1
  }
  return false
}
