import Foundation

func BOJ_2003()
{
    let ns    = readLine()!.split(separator:" ").map{Int(String($0))!}
    let n     = ns[0], standardSum = ns[1]
    let list  = readLine()!.split(separator:" ").map{Int(String($0))!}
    var sum   = 0 ,right = 0 ,cnt   = 0
    for left in 0..<n
    {
        while sum < standardSum && right < n
        {
            sum += list[right]
            right += 1
        }
        if sum == standardSum
        {
            cnt += 1
        }
        sum -= list[left]
    }
    print(cnt)
}
BOJ_2003()
