
import Foundation

func mergeSort(_ array: Array<Int>)->Array<Int>{
    if array.count < 2{
        return array
    }
    let center = array.count/2
    return merge(leftHalf: mergeSort(Array(array[0..<center])), rightHalf: mergeSort(Array(array[center..<array.count])))
}

func merge(leftHalf left : Array<Int> , rightHalf right : Array<Int>) -> Array<Int>{
    var lIndex = 0
    var rIndex = 0
    var tmpArray = Array<Int>();
    tmpArray.reserveCapacity(left.count + right.count)
    
    while(lIndex < left.count && rIndex < right.count){
        if left[lIndex] > right[rIndex]{
            tmpArray.append(right[rIndex])
            rIndex += 1
        }
        else if left[lIndex] < right[rIndex]{
            tmpArray.append(left[lIndex])
            lIndex += 1
        }
        else {
            tmpArray.append(left[lIndex])
            tmpArray.append(right[rIndex])
            lIndex += 1
            rIndex += 1
        }
    }
    
    tmpArray.append(contentsOf: {
        lIndex == left.count ? Array(right[rIndex..<right.count]) : Array(left[lIndex..<left.count])
    }())
    return tmpArray;
}
