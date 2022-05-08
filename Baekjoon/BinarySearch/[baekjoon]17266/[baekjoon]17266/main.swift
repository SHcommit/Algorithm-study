import Foundation
// 문제 설명 : https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-17266-%EC%96%B4%EB%91%90%EC%9A%B4-%EA%B5%B4%EB%8B%A4%EB%A6%AC
/**
 * @param : n = 굴다리 개수
 * @param : m = 가로등 개수
 * @param : location = 가로등 위치
 */
var n = Int(readLine()!)!
var m = Int(readLine()!)!
var location = readLine()!.split(separator: " ").map{Int(String($0))!}

/**
 * 이진 탐색을통한 최소 높이 탐색 함수
 *****
 * @param left : 좌
 * @param right : 우
 * @param mid : ( left + right ) / 2
 * 만약 left 가 right 보다 큰 값이라면? 무한 루프 탈출 후 결과 출력.
 */
func binary_search(){
    var left = 0
    var right = n
    var mid = 0
    var answer = 0
    while(left <= right){
        mid = (left + right) / 2
        if (isAllShine(height: mid)){
            answer = mid
            right = mid - 1
        }else{
            left = mid + 1
        }
    }
    print(answer)
}
// 주어진 높이 height가 모든 길을 비추는가? == true !
func isAllShine(height : Int) -> Bool{
    var lightCount = 0
    
    for streetLampIndex in location {
        if streetLampIndex - height <= lightCount {
            lightCount = streetLampIndex + height
        }else{
            return false
        }
    }
    if lightCount >= n{
        return true
    }else{
        return false
    }
}

binary_search()
