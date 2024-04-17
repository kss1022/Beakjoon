//
//  Beakjoon2268.swift
//  Beakjoon
//
//  Created by 한현규 on 4/17/24.
//

import Foundation


class Beakjoon2268{
    
    func main(){
        let input = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let n = input[0]
        let m = input[1]
        
        var commands = [(Int, Int, Int)]()
        for _ in 0..<m{
            let command = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            commands.append((command[0],command[1],command[2]))
        }
        
        numberOfSums(n, m, commands)
    }
    //0     Sum(i , j)  i...j  ( i < j )     j...i ( i > j )
    //1     Modify(i, k)를 수행하면 A[i] = k가 되는 함수
    
    func numberOfSums(_ n: Int, _ m : Int, _ commands: [(Int, Int, Int)]){
        
        var nums = Array.init(repeating: 0, count: n+1)
        var tree = Array.init(repeating: 0, count: n+1)
        
        
        var result = ""
        for command in commands {
            if isSum(command.0){
                result.append("\(sum(command.1, command.2, n , tree))\n")
                continue
            }
            
            modifiy(command.1, command.2, n ,&nums, &tree)
        }
        
        print(result)
        
    }
    
    
    func isSum(_ flag: Int) -> Bool{
        flag == 0
    }
    
    
    func modifiy(_ at: Int, _ element: Int, _ n: Int,_ nums: inout [Int], _ tree: inout [Int]){
        let diff = element - nums[at]
        nums[at] = element
        updatefenwikTree(at, diff, n, &tree)
    }
    
    //0...end - 0..<start -> start ~ end
    func sum(_ i : Int, _ j: Int, _ n: Int,_ tree: [Int]) -> Int{
        let start = i > j ? j : i
        let end  = i > j ? i : j
        return sumFenwikTree(end, tree) - sumFenwikTree(start-1, tree)
    }
    
    
    ///FenwikTree
    func createFenwikTree(_ nums: [Int], _ tree: inout [Int]){
        for i in 0..<nums.count{
            updatefenwikTree(i, nums[i], nums.count, &tree)
        }
    }
    
    func updatefenwikTree(_ at: Int, _ diff: Int, _ n: Int, _ tree: inout [Int]){
        var i = at
        
        while i <= n{
            tree[i] += diff
            i += LSB(i)     //i += LSB(i)  == i | (i-1) + 1
        }
    }
    
    func sumFenwikTree(_ at: Int, _ tree: [Int]) -> Int{
        var result = 0
        
        var i = at
        while i > 0{
            result += tree[i]
            i &= (i-1)          // i -= LSB(i)  ==  i &= (i-1)
        }
        
        return result
    }
    
    
    func LSB(_ num: Int) -> Int{
        num & -num
        //num & (num-1)       //num-i -> set lastbit 0
    }
}
