
import Foundation
/**
 *정렬되지 않은, 주어진 배열에 대해서 array.count < 2 일 때까지
 *array배열 안에 원소가 딱 한개 남을 때까지 분할합니다.
 *  뭐로? == let cneter = array.count/2 코드를 기준으로 특정한 배열에 대해서
 *      array[0..<center] 와 array[center..< array.count] 정 가운데 원소를 기준으로 두개의 배열로 분할합니다.
 *배열에 **딱 한개 원소**만 나마스때,
 * 비로소 if 구문을 통해  해당 배열을 반환합니다.
 **맨 처음 merge(leftHalf:rightHalf:) 상황입니다.
 *  1. 왼쪽 배열, 오른쪽 배열이 각각 한개의 배열을 반환했다면, return ( merge (leftHalf: 왼쪽 단일 원소 배열, rightHalf: 오른쪽 한개 원소 배열) 을 통해
 *  2. 작은 것 부터 tmpArray배열에 임시 저장되어 정렬됩니다. 다 정렬됬다면, 또 Array를 반환합니다. 2의 반복입니다.
 *
 *언제까지?
 *(return문) 재귀호출이 끝날 때 까지
 */
func mergeSort(_ array: Array<Int>)->Array<Int>{
    if array.count < 2{
        return array
    }
    let center = array.count/2
    return merge(leftHalf: mergeSort(Array(array[0..<center])), rightHalf: mergeSort(Array(array[center..<array.count])))
}
/**
 *주어진 배열 left, right 에 대해서 특정 index가 한쪽 배열의 원소를 모두 지목 된 후 tmpArray에 저장 되었다면,
 *이미 남은 배열은 tmpArray 의 원소들보다 모두 큰 value입니다.
 *따라서 append(contentsOf:) 메서드를 통해 지목되지 않은 index 부터 마지막 원소까지 배열을 **arraySlice**해서 tmpArray에 추가합니다.
 */
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
/**
 * right배열의 **arraySlice**는
 * right 배열의 부분원소를 의미하는데, 이를 Array( )로 형 변환해야 배열을 인자값으로 받을 수 있습니다.
 */
