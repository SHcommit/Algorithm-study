import Foundation

func BOJ_11650()
{
    let n = Int(readLine()!)!
    var list : [(x:Int,y:Int)] = [(Int,Int)]()
    for _ in 0..<n
    {
        let input = readLine()!.split(separator: " ").map{Int(String($0))!}
        list.append((input[0],input[1]))
    }
    list.sort
    {
        if $0.x<$1.x
        {
            return true
        }
        else if $0.x == $1.x
        {
            if $0.y<$1.y
            {
                return true
            }
            return false
        }
        return false
    }
    for (x,y) in list
    {
        print("\(x) \(y)")
    }
}
BOJ_11650()
