//
//  Beakjoon2042.swift
//  Beakjoon
//
//  Created by 한현규 on 3/18/24.
//

import Foundation



class Beakjoon2042{

    func main(){
        let n = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let N = n[0]
        let M = n[1]
        let K = n[2]
        
        var nums = [Int]()
        
        for _ in 0..<N{
            let num = Int(readLine()!)!
            nums.append(num)
        }
        
        rangeSums(N, M, K, nums)
    }


    func rangeSums(_ n: Int, _ m: Int, _ k: Int, _ nums: [Int]){
        var changeCount = m
        var sumCount = k
        
        var nums = nums
            
        
        var tree = [Int: Int]() //index, sum
        createTreeRecursive(0, n-1, 0, &tree)
        
        
        while changeCount != 0 || sumCount != 0{
            let input = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            
                
            let isChange = input[0] == 1
            let b = input[1]
            let c = input[2]
            
            if isChange{
                changeNum(&tree, b-1, c)
                changeCount -= 1
                continue
            }
                            
            print(sum(tree, (b-1, c-1) ))
            sumCount -= 1
        }
        
     
        
        func createTreeRecursive(_ start: Int, _ end: Int, _ index: Int,_ tree: inout [Int: Int]){
            if start == end{
                tree[index] = nums[start]
                return
            }
            
            let mid = (start + end) / 2
            
            let leftIndex = (index+1) * 2 - 1
            let rightIndex = leftIndex + 1
            createTreeRecursive(start, mid, leftIndex, &tree)
            createTreeRecursive(mid+1, end, rightIndex, &tree)
            
            tree[index] = tree[leftIndex]! + tree[rightIndex]!
        }
        
        func changeNum(_ tree: inout [Int:Int], _ at: Int, _ newElement: Int){
            let diff = nums[at] - newElement
            changeNumRecursive(&tree, at, diff, 0, nums.count-1, 0)
            nums[at] = newElement
        }
        
        
        
        func changeNumRecursive(_ tree: inout [Int:Int], _ at: Int, _ diff: Int, _ start: Int, _ end: Int, _ index: Int){
            if !(start...end).contains(at){
                return
            }
            
            tree[index]! -= diff
            
            if start == end{
                return
            }
            
            let mid = (start + end) / 2
            
            let leftIndex = (index+1) * 2 - 1
            let rightIndex = leftIndex + 1
            changeNumRecursive(&tree, at, diff, start, mid, leftIndex)
            changeNumRecursive(&tree, at, diff, mid+1, end, rightIndex)
        }
        
        
        func sum(_ tree: [Int:Int], _ range: (Int, Int)) -> Int{
            return sumRecursive(0, nums.count-1, 0, tree, range)
        }
        
        func sumRecursive(_ start: Int, _ end: Int, _ index: Int , _ tree:  [Int: Int], _ range: (Int, Int)) -> Int{
            if end < range.0 || start > range.1{
                return 0
            }
            
            guard let sum = tree[index] else {
                return 0
            }
            
            if range.0 <= start && end <= range.1{
                return sum
            }
            
            let mid = (start + end) / 2
            
            let leftIndex = (index+1) * 2 - 1
            let rightIndex = leftIndex + 1
            let leftSum = sumRecursive(start, mid, leftIndex, tree, range)
            let rightSum = sumRecursive(mid+1, end, rightIndex, tree, range)
            return leftSum + rightSum
        }
        
    }



}
