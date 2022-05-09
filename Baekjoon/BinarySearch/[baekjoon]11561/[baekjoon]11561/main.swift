import Foundation

var n = Int(readLine()!)!
var res = ""
func binary_search( lastBridgeNumber end : Int, answer ans : inout Int){
    var left = 1
    var right = 1000000000
    var mid : Int
    while(left <= right){
        mid = (left + right) / 2
        if isArrive(maxJumpCount: mid, BridgeNumber: end){
            ans = mid
            left = mid + 1
        }else{
            right = mid - 1
            
        }
    }
    print(ans)
    
}
func isArrive(maxJumpCount jumpCnt: Int, BridgeNumber end: Int)->Bool{
    if jumpCnt*(jumpCnt+1) / 2 <= end {
        return true
    }else{
        return false
    }
}

for i in 0..<n{
    var answer = 0
    var bridgeNumber = Int(readLine()!)!
    binary_search(lastBridgeNumber: bridgeNumber, answer: &answer)
}
print(res)
