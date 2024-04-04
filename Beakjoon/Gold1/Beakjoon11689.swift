//
//  Beakjoon11689.swift
//  Beakjoon
//
//  Created by 한현규 on 4/4/24.
//

import Foundation



class Beakjoon11689{
    func main(){
        let n = Int(readLine()!)!
        Eulerphi(n)
    }

    ///GCD(n, k) == 1
    /// 1 <= k <= n

    /// p -> prime
    /// e(p) = p(1 -  1/p)
    /// e(p^n) =  p^(n-1)  * (p-1)
    ///
    /// /// e(mn) = e(m) * e(n)

    func Eulerphi(_ n: Int){
        let maxNum = min(Int(pow(10.0, 6.0)), n)     // 10^6
        let primes = eratos(maxNum)
                
        let primeFactors = getPrimeFactors(n, primes)
        print(Eulerphi(n, primeFactors))
    }


    func Eulerphi(_ n: Int, _ primeFactors: [Int]) -> Int{
        var result = 1
        
        var temp = n
        
        for primeFactor in primeFactors {
            var e = 0
                    
            while true{
                if temp % primeFactor != 0{
                    break
                }
                temp /= primeFactor
                e += 1
            }
                    
            let euler = EulerPhi(primeFactor, e)
            result *= euler
        }
        
        //temp is Prime
        if temp > 1{
            result *= EulerPhi(temp, 1)
        }
        
        return result
    }


    func EulerPhi(_ prime: Int, _ e: Int) -> Int{
        if e == 1{
            return prime - 1
        }
            
        return Int(pow(Double(prime), Double(e-1))) * (prime-1)
    }


    func eratos(_ n: Int) -> [Int]{
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


    //2*3*5*7*11*13*17*19*23*29*31 < 10^12
    //2*3*5*7*11*13*17*19*23*29*31*37 > 10^12
    func getPrimeFactors(_ n: Int, _ primes: [Int]) -> [Int]{
        var result = [Int]()
        for i in 0..<primes.count{
            let prime = primes[i]
            if n % prime == 0{
                result.append(prime)
            }
        }
        
        return result
    }

}
