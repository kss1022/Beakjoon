//
//  Beakjoon11053.swift
//  Beakjoon
//
//  Created by 한현규 on 2/4/24.
//

import Foundation




class Beakjoon11053{
    func main(){
        let n = Int(readLine()!)!
        let inputs = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        
        lcm(nums: inputs, n: n)
    }


    func lcm(nums: [Int], n: Int){
        var arrays = [Int]()
        arrays.append(nums[0])
        
        for i in 1..<nums.count{
            let num = nums[i]
            
            if arrays.last! < num{
                arrays.append(num)
                continue
            }
            
            let index = searchMinIndex(arrays: arrays, num: num)
            arrays[index] = num
        }
        
        print(arrays.count)
    }


    func searchMinIndex(arrays: [Int], num: Int) -> Int{
        
        var start = 0
        var end = arrays.count-1
        
        var index = 0
        
        while start <= end{
            let mid = (start + end) / 2
            
            if arrays[mid] >= num{
                index = mid
                end = mid - 1
                continue
            }

            start = mid + 1
        }
        
        
        return index
    }


}
    
