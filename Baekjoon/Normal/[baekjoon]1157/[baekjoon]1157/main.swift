//  [baekjoon]1157
//  Created by 양승현 on 2022/03/21.

import Foundation
/**
 *(map이라는 함수는 for 문 대신 사용됩니다.)
 *(여기서 사용된 $0 은 익명 함수(람다,클로저)의 인자값입니다, readLine()!에서 "한 글자씩" 받는데 그 익명함수의
 * 인자 값을 정의하지 않을 경우 $0으로 표현될 수 있습니다.)
 *
 *주어진 문자열 입력값을 받아 전부 대문자로 변환 후! 배열로 반환
 */
var input = readLine()!.uppercased()

//배열은 index를 사용하지만 딕셔너리는 key값을 사용한다.
//딕셔너리 key 값은 string, value 값은 int형
var str = [String:Int]()


//입력받은 배열 seq에 대해, index == 0 부터 마지막가지 의 원소를 한개씩 순차적으로 char로 받는다.
for char in input {
    //딕셔너리의 키값이 대입되지 않았다면?
    str[String(char)] = str[String(char)] == nil ? 0 : str[String(char)]! + 1
}
//딕셔너리의 가장 큰 값이 2개 이상인지 판별할 배열
var cnt = Array<String>()

//딕셔너리의 각각 키값을 for문처리!!
for key in str.keys {
    //만약 딕셔너리의 특정 key의 value가 해당 딕셔너리의 키값들중 맥스값인가?
    if str[key] == str.values.max() {
        //맞다면 배열에 추가!!
        cnt.append(key)
    }
}
//삼항연산자로 판별. 딕셔너리에 max값이 같은 문자가 존재한다면 ? 출력
print(cnt.count > 1 ? "?" : cnt.first!)
