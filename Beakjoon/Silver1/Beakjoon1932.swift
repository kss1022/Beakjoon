//
//  Beakjoon1932.swift
//  Beakjoon
//
//  Created by 한현규 on 1/9/24.
//

import Foundation


class Beakjoon1932{
    func main(){
        let n = Int(readLine()!)!
        
        var triangle = [[Int]]()
        
        for _ in 0..<n{
            let row = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
            triangle.append(row)
        }
        
        let maxPath = maxPath(triangle: triangle, n: n)
        print("\(maxPath)")
    }


    func maxPath(triangle: [[Int]], n: Int) -> Int{
        var dp = triangle
          
        if n < 2{
            return triangle[0][0]
        }
        
        for i in stride(from: n-2, through: 0, by: -1){
            for j in 0...i{
                let left = dp[i+1][j]
                let right = dp[i+1][j+1]
                dp[i][j] += max(left, right)
            }
        }
        
        return dp[0][0]
    }

}
