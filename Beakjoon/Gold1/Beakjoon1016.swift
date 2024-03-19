//
//  Beakjoon1016.swift
//  Beakjoon
//
//  Created by 한현규 on 3/19/24.
//

import Foundation



class Beakjoon1016{
    func main(){
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let min = nums[0]
        let max = nums[1]
        
        nonoSquare(min, max)
    }

    func nonoSquare(_ min: Int, _ max: Int){
        let primes = eratos(Int(sqrt(Double(max))))
        let squares = squares(primes)
            
        var ranges = Array.init(repeating: true, count: max-min+1)  ////0: min , max-min: max
        for square in squares{
            var multiplier = min / square
            if min % square != 0{
                multiplier += 1
            }
            
            for i in stride(from: multiplier*square, through: max, by: square){
                ranges[i-min] = false
            }
        }
        print(ranges.filter { $0 }.count)
    }

    func isNonoSquare(_ num: Int, _ squares: [Int]) -> Bool{
        for square in squares {
            if num % square == 0{
                return false
            }
        }
        return true
    }


    func squares(_ primes: [Int]) -> [Int]{
        primes.map { $0 * $0 }
    }

    func eratos(_ max: Int) -> [Int]{
        var isPrimes = Array.init(repeating: true, count: max+1)
        
        isPrimes[0] = false
        isPrimes[1] = false
        
        var i = 2
        
        while i * i < max{
            if !isPrimes[i]{
                i += 1
                continue
            }
            
            for j in stride(from: i * 2, through: max, by: i){
                isPrimes[j] = false
            }
            
            i += 1
        }
        
        return isPrimes.enumerated()
            .filter { $0.element }
            .map { $0.offset }
    }

}
