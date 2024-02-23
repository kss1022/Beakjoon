//
//  Beakjoon1644.swift
//  Beakjoon
//
//  Created by 한현규 on 2/23/24.
//

import Foundation



class Beakjoon1644{

    func main(){
        let n = Int(readLine()!)!
        sumOfPrime(n)
    }

    func sumOfPrime(_ n: Int){
        if n == 1{
            print("0")
            return
        }
        
        var result = 0
        
        let primes = eratos(n)
        
        var left = 0
        var right = 0
        
        var sum = 0
        sum += primes[0]
        
        while left <= right && right < primes.count{
            if sum == n{
                moveRight()
                checkSum()
                continue
            }
            
            if sum > n{
                moveLeft()
                checkSum()
                continue
            }
                    
            //sum < n
            moveRight()
            checkSum()
            continue
        }
        
        
        print("\(result)")
        
        func moveRight(){
            right += 1
            if right < primes.count{
                sum += primes[right]
            }
        }

        func moveLeft(){
            sum -= primes[left]
            left += 1
        }
        
        func checkSum(){
            if sum == n{
                result += 1
                moveLeft()
            }
        }
        
    }


    func eratos(_ n : Int) -> [Int]{
        var isPrimes = Array.init(repeating: true, count: n+1)
                
        for i in 0...1{
            isPrimes[i] = false
        }
        
        var i = 2
        while i  * i <= n{
            if !isPrimes[i]{
                i += 1
                continue
            }
            
            
            for j in stride(from: i * 2, through: n, by: i){
                isPrimes[j] = false
            }
            
            i += 1
        }
        
        
        return  isPrimes.enumerated()
            .filter { $0.element }
            .map { $0.offset }
    }

}
