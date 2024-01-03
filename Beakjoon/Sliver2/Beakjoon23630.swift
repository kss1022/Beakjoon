//
//  Beakjoon23630.swift
//  Beakjoon
//
//  Created by 한현규 on 1/2/24.
//

import Foundation


class Beakjoon23630{
    func run(){
        _ = Int(readLine()!)!
        
        
        let nums = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        
        
        var result = 1
        
        // 2^20 -> 1,000,000
        for i in 0..<20{
            let mask = 1 << i
            
            var temp = 0
            for num in nums {
                if (num & mask) != 0{
                    temp += 1
                }
            }
            
            result = max(temp, result)
        }
        
        print("\(result)")
    }
    
}
