//
//  Beakjoon14888.swift
//  Beakjoon
//
//  Created by 한현규 on 1/15/24.
//

import Foundation


final class Beakjoon14888{
    func main(){
        let _ = Int(readLine()!)!
        let nums = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        let operators = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        
        printMaxAndMinResult(nums: nums, operators: operators)
    }

    func printMaxAndMinResult(nums: [Int], operators: [Int]){
        var maxSum = Int.min
        var minSum = Int.max
                
        //bfs
        var queue = [(Int, Int,[Int])]() // sum , numberPos, [+, - , * , /]
        queue.append((nums[0], 0, operators))
        
        while !queue.isEmpty{
            let deQueue = queue.removeFirst()
            
            
            let sum = deQueue.0
            let pos = deQueue.1
            let operators = deQueue.2
            
            
            if pos == nums.count - 1{
                maxSum = max(sum, maxSum)
                minSum = min(sum, minSum)
                continue
            }
            
            
            let next = nums[pos+1]
            
            for i in 0..<operators.count {
                if operators[i] == 0{
                    continue
                }
                
                var newSum = 0
                var newOpers = operators
                if i == 0{
                    //plus
                    newSum = sum + next
                    newOpers[0] -= 1
                }else if i == 1{
                    //minus
                    newSum = sum - next
                    newOpers[1] -= 1
                }else if i == 2{
                    //multiple
                    newSum = sum * next
                    newOpers[2] -= 1
                }else if i == 3{
                    //divide
                    newSum = sum / next
                    newOpers[3] -= 1
                }
                queue.append((newSum, pos + 1, newOpers))
            }
        }
        
        print("\(maxSum)")
        print("\(minSum)")
    }

}
