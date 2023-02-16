// https://dev-with-precious-dreams.tistory.com/192

import Foundation
var res = ""
(0..<Int(readLine()!)!).map{ _ in
    _=readLine()
    let coins = readLine()!.split{$0==" "}.map{Int(String($0))!}
    let targetMoney = Int(readLine()!)!
    var dp = Array(repeating: 0, count: targetMoney+1); dp[0] = 1
    coins.map{
        for money in ($0...targetMoney) {
            dp[money] += dp[money-$0]
        }
    }
    res += "\(dp[targetMoney])\n"
}
print(res)

