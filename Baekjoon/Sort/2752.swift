print(readLine()!.split{$0==" "}.map{Int(String($0))!}.sorted().map{String($0)}.joined(separator:" "))
