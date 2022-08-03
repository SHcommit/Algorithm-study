import Foundation

func BOJ_9372()
{
    let n = Int(readLine()!)!
    var res = ""
    for _ in 0..<n
    {
        let NM = readLine()!.split(separator:" ").map{Int(String($0))!}
        let (N,M) = (NM[0],NM[1])
        var visited = Array(repeating:false,count:M+1)
        var map = Array(repeating: [Int](), count: N+1)
        for _ in 0..<M
        {
            let ab = readLine()!.split(separator:" ").map{Int(String($0))!}
        }
        res += "\(N-1)\n"
    }
    print(res)
}
BOJ_9372()
