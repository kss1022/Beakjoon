//
//  Beakjoon7453.swift
//  Beakjoon
//
//  Created by 한현규 on 3/13/24.
//

import Foundation



class Beakjoon7453{
    
    func main(){
        let n = Int(readLine()!)!
        
        var a = [Int]()
        var b = [Int]()
        var c = [Int]()
        var d = [Int]()
        
        a.reserveCapacity(n)
        b.reserveCapacity(n)
        c.reserveCapacity(n)
        d.reserveCapacity(n)
        
        for _ in 0..<n{
            let row = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            
            a.append(row[0])
            b.append(row[1])
            c.append(row[2])
            d.append(row[3])
        }
        
        zeroSum2(n: n, a: a, b: b, c: c, d: d)
    }

    func zeroSum(n: Int, a: [Int], b: [Int], c: [Int], d: [Int]){
        var aSumB = [Int]()
        var cSumD = [Int]()
        
        
        for i in 0..<n{
            for j in 0..<n{
                aSumB.append(a[i] + b[j])
                cSumD.append(c[i] + d[j])
            }
        }
        
        aSumB.sort()
        cSumD.sort()
        
        print(twoPointer())
        
        
        
        func twoPointer() -> Int{
            var result = 0
            
            var i = 0
            var j = cSumD.count-1
            
            //i ++ : sum is increment
            //j --: sum is decrement
            
            while i < aSumB.count && j >= 0 {
                let left = aSumB[i]
                let right = cSumD[j]
                let sum = left + right
                
                if  sum > 0 {
                    j -= 1
                    continue
                }
                
                if sum < 0 {
                    i += 1
                    continue
                }
                                                    
                var increase = 0, decrease = 0
                while i < aSumB.count && aSumB[i] == left {
                    i += 1
                    increase += 1
                }
                
                while j >= 0 && cSumD[j] == right {
                    j -= 1
                    decrease += 1
                }
                result += increase * decrease
            }
            
            return result
        }
        
        
    }



    func zeroSum2(n: Int, a: [Int], b: [Int], c: [Int], d: [Int]){
        var sums = [Int: Int]()
        
        for i in 0..<n{
            for j in 0..<n{
                let aSumB = a[i] + b[j]
                sums[aSumB] = (sums[aSumB] ?? 0 ) + 1
            }
        }
        
        var result = 0
        for i in 0..<n{
            for j in 0..<n{
                let cSumD = -(c[i] + d[j])
                result += (sums[cSumD] ?? 0)
            }
        }
        
        print(result)
    }

}
