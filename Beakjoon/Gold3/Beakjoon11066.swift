//
//  Beakjoon11066.swift
//  Beakjoon
//
//  Created by 한현규 on 2/27/24.
//

import Foundation



class Beakjoon11066{
    
    func main(){
        let testCases =  Int(readLine()!)!
        
        for _ in 0..<testCases{
            priceSumOfFiles()
        }
    }


    func priceSumOfFiles(){
        let n = Int(readLine()!)!
        
        let files = readLine()!.split(separator: " ")
            .compactMap { Int(String($0))! }
        
        
        var dp = Array.init(
            repeating: Array.init(repeating: [0, 0], count: n+1),       // sum , totalSum
            count: n+1
        )
        
        for i in 1...n{
            dp[i][i][0] = files[i-1]
        }
        
        for distance in 1..<n{
            for start in 1...n-distance{
                let end = start + distance
                dp[start][end][0] = Int.max
                dp[start][end][1] = Int.max
                
                for mid in start..<end{
                    let sum = dp[start][mid][0] + dp[mid+1][end][0]
                    let totalSum = sum + dp[start][mid][1] + dp[mid+1][end][1]
                                    
                    if dp[start][end][1] < totalSum {
                        continue
                    }
                    
                    
                    dp[start][end][0] = sum
                    dp[start][end][1] = sum + dp[start][mid][1] + dp[mid+1][end][1]
                }
            }
        }
        
        print(dp[1][n][1])
    }

}
