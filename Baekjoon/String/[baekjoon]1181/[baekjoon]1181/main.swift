import Foundation

func BOJ_1181()
{
    let n = Int(readLine()!)!
    var check = Set<String>()
    var words = [(Int, String)]()

    for _ in 0 ..< n {
        let word = String(readLine()!)
        if check.insert(word).inserted {
            words.append((word.count, word))
        }
    }
    words = words.sorted{ $0.0 == $1.0 ? $0.1 < $1.1 : $0.0 < $1.0 }
    for i in words {
        print(i.1)
    }
}
BOJ_1181()
