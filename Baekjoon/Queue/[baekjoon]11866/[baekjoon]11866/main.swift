//
//  main.swift
//  [baekjoon]11866
//
//  Created by 양승현 on 2022/02/15.
//

import Foundation
/**
class Queue {
    var queue : Array<Int>
    init(_ element : Int){
        queue = Array(1...element)
    }
    func enQueue(_ element : Int){
        queue.append(element);
    }
    func deQueue(_ index: Int) -> Int {
        return queue.remove(at: index)
    }
    var size : Int {
        queue.count
    }
}*/

let input = readLine()!.split(separator: " ")
var N = Int(input[0])!
let std = Int(input[1])!//std 만큼 나누어야함
var array = Array(1...N);
var cnt = 0; //몇번 반복하는가. -> N 번만큼.
var index = -1;
var result : String = "<"
while(cnt != N ){
    for _ in 1...std{
        index += 1
        if index >= N {
            index %= N
        }
        if array[index] == -1{
            while array[index] == -1 {
                index += 1
                if index >= N {
                    index %= N
                }
            }
        }
    }
    result += "\(array[index])"
    cnt += 1
    if cnt == 7 {
        break;
    }
    result += ", "
    array[index] = -1;
}
print(result + ">")
//var index = 0; //index == 0~6까지, 근데 count = 3일 때 index는 2니까 index +1 해야함.
/*while(cnt != N){
    if index > N {
        index = index % N;
    }
    if (index + 1) % count == 0 {
        result += "\(q.deQueue(index)), "
        index += 1
    }else{
        
    }
}
*/
//print(result + ">")
