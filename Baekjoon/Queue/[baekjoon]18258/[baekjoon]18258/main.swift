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
    var command = readLine()! //이 경우 push 1을 다 받아온다
    var data = 0
    if command.contains("push") {
        //push 의 경우에만 분할 한 다음에 두번째 문자만 따로 숫자로 변환해서 queue에 저장하는 형식으로 바꿈.
        //에러 고침. 시간 초과.. 문제 발생 
        var command = command.split(separator: " ")
        queue.enqueue(element: Int(command[1])!)
        continue
    }
    switch command{
    //case "push":
   //     queue.enqueue(element: Int(command[1])!)
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
