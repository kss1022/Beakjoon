//
//  Beakjoon2156.swift
//  Beakjoon
//
//  Created by 한현규 on 1/9/24.
//

import Foundation


class Beakjoon2156{

    func main(){
        let n = Int(readLine()!)!
        
        var wines = [Int]()
        
        for _ in 0..<n{
            let wine = Int(readLine()!)!
            wines.append(wine)
        }
        
        let drinkMax = drinkMaxWine(wines: wines, n: n)
        print("\(drinkMax)")
    }


    func drinkMaxWine(wines: [Int], n: Int) -> Int{
        
        var dp = Array(repeating: 0, count: n)
        
        if n == 1{
            return wines[0]
        }
        
        if n == 2{
            return wines[0] + wines[1]
        }
        
        dp[0] = wines[0]
        dp[1] = wines[0] + wines[1]
        dp[2] = max(dp[1], dp[0] + wines[2], wines[1] + wines[2])
        
        if n == 3{
            return dp[2]
        }
        
        
        for i in 3..<n{
            dp[i] = max(dp[i-1], dp[i-2] + wines[i] , dp[i-3] + wines[i-1] + wines[i])
        }
        
        
        return dp[n-1]
    }

}
