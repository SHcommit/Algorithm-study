import Foundation

//이상하게 right c++에서도 right 를 (long long)le9 해야 답이되는지 모르겠네,,

// 어느 mid값 개수에 따라서 N에 도착하는지를 구하는 것이 문제입니다.
// 이때 특정 점프 조건이 갖추어진다면, 이분 탐색을 통해 점프가 되는 첫번째 구간을 탐색할 수 있습니다.

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
