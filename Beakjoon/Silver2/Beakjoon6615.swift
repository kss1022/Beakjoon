//
//  Beakjoon6615.swift
//  Beakjoon
//
//  Created by 한현규 on 1/2/24.
//

import Foundation


class Beakjoon6615{
    
    func run(){
        var results = [String]()
        
        while true{
            let nums = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
            
            let a = nums[0]
            let b = nums[1]
            
            if a == 0 || b == 0{
                break
            }
            
            results.append(collatzConflict(a, b))
        }
        
        for result in results {
            print(result)
        }
    }

    func collatzConflict(_ a: Int,_ b: Int) -> String{
        let doA = collatzs(a)
        let doB = collatzs(b)
     
        
        ///Back traking
        var i = doA.count - 1
        var j = doB.count - 1
        
        var count = 0
        
        while i >= 0 && j >= 0{
            if doA[i] != doB[j]{
                break
            }
            
            i -= 1
            j -= 1
            
            count += 1
        }
        //A needs SA steps, B needs SB steps, they meet at C"
        
        let aStep = doA.count - count
        let bStep = doB.count - count
        
        let value = doA[aStep]
        
        return "\(a) needs \(aStep) steps, \(b) needs \(bStep) steps, they meet at \(value)"
    }


    func collatzs(_ n : Int) -> [Int]{
        var collatzs = [Int]()
        collatzs.append(n)
        
        
        var temp = n
        while temp != 1{
            let next = collatz(temp)
            collatzs.append(next)
            temp = next
        }
        
        return collatzs
    }


    func collatz(_ n : Int) -> Int{
        if n % 2 == 0{
            return n / 2 //even
        }
        
        return n * 3 + 1 //odd
    }



}
