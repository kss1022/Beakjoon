//
//  Beakjoon2749.swift
//  Beakjoon
//
//  Created by 한현규 on 3/8/24.
//

import Foundation


class Beakjoon2749{

    func main(){
        let n = Int(readLine()!)!
        fibonacci(n)
    }


    func fibonacci(_ n: Int){
        let mod = 1000000
        let period = findPisanoPeriod(modulo: mod)
        
        var mem = [Int: Int]()
        mem[0] = 0
        mem[1] = 1
        
        for i in 2..<period{
            mem[i] = (mem[i-2]! + mem[i-1]!) % mod
        }
        
        print("\(mem[n%period]!)")
    }


    func findPisanoPeriod(modulo: Int) -> Int {
        var previous = 0
        var current = 1

        for i in 0..<modulo * modulo {
            let temp = (previous + current) % modulo
            previous = current
            current = temp

            if previous == 0, current == 1 {
                return i + 1
            }
        }
        
        return 0
    }

}
