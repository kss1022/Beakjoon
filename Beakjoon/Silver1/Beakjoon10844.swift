//
//  Beakjoon10844.swift
//  Beakjoon
//
//  Created by 한현규 on 1/11/24.
//

import Foundation


class Beakjoon10844{
    
    func main(){
        let n = Int(readLine()!)!
        print("\(stairsNums(n))")
    }


    func stairsNums(_ n: Int) -> UInt64{
        
        let row = Array.init(repeating: UInt64(0), count: 10)
        var mem: [[UInt64]] = Array.init(repeating: row, count: n+1)
        
        for i in 0...9{
            mem[1][i] = 1
        }
        
        
        var result: UInt64 = 0
        for i in 1...9{
            let starNum = starsNumsRecursive(value: i, depth: n, mem: &mem)
            result += starNum
        }
                        
        return result % 1000000000
    }




    func starsNumsRecursive(value: Int, depth: Int, mem: inout [[UInt64]]) -> UInt64{
        if depth == 1{
            return mem[depth][value]
        }
        
        if mem[depth][value] != 0{
           return mem[depth][value]
        }
        
        
        if value == 0{
            mem[depth][value] += starsNumsRecursive(value: value+1, depth: depth-1, mem: &mem) % 1000000000
        }else if value == 9{
            mem[depth][value] += starsNumsRecursive(value: value-1, depth: depth-1, mem: &mem) % 1000000000
        }else{
            mem[depth][value] += (starsNumsRecursive(value: value-1, depth: depth-1, mem: &mem) % 1000000000
                                  + starsNumsRecursive(value: value+1, depth: depth-1, mem: &mem) % 1000000000)
        }
        
        return mem[depth][value]
    }

}
