//
//  Beakjoon16563.swift
//  Beakjoon
//
//  Created by 한현규 on 4/12/24.
//

import Foundation



class Beakjoon16563{
    
    func main(){
        let n = Int(readLine()!)!
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        //let max = nums.max()!
        let primes = eratos(5000000, 2357)
        
        for i in 0..<n{
            var result = ""
            primeFactorizationRecursive(nums[i], primes, &result)
            print(result)
        }
    }


    /// 8
    /// P[8] -> 2
    /// P[4] -> 2
    /// P[2] -> 2  (n == P[n]) finish

    func primeFactorizationRecursive(_ num: Int, _ path: [Int], _ result: inout String){
        if num == 1{
            return
        }
        
        result += "\(path[num]) "
        
        let dividen = num / path[num]
        primeFactorizationRecursive(dividen, path, &result)
    }




    func eratos(_ n : Int, _ maxPrime: Int) -> [Int]{
        var paths = Array.init(repeating: 0, count: n+1)
        for i in 0...n{
            paths[i] = i
        }

        for i in 2...maxPrime{
            if paths[i] != i{
                continue
            }
            
            for j in stride(from: i+i, through: n, by: i){
                if paths[j] == j{
                    paths[j] = i
                }
            }
        }
        
        return paths
    }
}
