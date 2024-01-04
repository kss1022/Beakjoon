//
//  Beakjoon2716.swift
//  Beakjoon
//
//  Created by 한현규 on 1/3/24.
//

import Foundation


class Beakjoon2716{
    func run(){
        let n = Int(readLine()!)!
        
        
        for _ in 0..<n{
            let tree = readLine()!
            print("\(maxMonkey(tree))")
        }
    }


    func maxMonkey(_ tree: String) -> Int{
        var maxLevel = 0
        var level = 0
        
        for char in tree{
            if char == "["{
                level += 1
                maxLevel = max(maxLevel, level)
            }else{
                level -= 1
            }
        }
        
        var result = 1
        
        for _ in 0..<maxLevel{
            result *= 2
        }
        
        return result
    }

}
