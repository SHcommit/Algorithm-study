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
    var str = readLine()!
    if str == "front" {
        result += "\(queue.front)" + "\n"
    }else if str == "pop"{
        result += "\(queue.dequeue())" + "\n"
    }else if str == "empty"{
        result += queue.isEmpty ? "1\n" : "0\n"
    }else if str == "size"{
        result += "\(queue.size)" + "\n"
    }else if str == "back"{
        result += "\(queue.back)" + "\n"
    }else{
        var str = str.split(separator: " ")
        queue.enqueue(Int(str[1])!)
    }
}
print(result)
