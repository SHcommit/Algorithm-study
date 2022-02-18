//  [baekjoon]2750
//  Created by 양승현 on 2022/02/18.
//  https://www.acmicpc.net/problem/2750

import Foundation

func insertionSort(_ array: inout Array<Int>){
    if array.count <= 1 {
        return;
    }
    for i in 1..<array.count{
        var x = array[i];
        var j = i;
        while j > 0 && array[j-1] > x {
            array[j] = array[j - 1]
            j -= 1;
        }
        array[j] = x
    }
}

let N = Int(readLine()!)!
var array = Array<Int>()
for _ in 0..<N{
    var input = Int(readLine()!)!
    array.append(input)
}

insertionSort(&array);
for i in 0..<array.count{
    print("\(array[i])")
}
