//
//  main.swift
//  최소직사각형
//
//  Created by 양승현 on 7/12/24.
//

import Foundation

func solution(_ sizes:[[Int]]) -> Int {
  sizes.reduce([0,0]) { p, size in { [max(p[0],$0[0]), max(p[1],$0[1])] }(size.sorted(by: <)) }.reduce(1, *)
}

print(solution([[60, 50], [30, 70], [60, 30], [80, 40]]  ))
