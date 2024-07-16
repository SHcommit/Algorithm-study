import Foundation
func solution(_ s:String) -> [Int] {
  var res: [Int] = [0, 0], cnt = 0, s = s
  while cnt != 1 {
    cnt = s.filter{$0=="1"}.count
    res[1] += s.count - cnt
    s = String(cnt, radix:2)
    res[0]+=1
  }
  return res
}

print(solution("110010101001"))
