//
//  Beakjoon1149.swift
//  Beakjoon
//
//  Created by 한현규 on 1/8/24.
//

import Foundation


///
///     26 40 83
///     49 60 57
///     13 89 99
///     r       g       b
///
/// 0   26      40      83
///
/// 1   min(0.g, 0.b) + 49  min(0.r, 0.b) + 60  min(0.r, 0.g) + 57
///
/// 2   min(1.g, 1.b) + 13  min(1.r, 1.b) + 89  min(1.r, 1.g) + 99
///



class Beakjoon1149{
    func main(){
        let n = Int(readLine()!)!
        
        var prices = [(Int, Int, Int)]()
        
        for _ in 0..<n{
            let price = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
            prices.append((price[0], price[1], price[2]))
        }
        
        let result = mimimumCost(prices: prices, n: n)
        print(result)
    }

    func mimimumCost(prices: [(Int, Int, Int)], n: Int) -> Int{
        
        var cache = [(Int, Int, Int)]()
        
        cache.append(prices[0])
        
        
        for i in 1..<n{
            let before = cache[i-1]
            
            let current = prices[i]
            
            let r = min(before.1, before.2) + current.0
            let g = min(before.0, before.2) + current.1
            let b = min(before.0, before.1) + current.2
            
            cache.append((r,g,b))
        }
        
        
        let result = cache.last!
        return min(result.0, result.1, result.2)
    }

}
