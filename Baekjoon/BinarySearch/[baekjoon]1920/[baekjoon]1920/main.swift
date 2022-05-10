import Foundation
var n    = Int(readLine()!)!
var list = readLine()!.split(separator: " ").map{Int(String($0))!}.sorted(by: <)
var secN = Int(readLine()!)!
var isExistNum : [Int] = readLine()!.split(separator: " ").map{Int($0)!}
func binary_search(arr: [Int], target: Int) -> Int{
    var left = 0
    var right = arr.count - 1
    while left <= right {
        let mid = (left + right) / 2
            if arr[mid] == target {
                return 1
            }else if arr[mid] > target {
                right = mid - 1
            }else if arr[mid] < target {
                left = mid + 1
            }
        }
        return 0
}
for i in 0..<secN {
    print(binary_search(arr: list, target: isExistNum[i]))
}
