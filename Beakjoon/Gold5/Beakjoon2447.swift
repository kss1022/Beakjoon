//
//  Beakjoon2447.swift
//  Beakjoon
//
//  Created by 한현규 on 2/2/24.
//

import Foundation



class Beakjoon2447{
    func main(){
        let n = Int(readLine()!)!
        
        
        let row = Array<Character>(repeating: "*", count: n)
        var results = Array.init(repeating: row, count: n)
            
        //printStarRecursive(n: n, deepth: n, result: &results)
        printStarRecursive(n: n, size: 3, result: &results)
        printResults(result: results)
    }



    func printStarRecursive(n : Int, size: Int, result: inout [[Character]]){
        if size > n{
            return
        }
            
        
        for i in stride(from: 0, to: n, by: size){
            for j in stride(from: 0, to: n, by: size){
                let zeroSize = size / 3
                for k in 0..<zeroSize{
                    for l in 0..<zeroSize{
                        result[i+zeroSize+k][j+zeroSize+l] = " "
                    }
                }
                
            }
        }
        
        printStarRecursive(n: n, size: size * 3, result: &result)
    }



    func printResults(result: [[Character]]){
        for i in 0..<result.count{
            let row = result[i].compactMap(String.init).joined()
            print(row)
        }
    }

}
