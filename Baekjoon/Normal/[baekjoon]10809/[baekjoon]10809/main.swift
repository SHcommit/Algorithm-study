//
//  main.swift
//  [baekjoon]10809
//
//  Created by 양승현 on 2022/03/26.
//

/**
 *아스키코드로 바꾸면 런타임 에러가 나서
 *자주쓰는 아스키코드의 값을 변수로 저장했다.*
 */
import Foundation
var res = ""
var cnt = 0

// a~z의 개수만큼 -1을 원소로 하는 배열 생성
var alpha = Array(repeating: -1, count: 26)

var input = readLine()!
/*
 * 만약 alpha가 -1 일 때
 * 입력받은 개별 char 아스키코드 - a의 아스키코드로
 * a로부터 몇번째 위치하는지 index를 알 수 있어서 해당 index에 순차적으로 실행되는
 * 특정한 순서 cnt 를 저장시킨다.
 */
for i in input{
    if alpha[Int(i.asciiValue!) - 97] == -1 {
    alpha[Int(i.asciiValue!) - 97] = cnt
    }
    cnt+=1
}
for i in alpha{
    res += "\(i) "
}
print(res)
