//  [baekjoon]18258
//  Created by 양승현 on 2022/01/30.
//  https://www.acmicpc.net/problem/18258

import Foundation
public struct Queue{
    private var data = [Int]()
    mutating func enqueue(element: Int){
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
let input = readLine()!
var queue = Queue()
for _ in 0 ..< Int(input)! {
    //let command = readLine()!.split(separator: " ")
    let command = readLine()! //이 경우 push 1을 다 받아온다
    //문제를 알았다. split를 쓸 경우 substring 으로 분할하는데 만약 한개의 문자만 받는 경우 에러 발생.
    //따라서 push 일 경우에만 prefix 와 suffix로 나누면 정확하게 에러가 발생하지 않을텐데
    var data = 0
    if command.prefix(4) == "push" {
        
        let data = command.suffix(1)
    }
    switch command{
    case "push":
        queue.enqueue(element: Int(exactly: data)!)
    case "pop":
        queue.dequeue()
    case "size":
        print("\(queue.size)")
    case "empty":
        queue.isEmpty == true ? print("1") : print("0")
    case "front":
        print("\(queue.front)")
    case "back":
        print("\(queue.back)")
    default:
        break;
    } 
}
