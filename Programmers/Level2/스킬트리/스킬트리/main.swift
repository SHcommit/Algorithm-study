//
//  main.swift
//  스킬트리
//
//  Created by 양승현 on 2023/04/17.
//

import Foundation

func solution(
  _ skill:String,
  _ skill_trees:[String]) -> Int {
    let list = skill.map{String($0)}
    var res = 0
    skill_trees.map{ input in
      var visited = Array(repeating: false, count: list.count)
      var skillTree = input.map{String($0)}
      for (i,char) in skillTree.enumerated() {
        if list.contains(char),
           let idx = list.firstIndex(of: char)
        {
          var flag = true
          for ind in (0..<idx) {
            if !visited[ind] { flag = false }
          }
          if !flag { break }
          visited[idx] = true
        }
        if i == skillTree.count-1 { res += 1 }
      }
    }
    return res
  }



func solution2(
  _ skill:String,
  _ skill_trees:[String]) -> Int {
    return skill_trees.filter {
      let filtered = $0.filter {
        return skill.index(of: $0) != nil
      }
      return skill.hasPrefix(filtered)
    }.count
    
    }
