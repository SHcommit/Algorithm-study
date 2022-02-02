//  [baekjoon]18258
//  Created by 양승현 on 2022/01/30.
//  https://www.acmicpc.net/problem/18258

import Foundation
final class FileIO {
    private var buffer:[UInt8]
    private var index: Int
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
        index = 0
    }
    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        return buffer.withUnsafeBufferPointer { $0[index] }
        
    }
    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true
        while now == 10 || now == 32 {
            now = read()
        } // 공백과 줄바꿈 무시
        if now == 45{
            isPositive.toggle();now = read()
        } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }
        return sum * (isPositive ? 1:-1)
    }
    @inline(__always) func readString() -> Int {
        var str = 0
        var now = read()
        while now == 10 || now == 32 {
            now = read()
        } // 공백과 줄바꿈 무시
        while now != 10 && now != 32 && now != 0 {
            str += Int(now)
            now = read()
            
        }
        return str
    }
}
class Queue{
    private var frontQ = [Int]()
    private var rearQ = [Int]()
    func enqueue(_ element: Int){
        frontQ.append(element)
    }
    func dequeue() -> Int{
        if isEmpty{
            return -1
        }
        if rearQ.isEmpty{
            rearQ = frontQ.reversed()
            frontQ.removeAll()
        }
        return rearQ.popLast()!
    }
    var size :Int {
        frontQ.count + rearQ.count
    }
    var isEmpty: Bool{
        rearQ.isEmpty && frontQ.isEmpty
    }
    var front: Int{
        if !isEmpty {
            return rearQ.isEmpty ? frontQ.first! : rearQ.last!
        }
        return -1
    }
    var back: Int{
        if !isEmpty{
            return frontQ.isEmpty ? rearQ.first! : frontQ.last!
        }
        return -1
    }
}
var result = ""
var queue = Queue();
var fIO = FileIO();
for _ in 0 ..< fIO.readInt() {
    let input = fIO.readString()
    if input == 448{
        queue.enqueue(fIO.readInt())
    }else if input == 553 {
        result += "\(queue.front)" + "\n"
    }else if input == 335{
        result += "\(queue.dequeue())" + "\n"
    }else if input == 559{
        result += queue.isEmpty ? "1\n" : "0\n"
    }else if input == 443{
        result += "\(queue.size)" + "\n"
    }else if input == 401{
        result += "\(queue.back)" + "\n"
    }
}
print(result)
