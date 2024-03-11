//
//  Beakjoon12738.swift
//  Beakjoon
//
//  Created by 한현규 on 3/11/24.
//

import Foundation



class Beakjoon12738{
    func main(){
        let n = Int(readLine()!)!
        
        let nums = readLine()!.split(separator: " ")
            .compactMap{ Int(String($0)) }
        LIS(n, nums)
    }


    func LIS(_ n: Int, _ nums: [Int]){
        
        var sequences = [Int]()
        sequences.append(nums[0])
        
        for i in 1..<n{
            if sequences.last! < nums[i]{
                sequences.append(nums[i])
                continue
            }
            
            let index = searchIndex(sequences, nums[i])
            sequences[index] = nums[i]
        }
        
        print(sequences.count)
        
        
        
        func searchIndex(_ sorted: [Int], _ num: Int) -> Int{
            var left = 0
            var right = sorted.count - 1
            
            var result = 0
            
            while left <= right{
                let mid = (left+right)/2
                
                if sorted[mid] >= num{
                    //search left
                    right = mid - 1
                    result = mid
                    continue
                }
                
                
                //search right
                left = mid + 1
            }
            
            
            return result
        }
    }

}
