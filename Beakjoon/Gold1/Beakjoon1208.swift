//
//  Beakjoon1208.swift
//  Beakjoon
//
//  Created by 한현규 on 3/29/24.
//

import Foundation



class Beakjoon1208{
    func main(){
        let input = readLine()!.split(separator: " ")
            .compactMap{ Int(String($0)) }
        
        let n = input[0]
        let sum = input[1]
        
        let nums = readLine()!.split(separator: " ")
            .compactMap{ Int(String($0)) }
        
        subSequenceSums(n, nums, sum)
    }

    func subSequenceSums(_ n: Int, _ nums: [Int], _ sum: Int){
        var sums = [Int:Int]()
        
        var result = 0
        leftSum(0, 0, nums, &sums)
        rightSum(nums.count / 2, 0, &result, nums, sum, sums)
        
        if sum == 0{
            result -= 1
        }
        
        print(result)
    }

    //key: sum, value: count
    func leftSum(_ i: Int, _ sum: Int, _ nums: [Int], _ sums: inout [Int:Int]){
        if i == nums.count / 2{
            sums[sum] = (sums[sum] ?? 0) + 1
            return
        }
        
        leftSum(i + 1, sum, nums, &sums)
        leftSum(i + 1, sum + nums[i], nums, &sums)
    }


    func rightSum(_ i: Int, _ currentSum: Int, _ result: inout Int, _ nums: [Int], _ sum: Int, _ sums: [Int:Int]){
        if i == nums.count{
            result += sums[sum-currentSum] ?? 0
            return
        }

        rightSum(i + 1, currentSum, &result, nums, sum, sums)
        rightSum(i + 1, currentSum + nums[i], &result, nums, sum, sums)
    }

}
