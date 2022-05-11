import Foundation

func binary_search(list : [Int], target : Int){
    
    var result       = 0
    var left         = 1
    var right        = list[list.count - 1]
    //할당된 예산값들의 최대값이 저장됨
    var assignBudget = 0
    
    while( left <= right){
        var tempBudget = 0
        let mid        = ( left + right )  / 2
        
        if requestBudget(list: list, target: target, budget: mid, tempBudget : &tempBudget) {
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
