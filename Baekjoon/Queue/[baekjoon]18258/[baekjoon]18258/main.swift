//  [baekjoon]18258
//  Created by 양승현 on 2022/01/30.
//  https://www.acmicpc.net/problem/18258

import Foundation
public struct Queue<T>{
    private var data = [T]()
    mutating func enqueue(element: T){
        data.append(element)
    }
    mutating func dequeue(){
        isEmpty == false ? print("\(data.removeFirst())") : print("-1")
    }
    var size :Int {
        data.count
    }
    var isEmpty: Bool{
        data.count >= 1 ? false : true
    }
    var front: Int?{
        guard let element = data.first else{
            return -1
        }
        return element as? Int
    }
    var back: Int?{
        guard let element = data.last else{
            return -1
        }
        return element as? Int
    }
}
let input = readLine()!
var queue = Queue<Int>()
for _ in 0 ..< Int(input)! {
    let command = readLine()!.split(separator: " ")
    switch command[0]{
    case "push":
        queue.enqueue(element: Int(command[1])!)
    case "pop":
        queue.dequeue()
    case "size":
        print("\(queue.size)")
    case "empty":
        queue.isEmpty == true ? print("1") : print("0")
    case "front":
        print("\(queue.front!)")
    case "back":
        print("\(queue.back!)")
    default:
        break;
    } 
}
