//  [baekjoon]18258
//  Created by 양승현 on 2022/01/30.
//  https://www.acmicpc.net/problem/18258

import Foundation
final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}
public struct Queue{
    private var data = [Int]()
    mutating func enqueue(element: Int){
        data.append(element)
    }
    mutating func dequeue(){
            isEmpty == false ? result.write(String(data.removeFirst()) + "\n") : result.write("-1\n")
        }
    var size :Int {
        data.count
    }
    var isEmpty: Bool{
        data.count >= 1 ? false : true
    }
    var front: Int{
        guard let element = data.first else{
            return -1
        }
        return element
    }
    var back: Int{
        guard let element = data.last else{
            return -1
        }
        return element
    }
}
var result = ""
let fIO = FileIO()
var queue = Queue();
let n = fIO.readInt()
for _ in 0 ..< n {
    var input = fIO.readString() //이 경우 push 1을 다 받아온다
    switch input{
        case "push":
            queue.enqueue(element: fIO.readInt())
        case "pop":
            queue.dequeue()
        case "size":
            result.write(String(queue.size) + "\n")
        case "empty":
            queue.isEmpty == true ? result.write("1\n") : result.write("0\n");
        case "front":
            result.write(String(queue.front) + "\n")
        case "back":
            result.write(String(queue.back) + "\n")
        default:
            break;
    }
}
print(result)
