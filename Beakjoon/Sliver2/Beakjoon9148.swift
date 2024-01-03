//
//  Beakjoon9148.swift
//  Beakjoon
//
//  Created by 한현규 on 1/3/24.
//

import Foundation


class Beakjoon9148{
    func run(){
        var mem = [Input: Int]()
        
        while true{
            let nums = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
            
            let a = nums[0]
            let b = nums[1]
            let c = nums[2]
            
            if a == -1 && b == -1 && c == -1{
                break
            }
            
            let result = recursiveW(a, b, c, &mem)
            //w(1, 1, 1) = 2
            print("w(\(a), \(b), \(c)) = \(result)")
        }
    }


    func recursiveW(_ a: Int,_ b: Int,_ c: Int,_  mem: inout [Input: Int]) -> Int{
        let input = Input(a: a, b: b, c: c)
        
        if let cache = mem[input]{
            return cache
        }
        
        
        if  a <= 0 || b <= 0 || c <= 0{
            mem[input] = 1
            return 1
        }
        
        if  a > 20 || b > 20 || c > 20{
            let result = recursiveW(20, 20, 20, &mem)
            mem[input] = result
            return result
        }
        
        if (a < b) && (b < c){
            let result = recursiveW(a, b, c-1, &mem) + recursiveW(a, b-1, c-1, &mem) - recursiveW(a, b-1, c, &mem)
            mem[input] = result
            return result
        }
        
        let result = recursiveW(a-1, b, c, &mem) + recursiveW(a-1, b-1, c, &mem) + recursiveW(a-1, b, c-1, &mem) - recursiveW(a-1, b-1, c-1, &mem)
        mem[input] = result
        return result
    }


    struct Input: Hashable{
        let a: Int
        let b: Int
        let c: Int
    }

}
