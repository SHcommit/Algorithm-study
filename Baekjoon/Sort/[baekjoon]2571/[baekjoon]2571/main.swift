//  [baekjoon]2571
//  Created by 양승현 on 2022/02/20.
//  https://www.acmicpc.net/problem/2751
//  스위프트는 arrayslice 를 [] array 타입으로Cannot assign value of type 'ArraySlice<Int>' to type '[Int]'
//따라서 convert 해야한다 Array(arrayslice)
import Foundation

func mergeSort(_ array : Array<Int>) ->Array<Int>{
    if array.count < 2{
        return array;
    }
    let center = (array.count / 2)
    
    return merge(leftHalf : mergeSort( Array(array[0..<center])), rightHalf: mergeSort(Array(array[center..<array.count])))
}

func merge(leftHalf left : Array<Int>,rightHalf right : Array<Int>) -> Array<Int>{
    var lIndex = 0
    var rIndex = 0;
    var tmpArray : Array<Int> = Array<Int>();
    tmpArray.reserveCapacity(left.count + right.count)
    
    while (lIndex < left.count && rIndex < right.count){
       
        if left[lIndex] < right[rIndex]{
            tmpArray.append(left[lIndex])
            lIndex += 1;
        }
        else if left[lIndex] > right[rIndex] {
            tmpArray.append(right[rIndex]);
            rIndex += 1;
        }
        else{
            tmpArray.append(left[lIndex])
            tmpArray.append(right[rIndex])
            lIndex += 1
            rIndex += 1
        }
    }
    //array 추가.contentsOf
    tmpArray.append(contentsOf: lIndex == left.count ? Array(right[rIndex..<right.count]) : Array(left[lIndex..<left.count]));
    
    return tmpArray;
}

let n = Int(readLine()!)!
var inputArray = [Int]()
for _ in 0..<n {
    inputArray.append(Int(readLine()!)!)
}

inputArray = mergeSort(inputArray)

for i in 0..<inputArray.count {
    print("\(inputArray[i])")
}
