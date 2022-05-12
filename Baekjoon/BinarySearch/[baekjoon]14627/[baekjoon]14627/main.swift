import Foundation
/**
 * 이분탐색 시 중요한 것은 101 102 103 104 일때, left 가 101로 설정되며 안됨, -> 1이나문제에서주어지는 최소로 되야함
 * 그리고 같은 값을 주는 경우 100 100 100 100 도 생각해야함
 *
9 8
1
5
3
1000000000
6
29
13
2
15
 */
func cutGreenOnion(length : Int,target : Int, remainded : inout Int, onions : [Int]) -> Bool{
    var cuttingCount = 0
    for i in 0..<onions.count {
        cuttingCount += onions[i] / length
    }
    return cuttingCount >= target
}
func binary_search(onionList list : [Int], chickenCount chickCnt : Int, remainOnion remain : inout Int, sum : Int){
    var left    = 1
    var right   = list[list.count - 1]
    var res     = 0
    while(left <= right){
        let mid = (left + right) / 2
        var tempOnions = 0
        if cutGreenOnion(length: mid, target: chickCnt, remainded: &tempOnions, onions: list) {
            left = mid + 1
            res = mid
        }else{
            right = mid - 1
        }
    }
    remain = sum - res*chickCnt
}
func BOJ_14627(){
    let sc          = readLine()!.split(separator: " ").map{Int(String($0))!}
    let onion       = sc[0]
    let chicken     = sc[1]
    var list        = [Int]()
    var sum         = 0
    var remainOnion = 0
    for _ in 0..<onion{
        list.append({
            let temp = Int(readLine()!)!
            sum += temp
            return temp
        }())
    }
    
    list.sort(by: <)
    binary_search(onionList: list,chickenCount: chicken, remainOnion: &remainOnion, sum : sum)
    
    print(remainOnion)
}
BOJ_14627()
