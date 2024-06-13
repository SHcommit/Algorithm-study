//
//  main.swift
//  카드 뭉치
//
//  Created by 양승현 on 6/13/24.
//

import Foundation

func solution(_ cards1:[String], _ cards2:[String], _ goal:[String]) -> String {
  var isMakable = true
  var card1Idx = 0
  var card2Idx = 0
  for keyword in goal {
    if card1Idx < cards1.count && cards1[card1Idx] == keyword {
      card1Idx += 1
    } else if card2Idx < cards2.count && cards2[card2Idx] == keyword {
      card2Idx += 1
    } else {
      isMakable = false
      break
    }
  }
  return isMakable ? "Yes" : "No"
}
