print((Set((0..<Int(readLine()!)!).map{_ in readLine()!})).sorted().sorted{$0.count<$1.count}.joined(separator: "\n"))

