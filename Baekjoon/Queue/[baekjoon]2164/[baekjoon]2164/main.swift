//  [baekjoon]2164
//  Created by 양승현 on 2022/02/14.
//  https://www.acmicpc.net/problem/2164

import Foundation

class Queue {
    private var frontQ : Array<Int>
    private var rearQ = Array<Int>()
    init (_ input: Int){
        frontQ = Array(1...input)
    }
    func enQueue(_ element: Int){
        frontQ.append(element)
    }
    func deQueue() -> Int{
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
    var front : Int {
        if !isEmpty {
            return rearQ.isEmpty ? frontQ.first! : rearQ.last!
        }
        return -1
    }
}
let input = Int(readLine()!)!
var q = Queue(input);
if q.size == 1 {
    print("1");
    exit(0)
}
while q.size > 1 {
    
    if q.size != 2 {
        q.deQueue()
        q.enQueue(q.deQueue())
    }else {
        q.deQueue()
        print("\(q.front)")
        break;
    }
}
