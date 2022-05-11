import Foundation

func BOJ_10815(){
    var n      = Int(readLine()!)!
    var myCard = readLine()!.split(separator: " ").map{Int(String($0))!}.sorted(by: <)
    var m      = Int(readLine()!)!
    var list   = readLine()!.split(separator: " ").map{Int(String($0))!}
    var res    = ""
    
    for i in 0..<list.count{
        binary_search(FirstList: myCard, target: list[i], result: &res)
    }
    print(res)
}
func binary_search(FirstList myCard : [Int], target : Int, result res : inout String){
    var left  = 0
    var right = myCard.count - 1
    while(left <= right){
        let mid = (left + right) / 2
        if myCard[mid] == target {
            res += "\(1) "
            return
        }else if myCard[mid] < target {
            left = mid + 1
        }
        else if myCard[mid] > target{
            right = mid - 1
        }
    }
    res += "\(0) "
}
BOJ_10815()
