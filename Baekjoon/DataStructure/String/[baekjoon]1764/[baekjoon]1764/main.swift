import Foundation

 func BOJ_1764()
{
    let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
    let n  = nm[0]
    let m  = nm[1]
    
    var nSet = Set<String>()
    var mSet = Set<String>()
    
    for _ in 0..<n
    {
        nSet.insert(readLine()!)
    }
    for _ in 0..<m
    {
        mSet.insert(readLine()!)
    }
    let arr = nSet.intersection(mSet).sorted()
    print(arr.count)
    arr.forEach{ print($0)}
}
BOJ_1764()
