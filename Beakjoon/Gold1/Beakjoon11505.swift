//
//  Beakjoon11505.swift
//  Beakjoon
//
//  Created by 한현규 on 3/27/24.
//

import Foundation


class Beakjoon11505{

    func main(){
        let n = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let N = n[0]
        let M = n[1]
        let K = n[2]
        
        var nums = [Int]()
        
        for _ in 0..<N{
            nums.append(Int(readLine()!)!)
        }
        
        rangeProducts(N, M, K, nums, 1000000007)
    }

    func rangeProducts(_ n: Int, _ m: Int, _ k: Int, _ nums: [Int], _ divisor: Int){
        var tree = [Int:Int]()
        
        
        generateTreeRecursive(0, n-1, 0, &tree, nums, divisor)
        
        
        
        for _ in 0..<(m+k){
            let command = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            
            let b = command[1]
            let c = command[2]
            
            if command[0] == 1{
                changeNum(b-1, c, nums, &tree, divisor)
            }else{
                
                print(rangeProductRecursive(0, n-1, (b-1,c-1), 0, tree, divisor))
            }
        }
        
        
        
       
    }

    func generateTreeRecursive(_ start: Int, _ end: Int, _ index: Int, _ tree: inout [Int: Int], _ nums: [Int], _ divisor: Int){
        if start == end{
            tree[index] = nums[start]
            return
        }
        
        let mid = (start+end) / 2
        
        let leftIndex = (index+1) * 2 - 1
        let rightIndex = leftIndex + 1
        
        generateTreeRecursive(start, mid, leftIndex, &tree, nums, divisor)
        generateTreeRecursive(mid+1, end, rightIndex, &tree, nums, divisor)
        
        tree[index] = ((tree[leftIndex]! % divisor) * (tree[rightIndex]! % divisor)) % divisor
    }


    func changeNum(_ at: Int , _ newElement: Int, _ nums:  [Int], _ tree: inout [Int: Int], _ divisor: Int){
        func changeNumRecursive(_ start: Int, _ end: Int, _ index: Int){
            if !(start...end).contains(at){
                return
            }
            
            if start == end{
                tree[index] = newElement
                return
            }
                            
            let mid = (start + end) / 2
            
            let leftIndex = (index+1) * 2 - 1
            let rightIndex = leftIndex + 1
            
            changeNumRecursive(start, mid, leftIndex)
            changeNumRecursive(mid+1, end, rightIndex)
            
            tree[index] = ( (tree[leftIndex]! % divisor) * (tree[rightIndex]! % divisor)) % divisor
        }
        
        changeNumRecursive(0, nums.count-1, 0)

    }



    func rangeProductRecursive(_ start: Int, _ end: Int, _ range: (Int, Int), _ index: Int, _ tree: [Int: Int], _ divisor: Int) -> Int{
        if start > range.1 || end < range.0{
            return 1
        }
        
        guard let product = tree[index] else {
            return 1
        }
         
        if start >= range.0 && end <= range.1{
            return product
        }
        
        let mid = (start + end) / 2
        
        let leftIndex = (index+1) * 2 - 1
        let rightIndex = leftIndex +  1
        return ( rangeProductRecursive(start, mid, range, leftIndex, tree, divisor) * rangeProductRecursive(mid+1, end, range, rightIndex, tree, divisor) ) % divisor
    }

}
