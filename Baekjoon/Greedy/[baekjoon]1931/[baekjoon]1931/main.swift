//https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-1931-%ED%9A%8C%EC%9D%98%EC%8B%A4-%EB%B0%B0%EC%A0%95

import Foundation
typealias Element = (start: Int, end : Int)
// 이 문제는 소팅을 잘 해야한다.
func BOJ_1931()
{
    var n        = Int(readLine()!)!
    var selected = [Element]()
    var list     = [Element]()
    var index    = 0
    for _ in 0..<n
    {
        let se = readLine()!.split(separator: " ").map{Int(String($0))!}
        list.append((se[0],se[1]))
    }
    list.sort(by: )
    {
        if $0.end == $1.end
        {
            return $0.start < $1.start
        }
        return $0.end < $1.end

    }
    selected.append(list[0])
    for i in 1..<n
    {
        if selected[index].end <= list[i].start
        {
            selected.append(list[i])
            index += 1
        }
    }
    print(selected.count)
}
BOJ_1931()
