//  [baekjoon]18258
//  Created by 양승현 on 2022/01/30.
//  https://www.acmicpc.net/problem/18258

import Foundation
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
for _ in 0 ..< Int(readLine()!)! {
    var input = readLine()!
    if input.contains("push") {
        var input = input.split(separator: " ")
        queue.enqueue(Int(input[1])!)
        continue
    }
    switch input{
        case "pop":
            result += "\(queue.dequeue())" + "\n"
        case "size":
            result += "\(queue.size)" + "\n"
        case "empty":
            result += queue.isEmpty ? "1\n" : "0\n"
        case "front":
            result += "\(queue.front)" + "\n"
        case "back":
            result += "\(queue.back)" + "\n"
        default:
            break;
    }
}
print(result)
