func solution(_ array:[Int], _ commands:[[Int]]) -> [Int] {
    return commands.map { command in 
        let (s, e) = (command[0] - 1, command[1] - 1)
        return array[s...e].sorted(by: <)[command[2] - 1]
    }
}
