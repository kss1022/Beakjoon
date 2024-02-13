//
//  Beakjoon17298.swift
//  Beakjoon
//
//  Created by 한현규 on 2/13/24.
//

import Foundation


class Beakjoon17298{
    func main(){
        let n = Int(readLine()!)!
        
        let nums = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
        nge(n: n, nums: nums)
    }




    func nge(n: Int, nums: [Int]){
        var nges = Array.init(repeating: -1, count: n)
        
        
        
        var stack = [Int]()
        stack.append(nums[n-1])
        
        for i in stride(from: n-2, through: 0, by: -1){
            
            while !stack.isEmpty{
                let pop = stack.removeLast()
                if nums[i] < pop{
                    nges[i] = pop
                    stack.append(pop)
                    break
                }
            }
            
            stack.append(nums[i])
        }

        
        let result = nges.map(String.init)
            .joined(separator: " ")
        print(result)
    }

}
