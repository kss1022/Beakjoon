//
//  Beakjoon17103.swift
//  Beakjoon
//
//  Created by 한현규 on 1/2/24.
//

import Foundation



class Beakjoon17103{
    
    
    
    func run(){
        let n = Int(readLine()!)!
        
            
        var nums = [Int]()
        for _ in 0..<n{
            let num = Int(readLine()!)!
            nums.append(num)
        }
        
        
        let max = nums.max()!
        let primes = eratos(max - 1)
        
        for num in nums {
            let goldbach = goldbach(num, primes.filter{ $0 < num })
            print("\(goldbach)")
        }
    }
    
    func goldbach(_ n : Int,_ primes: [Int]) -> Int{
        var result = 0
        
        var left = 0
        var right = primes.count-1
        while left <= right{
            let sum = primes[left] + primes[right]
            
            if sum > n{
                right -= 1
            }else if sum < n{
                left += 1
            }else{
                //find
                result += 1
                
                left += 1
            }
        }
        
        return result
    }
    
    func eratos(_ n: Int) -> [Int]{
        var prime = Array.init(repeating: true, count: n+1)
        
        prime[0] = false
        prime[1] = false
        
        var i = 2
        
        while i * i <= n{
            if prime[i] == false{
                i += 1
                continue
            }
            
            
            for j in stride(from: i*2, to: n, by: i){
                prime[j] = false
            }
            
            i += 1
        }
                        
        return prime.enumerated().filter { (index, isPrime) in
            isPrime
        }.map { (index, isPrime) in
            index
        }
    }

}





