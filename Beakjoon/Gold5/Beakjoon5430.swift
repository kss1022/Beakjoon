//
//  Beakjoon5430.swift
//  Beakjoon
//
//  Created by 한현규 on 2/5/24.
//

import Foundation



class Beakjoon5430{
    
    func main(){
        let n = Int(readLine()!)!
        
        
        var functions = [([Character], [Int])]()
        
        
        for _ in 0..<n{
            let function : [Character] = readLine()!.compactMap { $0 }
            let _ = readLine()!
            var inputs = readLine()!
            inputs.removeFirst()
            inputs.removeLast()
            
            let nums = inputs.components(separatedBy: ",").compactMap(Int.init)
            
            
            functions.append((function, nums))
        }
        
        
        functions.forEach { acSolutoin(functions: $0.0, nums: $0.1) }
    }


    //R reverse
    //D drop
    func acSolutoin(functions: [Character], nums: [Int]){
            
        var isReverse = false
        var head = 0
        var tail = nums.count - 1
        
        for function in functions {
            if function == "R"{
                isReverse = !isReverse
                continue
            }
            
            
            if head > tail{
                print("error")
                return
            }
            
            
            if isReverse{
                tail -= 1
                continue
            }
            
            head += 1
        }
                
            
        
        if head > tail{
            print("[]")
            return
        }
        
        
        
        var result = nums[head...tail]
        
        if isReverse{
            result.reverse()
        }
            
        let joined = result.map(String.init)
            .joined(separator: ",")
        print("[\(joined)]")
    }


}
