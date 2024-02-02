//
//  Beakjoon2357.swift
//  Beakjoon
//
//  Created by 한현규 on 1/17/24.
//

import Foundation



class Beakjoon2357{
    
    func main(){
        let input = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        
        let n = input[0]
        let m = input[1]
        
        var nums = [UInt64]()
        
        for _ in 0..<n{
            let num = UInt64(readLine()!)!
            nums.append(num)
        }
        
        let root =  generateTreeRecursive(nums: nums, start: 0, end: n-1)
        
        var results = [(UInt64, UInt64)]()
        
        for _ in 0..<m{
            let pair = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
            let a = pair[0]
            let b = pair[1]
            
            let result = minMaxRecursive(node: root, start: a-1, end: b-1)
            results.append(result)
        }
        
        for result in results {
            print("\(result.0) \(result.1)")
        }
        
        print("\(root)")
    }

    func generateTreeRecursive(nums: [UInt64], start: Int, end: Int) -> Node{
        if start == end{
             let leafNode = Node(start: start, end: end, min: nums[start], max: nums[start])
            return leafNode
        }
        
        let mid = (start + end) / 2
        
        let left = generateTreeRecursive(nums: nums, start: start, end: mid)
        let right = generateTreeRecursive(nums: nums, start: mid+1, end: end)
        
        let rootNode = Node(start: left.start, end: right.end, min: min(left.min, right.min), max: max(left.max, right.max))
        rootNode.left = left
        rootNode.right = right
            
        return rootNode
    }


    func minMaxRecursive(node: Node?, start: Int, end: Int) -> (UInt64, UInt64){
        guard let node = node else { return (UInt64.max, UInt64.min) }
        if node.start >= start  && node.end <= end{ return (node.min, node.max) }
                
        let left = minMaxRecursive(node: node.left, start: start, end: end)
        let right = minMaxRecursive(node: node.right, start: start, end: end)
            
        return (min(left.0, right.0), max(left.1, right.1))
    }



    class Node{
        let start: Int
        let end: Int
        let min: UInt64
        let max: UInt64
        var left: Node?
        var right: Node?
        
        init(start: Int, end: Int, min: UInt64, max: UInt64) {
            self.start = start
            self.end = end
            self.min = min
            self.max = max
            self.left = nil
            self.right = nil
        }
    }

}
