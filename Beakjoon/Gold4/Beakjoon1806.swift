//
//  Beakjoon1806.swift
//  Beakjoon
//
//  Created by 한현규 on 2/14/24.
//

import Foundation


class Beakjoon1806{
    
    func main(){
        let input = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
        
        let n = input[0]
        let sum = input[1]
        
        let nums = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
        
        partitionSum(nums: nums, n: n, minSum: sum)
    }

    func partitionSum(nums: [Int], n: Int, minSum: Int){
        var left = 0
        var right = 0
        
        var sum = nums[0]
        var result = Int.max
        
        while left <= right{
            if sum < minSum{
                if right >= n-1{
                    break
                }
                
                right += 1
                sum += nums[right]
                continue
            }
            
            result = min(result, (right - left + 1))
            sum -= nums[left]
            left += 1
        }
        
        if result == Int.max{
            print("0")
            return
        }
                
        print("\(result)")
    }

}
