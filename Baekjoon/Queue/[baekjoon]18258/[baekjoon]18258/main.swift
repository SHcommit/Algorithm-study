//  [baekjoon]18258
//  Created by 양승현 on 2022/01/30.
//  https://www.acmicpc.net/problem/18258

import Foundation

public class Queue<T>{
    private var data = [T]()
    public init(){}
    //push
    public func enqueue(element: T){
        data.append(element)
    }
    //pop 자기자신 함수 호출방법은?
    public func dequeue(){
        self.isEmpty() == false ? print("\(data.removeFirst())") : print("-1")
    }
    public var size :Int {
        return data.count
    }
    public func isEmpty() -> Bool{
        return data.count >= 1 ? false : true
    }
    public func front(){
        guard let element = data.first else{
            return print("-1")
        }
        print("\(element)")
    }
    public func back(){
        guard let element = data.last else{
            return print("-1")
        }
        print("\(element)")
    }
}
let input = readLine()!
print("")
let queue = Queue<Int>()
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
        queue.isEmpty() == true ? print("1") : print("0")
    case "front":
        queue.front()
    case "back":
        queue.back()
    default:
        break;
    } 
}
