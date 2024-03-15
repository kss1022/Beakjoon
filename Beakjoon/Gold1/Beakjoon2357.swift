//
//  Beakjoon2357.swift
//  Beakjoon
//
//  Created by 한현규 on 1/17/24.
//

import Foundation



class Beakjoon2357{
    
    func main(){
        let n = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let N = n[0]
        let M = n[1]
        
        var nums = [Int]()
        nums.reserveCapacity(N)
        
        for _ in 0..<N{
            let num = Int(readLine()!)!
            nums.append(num)
        }
        
        var ranges = [(Int, Int)]()
        
        for _ in 0..<M{
            let range = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            ranges.append((range[0]-1, range[1]-1))
        }
        minMax(N, M, nums, ranges)
    }


    typealias Node = (min: Int, max: Int)

    func minMax(_ N: Int, _ m: Int, _ nums: [Int], _ ranges: [(Int, Int)]){
        var tree = [Int: Node]()
        
        generateTreeRecursive(start: 0, end: nums.count-1, index: 0)
        
        ranges.forEach { range in
            let result = minMaxRecursive(index: 0, start: 0, end: nums.count-1, range: range)
            print("\(result.0) \(result.1)")
        }
        
        func generateTreeRecursive(start: Int, end: Int, index: Int){
            if start == end{
                tree[index] = Node(nums[start], nums[start])
                return
            }
            
            let leftIndex = (index+1) * 2 - 1
            let rightIndex = leftIndex + 1
            
            let mid = (start + end) / 2
            
            
            generateTreeRecursive(start: start, end: mid, index: leftIndex)   //left
            generateTreeRecursive(start: mid+1, end: end, index: rightIndex)   //right
            
            let left = tree[leftIndex]!
            let right = tree[rightIndex]!
            
            tree[index] = Node(
                min(left.min, right.min),
                max(left.max, right.max)
            )
        }
        
        func minMaxRecursive(index: Int, start: Int, end: Int,  range: (Int, Int)) -> (Int,Int){
            if range.1 < start || end < range.0{
                return (Int.max, Int.min)
            }
            
            guard let node = tree[index] else {
                return (Int.max, Int.min)
            }
            if range.0 <= start  && end <= range.1{
                return (node.min, node.max)
            }
            
            
            let leftIndex = (index+1) * 2 - 1
            let rightIndex = leftIndex + 1
            
            let mid = (start + end) / 2
            
            let left = minMaxRecursive(index: leftIndex, start: start, end: mid, range: range)
            let right = minMaxRecursive(index: rightIndex, start: mid+1, end: end, range: range)
            
            return (min(left.0, right.0),max(left.1, right.1))
        }
        
    }
    
    
}



//func generateTreeRecursive(nums: [UInt64], start: Int, end: Int) -> Node{
//    if start == end{
//         let leafNode = Node(start: start, end: end, min: nums[start], max: nums[start])
//        return leafNode
//    }
//    
//    let mid = (start + end) / 2
//    
//    let left = generateTreeRecursive(nums: nums, start: start, end: mid)
//    let right = generateTreeRecursive(nums: nums, start: mid+1, end: end)
//    
//    let rootNode = Node(start: left.start, end: right.end, min: min(left.min, right.min), max: max(left.max, right.max))
//    rootNode.left = left
//    rootNode.right = right
//        
//    return rootNode
//}
//
//
//func minMaxRecursive(node: Node?, start: Int, end: Int) -> (UInt64, UInt64){
//    guard let node = node else { return (UInt64.max, UInt64.min) }
//    
//    if end < node.start || node.end < start{
//        return (UInt64.max, UInt64.min)
//    }
//            
//    if node.start >= start  && node.end <= end{ return (node.min, node.max) }
//            
//    let left = minMaxRecursive(node: node.left, start: start, end: end)
//    let right = minMaxRecursive(node: node.right, start: start, end: end)
//        
//    return (min(left.0, right.0), max(left.1, right.1))
//}
//
//
//
//class Node{
//    let start: Int
//    let end: Int
//    let min: UInt64
//    let max: UInt64
//    var left: Node?
//    var right: Node?
//    
//    init(start: Int, end: Int, min: UInt64, max: UInt64) {
//        self.start = start
//        self.end = end
//        self.min = min
//        self.max = max
//        self.left = nil
//        self.right = nil
//    }
//}
//
//
//
