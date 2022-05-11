// https://dev-with-precious-dreams.tistory.com/entry/%EB%B0%B1%EC%A4%80Swift-2512-%EC%98%88%EC%82%B0
import Foundation
/**
 * result = 할당된 예산 값들이 최대값의 경우가 될 상한 액
 * left     = 상한액 될 수 있는 최소 금액
 * right   = 상한액 될 수 있는 최대 금액
 * requestBudget()을 만족시켰을 때 특정 상한액의 할당된 금액
 */
func binary_search(list : [Int], target : Int){
    
    var result       = 0
    var left         = 1
    var right        = list[list.count - 1]
    var assignBudget = 0
    
    while( left <= right){
        var tempBudget = 0
        let mid        = ( left + right )  / 2
        
        if requestBudget(list: list, target: target, budget: mid, tempBudget : &tempBudget) {
            //새로 구한 예산값들이 국가 예산과 가까운 값이라면 그 값과, 상한액을 저장!
            if tempBudget >= assignBudget{
                assignBudget = tempBudget
                result       = mid
                left         = mid + 1
            }
        }else{
            right = mid - 1
        }
        
    }
    
    print(result)
}
/**
 * 매개변수
 *  list       = 지역 별 요청 예산
 *  target  = 상한액
 *  budget = 국가 예산
 *  tempBudget = 지역별 예산의 합
 */
func requestBudget(list : [Int], target : Int, budget : Int, tempBudget : inout Int) -> Bool{
    var totalBudget = 0
    
    for i in 0..<list.count{
        totalBudget += list[i] - budget <= 0 ? list[i] : budget
    }
    
    if totalBudget <= target {
        tempBudget = totalBudget
        return true
    }else{
        return false
    }
}

func BOJ_2512(){
    
    var n        = Int(readLine()!)!
    var list     = readLine()!.split(separator: " ").map{Int(String($0))!}.sorted(by: <)
    var maxValue = Int(readLine()!)!
    
    binary_search(list: list, target: maxValue)
}

BOJ_2512()
