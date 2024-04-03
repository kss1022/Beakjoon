//
//  Beakjoon1275.swift
//  Beakjoon
//
//  Created by 한현규 on 4/3/24.
//

import Foundation



class Beakjoon1275{
    func main(){
        let input = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        //(1 ≤ N, Q ≤ 100,000)
        let n = input[0]
        let q = input[1]
        
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        var commands = [(Int,Int,Int,Int)]()        //x~y sum   swap(at: a, b)
        for _ in 0..<q{
            let command = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            commands.append((command[0],command[1],command[2],command[3]))
        }
        
        coffeeshop(n, q, nums, commands)
    }


    func coffeeshop(_ n: Int, _ q: Int, _ nums: [Int], _ commands: [(Int,Int,Int,Int)]){
        var nums = nums
        var tree = [Int: Int]()
        
        generateSegmentTree(0, nums.count-1, 0, &tree, nums)
       
        
        for command in commands {
            let x = command.0 - 1
            let y = command.1 - 1
            let a = command.2 - 1
            let b = command.3
                        
            print(rangeSumsRecursive(0, nums.count-1, 0, tree, x > y ? (y, x) : (x, y)))
            swapAt(&nums, &tree, a, b)
        }
    }


    func generateSegmentTree(_ start: Int, _ end: Int, _ index: Int, _ tree: inout [Int: Int], _ nums: [Int]){
        if start == end{
            tree[index] = nums[start]
            return
        }
        
        let mid = (start+end) / 2
        
        let leftIndex = (index+1) * 2 - 1
        let rightIndex = leftIndex + 1
        
        generateSegmentTree(start, mid, leftIndex, &tree, nums)
        generateSegmentTree(mid+1, end, rightIndex, &tree, nums)
                
        tree[index] = tree[leftIndex]! + tree[rightIndex]!
    }

    func rangeSumsRecursive(_ start: Int, _ end: Int, _ index: Int, _ tree: [Int: Int], _ range: (Int, Int)) -> Int{
        if start > range.1 || end < range.0{
            return 0
        }
        
        guard let sum = tree[index] else {
            return 0
        }
        
        
        if start >= range.0 && end <= range.1{
            return sum
        }
        
        let mid = (start+end) / 2

        let leftIndex = (index+1) * 2 - 1
        let rightIndex = leftIndex + 1
        
        return  rangeSumsRecursive(start, mid, leftIndex, tree, range) + rangeSumsRecursive(mid+1, end, rightIndex, tree, range)
    }

    func swapAt(_ nums: inout [Int], _ tree: inout [Int: Int],_ at: Int, _ element: Int){
        let diff = element - nums[at]
        nums[at] = element
        swapAtTreeRecursive(&tree, at, diff, 0, nums.count-1, 0)
    }

    func swapAtTreeRecursive(_ tree: inout [Int: Int], _ at: Int, _ diff: Int,_ start: Int, _ end: Int, _ index: Int){
        if !(start...end).contains(at){
            return
        }
        tree[index]! += diff
            
        if start == end{
            return
        }
                
        let mid = (start+end) / 2
        
        let leftIndex = (index+1) * 2 - 1
        let rightIndex = leftIndex + 1
        swapAtTreeRecursive(&tree, at, diff, start, mid, leftIndex)
        swapAtTreeRecursive(&tree, at, diff, mid+1, end, rightIndex)
    }

}
