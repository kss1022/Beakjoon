//
//  Beakjoon11049.swift
//  Beakjoon
//
//  Created by 한현규 on 2/27/24.
//

import Foundation



class Beakjoon11049{

    func main(){
        let n = Int(readLine()!)!
        
        var matrixs = [(Int, Int)]()
        matrixs.append((0, 0))
        matrixs.reserveCapacity(n+1)
                
        
        for _ in 1...n{
            let matrix = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            matrixs.append( (matrix[0], matrix[1]) )
        }
        
        calculationCount(n, matrixs)
    }




    func calculationCount(_ n: Int, _ matrixs: [(row: Int,col:  Int)]){
        var dp = Array.init(
            repeating: Array.init(repeating: 0, count: n+1),
            count: n+1
        )
            
        
        for distance in 1..<n{
            for start in 0...(n-distance){
                
                let end = start + distance
                dp[start][start+distance] = Int.max
                
                for mid in start..<end{
                    let front = dp[start][mid] //front
                    let back = dp[mid+1][end] //back
                    let last = matrixs[start].row * matrixs[mid].col * matrixs[end].col
                    
                    dp[start][start+distance] = min(dp[start][start+distance], front + back + last)
                }
            }
        }
        
        print(dp[1][n])
    }

}
