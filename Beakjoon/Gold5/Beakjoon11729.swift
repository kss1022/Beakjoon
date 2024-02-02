//
//  Beakjoon11729.swift
//  Beakjoon
//
//  Created by 한현규 on 1/29/24.
//

import Foundation



class Beakjoon11729{    
    func main(){
        let n = Int(readLine()!)!

        var results = [(Int, Int)]()
        hanoiRecursive(n: n, start: 1, dest: 3, temp: 2, results: &results)
        
        
        print("\(results.count)")
        results.forEach {
            print("\($0.0) \($0.1)")
        }
    }

    func hanoiRecursive(n: Int, start: Int , dest: Int, temp: Int, results: inout [(Int, Int)]){
        if n == 1{
            results.append((start, dest))
            return
        }
        
        hanoiRecursive(n: n - 1, start: start, dest: temp, temp: dest, results: &results)
        results.append((start, dest))
        hanoiRecursive(n: n - 1, start: temp, dest: dest, temp: start, results: &results)
    }


}
