import Foundation

func printQueue(arr list : inout [Int], targetIndex : Int, res : inout String){
    var index    = 0
    var target   = list[targetIndex]
    var visit    = Array(repeating: false, count: list.count)
    var popCount = 0
    while(true){
        if index == list.count {
            index = 0
        }
        let max = maxValue(arr: list)
        if visit[index] == false{
            //숫자를비교하지말고 index로 비교하자,,
            if target < max {
                if list[index] == max{
                    //pop대신 방문 체크하자
                    visit[index] = true
                    list[index] = -1
                    popCount += 1
                }
            }else if target == max {
                if index == targetIndex{
                    popCount += 1
                    break
                }
                else if list[index] != max{
                }
                else{
                    visit[index] = true
                    popCount += 1
                }
            }
        }
        index += 1
    }
    res += "\(popCount)\n"
}

func maxValue(arr list : [Int]) -> Int{
    var arr = list.sorted(by: >)
    return arr[0]
}

func BOJ_1966(){
    var n   = Int(readLine()!)!
    var res = ""
    
    for i in 0..<n{
        var nm   = readLine()!.split(separator: " ").map{Int(String($0))!}
        var list = readLine()!.split(separator: " ").map{Int(String($0))!}
        var n    = nm[0]
        var m    = nm[1]
        printQueue(arr: &list, targetIndex: m, res: &res)
    }
    print(res)
}

BOJ_1966()
