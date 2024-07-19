import Foundation
func solution(_ a:[Int], _ b:[Int]) -> Int {zip(a,b).reduce(0) { $0 + $1.0*$1.1}}

print(solution([1,2,3,4],[-3,-1,0,2]))
