//  [baekjoon]18258
//  Created by 양승현 on 2022/01/30.
//  https://www.acmicpc.net/problem/18258

import Foundation

let input = readLine()!
public class Queue<T>{
    private var data = [T]()
    public init(){}
    //push
    public func enqueue(element: T){
        data.append(element)
    }
    //pop
    public func dequeue(element: T){
        data.removeFirst()
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
    public func back() -> T{
        guard let element = data.last else{
            return print("-1")
        }
        print("\(element)")
    }
}
