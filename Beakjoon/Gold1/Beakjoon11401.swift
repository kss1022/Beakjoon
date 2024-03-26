//
//  Beakjoon11401.swift
//  Beakjoon
//
//  Created by 한현규 on 3/26/24.
//

import Foundation



class Beakjoon11401{

    func main(){
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        let n = nums[0]
        let k = nums[1]
        bionomialDivide(n, k, 1000000007)
    }

    func bionomialDivide(_ n: Int, _ k: Int, _ divide: Int){
        if k == 0{
            print(1)
            return
        }
        
        if k == 1{
            print(n % divide)
            return
        }
        
        
        var top = 1
        var bottom = 1
        
        for i in 1...n{
            top *= i
            top %= divide
        }
        
        for i in 1...k{
            bottom *= i
            bottom %= divide
        }
            
        for i in 1...(n-k){
            bottom *= i
            bottom %= divide
        }
        
        
        let result = top * power(bottom, divide-2, divide)
        print(result % divide)
    }





    func binomailDivideRecursive(_ n: Int, _ k: Int, _ divide: Int, _ mem: inout [[Int]]) -> Int{
        if k == 0 || n == k{
            return 1
        }
        
        if mem[n][k] != -1{
            return mem[n][k]
        }
        
        mem[n][k] =  (binomailDivideRecursive(n-1, k, divide, &mem) + binomailDivideRecursive(n-1, k-1, divide, &mem)) % divide
        return mem[n][k]
    }






    ///nCk = n! / (n-k)!k!
    func binomial1(_ n : Int, _ k: Int) -> Int{
        let dividend = factorial(n)
        let divisor = factorial(n-k) * factorial(k)
        return dividend / divisor
    }

    func factorial(_ n : Int) -> Int{
        if n == 1{
            return 1
        }
        return factorial(n-1) * n
    }


    func binomial2(_ n : Int, _ k: Int) -> Int{
        //dp
        if k == 0 || n == k{
            return 1
        }
        
        return binomial2(n-1, k) + binomial2(n-1, k-1)
    }


    func binomial3(_ n : Int, _ k: Int) -> Int{
        var cache = Array.init(
            repeating: Array.init(repeating: -1, count: n+1),
            count: n+1
        )
        
        
        func choose(_ times: Int, _ get: Int) -> Int{
            if times == n{
                return get == k ? 1 : 0
            }
            
            if cache[times][get] != -1{
                return cache[times][get]
            }
            
            cache[times][get] = choose(times+1, get) + choose(times+1, get+1)
            return cache[times][get]
        }
                
        return choose(0, 0)
    }



    func power(_ num: Int, _ exponent: Int, _ divisor: Int) -> Int{
        if exponent == 1{
            return num % divisor
        }
        
        //a^b = a^(b/2) * a^(b/2)
        let result = power(num, exponent / 2 , divisor)
        if exponent % 2 == 1{
            return ( ((result * result) % divisor) * num ) % divisor
        }
        
        return (result * result) % divisor
    }

}
