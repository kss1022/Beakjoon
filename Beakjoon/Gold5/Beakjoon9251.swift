//
//  Beakjoon9251.swift
//  Beakjoon
//
//  Created by 한현규 on 2/4/24.
//

import Foundation



class Beakjoon9251{
    
    func main(){
        let a = readLine()!
        let b = readLine()!
        
        let result = lcs(a, b)
        print("\(result)")
    }

    func lcs(_ a: String,_ b: String) -> Int{
        let a: [Character] = a.compactMap { $0 }
        let b: [Character] = b.compactMap { $0 }
        
        var mem :[[Int]] = Array.init(
            repeating: Array.init(repeating: 0, count: a.count+1),
            count: b.count + 1
        )
        
        for i in 0..<b.count{
            for j in 0..<a.count{
                if b[i] == a[j]{
                    mem[i+1][j+1] = mem[i][j] + 1
                    continue
                }
                
                mem[i+1][j+1] = max(mem[i][j+1], mem[i+1][j])
            }
        }
        
        return mem[b.count][a.count]
    }

}
