//
//  main.swift
//  이모티콘 할인행사
//
//  Created by 양승현 on 6/21/24.
//

import Foundation

let RateIdx = 0
let PriceIdx = 1
let Rate = [10,20,30,40]
var emojiRateAllCases: [[Int]] = []

func permutation(arr: [Int], _ n: Int) {
  if arr.count == n {
    emojiRateAllCases.append(arr)
    return
  }
  
  (0..<4).forEach {
    permutation(arr: arr + [$0], n)
  }
}

func solution(_ users:[[Int]], _ emoticons:[Int]) -> [Int] {
  var emojiPlusJoinUsers = 0
  var emojiSales = 0
  
  let saledEmojis = emoticons.map { emoticon in
    Rate.map { emoticon - (emoticon * $0 / 100) }
  }
  
  /// 처음에 모든 이모티콘에 대해서 0~3이내의 rate들을 구해야했다. 예를들어
  /// 이모티콘 3개가있고 4 4 4 (40% 40% 40%)의 할인율을 순열로 구해야했다. 1~ 4 까지할인율 중 4를  3개 골라야함.
  /// 근데 맨 처음에 Users로 접근해버렸다. 내가구하고자하는게 뭔지 .. 분명히 이모티콘 rate 순열을 구하는건데, 사용자 개수 중 10%~40%까지 4개를 고르도록
  /// 잘못 넣었다.
  ///
  /// 이거 제외하면 이후의 로직은 맞았는데, 여기서 모든 시간이 뺐겼다..
  permutation(arr: [], emoticons.count)
  emojiRateAllCases.forEach { p in
    let price = p.enumerated().map { emojiIdx, rateIdx in saledEmojis[emojiIdx][rateIdx] }
    /// 모든 경우는 4* 4* 4* 4* 4* 4* 4 로 연산횟수가 적었다.
    /// 각각의 이모티콘마다(1~7개) 할인 적용율을 구했다면? 나머지는 간단하다.
    /// 사용자의 원하고자하는 rate가 위에서 지정한 이모티콘 할인율보다 작은것들을 소팅 후 더하면 해당 유저가 살수있는 이모티콘 price가 나온다.
    var tempEmojiPlusJoinUsers = 0
    let tempPurchasedEmoji = users.map { user in
      let purchase = p
        .enumerated()
        .filter { user[RateIdx] <= Rate[$0.element] }
        .map { price[$0.offset] }
        .reduce(0, +)
      /// 이 사용자가 구매한 가격이 사용자가 플러스 서비스 구매하기 전의 가격이라면? 플러스 구매+1  -> 누적 구매는 0으로 하면 됨
      if user[PriceIdx] <= purchase {
        tempEmojiPlusJoinUsers += 1
        return 0
      }
      return purchase
      /// 이렇게 플러스를 제외한 누적 구매가 있을때는 누적구매를 또 더해
    }.reduce(0,+)
    
    /// 그렇게 구한게 이제 최근에 구한거보다 크면? 뭐 ㅇ ㅣ렇게 갱신 ㅇㅇ
    if emojiPlusJoinUsers < tempEmojiPlusJoinUsers {
      emojiPlusJoinUsers = tempEmojiPlusJoinUsers
      emojiSales = tempPurchasedEmoji
    } else if emojiPlusJoinUsers == tempEmojiPlusJoinUsers {
      emojiSales = max(emojiSales, tempPurchasedEmoji)
    }
  }
  return [emojiPlusJoinUsers, emojiSales]
}


print(solution([[40, 2900], [23, 10000], [11, 5200], [5, 5900], [40, 3100], [27, 9200], [32, 6900]],[1300, 1500, 1600, 4900]))


// MARK: - 첫트라이 ㅋ
// 이모티콘 4개로만 가정하고 풀었다. 최대 1 ~ 7개인데, 어쨋든 이 1~7로 하기위해선 순열을 사용해야했는데, 그걸 로 변환하는 과정에서
// 너무 오래 걸렸다.

//let RateIdx = 0
//let PriceIdx = 1
//let Rate = [10,20,30,40]
//func solution(_ users:[[Int]], _ emoticons:[Int]) -> [Int] {
//  var emojiPlusJoinUsers = 0
//  var emojiSales = 0
//  let saledEmojis = emoticons.map { emoticon in
//    Rate.map { emoticon - (emoticon * $0 / 100) }
//  }
//  
//  for a in 0...3 {
//    for b in 0...3 {
//      for c in 0...3 {
//        for d in 0...3 {
//          let price = [saledEmojis[0][a], saledEmojis[1][b], saledEmojis[2][c], saledEmojis[3][d]]
//          var tempEmojiPlusJoinUsers = 0
//          let tempPurchasedEmoji = users.map { user in
//            let purchase = [a,b,c,d]
//              .enumerated()
//              .filter { user[RateIdx] <= Rate[$0.1] }
//              .map { price[$0.offset] }
//              .reduce(0, +)
//            if user[PriceIdx] <= purchase {
//              tempEmojiPlusJoinUsers += 1
//              return 0
//            }
//            return purchase
//          }.reduce(0,+)
//          if emojiPlusJoinUsers < tempEmojiPlusJoinUsers {
//            emojiPlusJoinUsers = tempEmojiPlusJoinUsers
//            emojiSales = tempPurchasedEmoji
//          } else if emojiPlusJoinUsers == tempEmojiPlusJoinUsers {
//            emojiSales = max(emojiSales, tempPurchasedEmoji)
//          }
//        }
//      }
//    }
//  }
//  
//  return [emojiPlusJoinUsers, emojiSales]
//}
