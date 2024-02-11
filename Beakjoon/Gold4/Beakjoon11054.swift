//
//  Beakjoon11054.swift
//  Beakjoon
//
//  Created by 한현규 on 2/11/24.
//

import Foundation


class Beakjoon11054{
    func main(){
        let _ = Int(readLine()!)!
        
        var nums = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)

        biotonicSequenceLength(nums: nums)
    }


    func biotonicSequenceLength(nums: [Int]){
        
        let lis = LIS(nums: nums)
        let lds = LDS(nums: nums)
        
        var maxLength = 0
        
        for i in 0..<nums.count{
            maxLength = max(maxLength, lis[i] + lds[i] - 1)
        }
        print("\(maxLength)")
    }


    //Longest Increment Sequence
    func LIS(nums: [Int]) -> [Int]{
        var mem = Array.init(repeating: 1, count: nums.count)
            
        
        for i in 1..<nums.count{
            for j in stride(from: i-1, through: 0, by: -1){
                if nums[i] > nums[j]{
                    mem[i] = max(mem[i], mem[j] + 1)
                }
            }
        }
        
        return mem
    }

    //Longest Decrement Sequcne
    func LDS(nums: [Int]) -> [Int]{
        var mem = Array.init(repeating: 1, count: nums.count)
                

        for i in stride(from: nums.count, through: 0, by: -1){
            for j in i..<nums.count{
                if nums[i] > nums[j]{
                    mem[i] = max(mem[i], mem[j]+1)
                }
            }
        }
        
        return mem
    }




}
