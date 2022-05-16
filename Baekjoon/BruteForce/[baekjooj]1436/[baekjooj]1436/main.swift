import Foundation

func BOJ_1436(){
    let n = Int(readLine()!)!
    
    var count = 0
    for i in 666...10000000{
        var num = i
        while(num >= 666){
            if num % 1000 == 666{
                count += 1
                break
            }
            num /= 10
        }
        if count == n {print(i); return;}
    }
}


BOJ_1436()
