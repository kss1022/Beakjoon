//
//  Beakjoon10868.swift
//  Beakjoon
//
//  Created by 한현규 on 3/25/24.
//

import Foundation



final class Beakjoon10868{

    func main(){
        let NM = readLine()!.split(separator: " ")
            .compactMap {
                Int(String($0))
            }
        
        let N = NM[0]
        let M = NM[1]
        
        var nums = [Int]()
        for _ in 0..<N{
            nums.append(Int(readLine()!)!)
        }
        
        var ranges = [(Int, Int)]()
        for _ in 0..<M{
            let range = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            ranges.append((range[0]-1, range[1]-1))
        }
        
        minNumInRanges(N, M, nums, ranges)
            
    }


    func minNumInRanges(_ N: Int, _ M: Int, _ nums: [Int], _ ranges: [(Int, Int)]){
        var tree = [Int: Int]()
        
        generateSegmentTreeRecursive(0, N-1, 0)
        
        
        for range in ranges {
            print(minNumInRange(0, N-1, 0, range: range))
        }
            
        func generateSegmentTreeRecursive(_ left: Int, _ right: Int, _ index: Int){
            if left == right{
                tree[index] = nums[left]
                return
            }
            
            let mid = (left + right) / 2
            
            let leftIndex = (index + 1) * 2 - 1
            let rightIndex = leftIndex + 1
            
            generateSegmentTreeRecursive(left, mid, leftIndex)
            generateSegmentTreeRecursive(mid+1, right, rightIndex)

            tree[index] = min(tree[leftIndex]!, tree[rightIndex]!)
        }
        
        func minNumInRange(_ left: Int, _ right: Int, _ index: Int, range: (start: Int, end: Int)) -> Int{
            if left > range.end || right < range.start{
                return Int.max
            }
                    
            if left >= range.start && right <= range.end{
                return tree[index]!
            }
            
            let mid = (left + right) / 2
            let leftIndex = (index + 1) * 2 - 1
            let rightIndex = leftIndex + 1
            
            let leftMin =  minNumInRange(left, mid, leftIndex, range: range)
            let rightMin = minNumInRange(mid+1, right, rightIndex, range: range)
            
            return min(leftMin, rightMin)
        }
    }





}
