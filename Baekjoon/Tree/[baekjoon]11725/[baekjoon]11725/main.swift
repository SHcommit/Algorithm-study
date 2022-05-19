import Foundation

func dfs(vertax v : Int, ans : inout [Int], tree : inout [[Int]]){
    for i in 0..<tree[v].count{
        if ans[tree[v][i]] == 0{
            ans[tree[v][i]] = v
            dfs(vertax: tree[v][i], ans: &ans, tree: &tree)
        }
    }
}
func BOJ_11725(){
    let n    = Int(readLine()!)!
    var tree = Array(repeating: [Int](), count: n + 1)
    var ans  = Array(repeating: 0, count: n + 1)
    
    for _ in 1..<n{
        let node = readLine()!.split(separator: " ").map{Int(String($0))!}
        tree[node[0]].append(node[1])
        tree[node[1]].append(node[0])
    }
    dfs(vertax: 1, ans: &ans, tree: &tree)
    for i in 2...n{
        if ans[i] == 0{ continue }
        print(ans[i])
    }
}

BOJ_11725()
