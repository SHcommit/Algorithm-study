//
//  main.swift
//  옹알이(2)
//
//  Created by 양승현 on 7/1/24.
//

import Foundation

/// 내풀이:
/// 일일이 비교.
///
/// 다른사람은 aya, ye, woo, ma를 숫자로 치환해서 숫자가 아닌 character가 있을때는 Int 변환 안되니까 그거 이용하고
/// 연이어 숫자가 있어도 연이어 발음하는 경우니까 그경우 배블링 못하는거 판별했음 ㄷ.ㄷ

func solution(_ babbling:[String]) -> Int {
  let aya: ArraySlice<String> = ["a","y","a"]
  let ye: ArraySlice<String> = ["y","e"]
  let woo: ArraySlice<String> = ["w","o","o"]
  let ma: ArraySlice<String> = ["m","a"]
  return babbling.map {
    var idx = 0
    let word = $0.map { String($0) }
    var prev: ArraySlice<String> = [""]
    while idx < word.count {
      switch word[idx] {
      case "a":
        if idx+3 > word.count || word[idx..<idx+3] == prev { return false }
        if word[idx..<idx+3] == aya {
          idx += 3
          prev = aya
        } else {
          return false
        }
      case "y":
        if idx+2 > word.count || word[idx..<idx+2] == prev { return false }
        if word[idx..<idx+2] == ye {
          idx += 2
          prev = ye
        } else {
          return false
        }
      case "w":
        if idx+3 > word.count || word[idx..<idx+3] == prev { return false }
        if word[idx..<idx+3] == woo {
          idx += 3
          prev = woo
        } else {
          return false
        }
      case "m":
        if idx+2 > word.count || word[idx..<idx+2] == prev { return false }
        if word[idx..<idx+2] == ma {
          idx += 2
          prev = ma
        } else {
          return false
        }
      default:
        return false
      }
    }
    return true
  }.filter{ $0 }.count
}

solution2(["ayayaya"])
