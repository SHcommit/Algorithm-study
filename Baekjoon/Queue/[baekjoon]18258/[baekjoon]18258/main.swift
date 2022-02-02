//  [baekjoon]18258
//  Created by 양승현 on 2022/01/30.
//  https://www.acmicpc.net/problem/18258

import Foundation
/**
 *리아노님 빠른 FileIO class를 사용했다.
 *최신버전이 있는데, 최신버전의 readString()은 String 반환이다.
 *근데 최신버전 보다 아래의 FileIO버전에서의 readString() -> Int 가 더 빠른 것 같다.
 *최신버전 FileIO를 쓰면 시간초과되고, 아래의 readString() -> Int 버전이 겨우 제출된다.
 *이번 문제를 계기로 readLine()과 split, 입력량이 많을 땐 FileIO 클래스의 사용. deQue의 기능 구현방법을 알게 되었다.
 */
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
/**
 *맨 처음에 한개의 배열에로 큐를 구현했다.
 *배열명 = data라고한다면. dequeue를 호출했을 때 data.removeFirst 를 사용했다.
 *왜 시간 초과가 나는지 곰곰이 생각해 봤는데. 첫번째 원소를 지우고 난 후에 빈 첫번째 자리를 뒤에서부터 채우는 방식이다.
 *이 방법 보다는 양쪽에서 삽입, 삭제가 빨리 되는 deQue를 선택하게 된 것 같다.
 *Queue관련 dequeue가 구현된 문제들을 살펴봤는데, 대부분이 removeFirst보단,
 *아래 구현된 것 처럼 dequeue를 호출했을 때 뒤의 배열이 비었다면, 앞의 배열 원소를 reversed한 후 뒷 원소에 대입하고, 앞 원소는 삭제하고,
 *큐의 앞원소를 출력한다면 rearQ.last or frontQ.first를 통해 사용하는 것이다. (참 대단한 개발자분들이다,,)
 */
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
