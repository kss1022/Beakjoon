//
//  Beakjoon7576.swift
//  Beakjoon
//
//  Created by 한현규 on 1/29/24.
//

import Foundation



class Beakjoon7576{
    func main(){
        let nums = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
        
        let _ = nums[0]
        let col = nums[1]
        
        
        var tomations = [[Int]]()
        
        for _ in 0..<col{
            let row = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
            tomations.append(row)
        }

        checkTomatioRipeDays(tomations)
    }



    func checkTomatioRipeDays(_ tomatios: [[Int]]){
        let row = tomatios.count
        let col = tomatios[0].count
        
        
        var tomatios = tomatios
            
        var spreads = [(Int, Int)]()
        for i in 0..<row {
            for j in 0..<col{
                if tomatios[i][j] == 1{
                    let spread = (i ,j)
                    spreads.append(spread)
                }
            }
        }
        
        var days = 0
        while true{
            let willSpread = spreads
            spreads.removeAll()
            
            for spread in willSpread {
                let moves = [(-1,0),(1,0),(0,-1),(0,1)]
                moves.forEach { move in
                    let near = (spread.0 + move.0, spread.1 + move.1)
                    
                    //check index
                    if near.0 < 0 || near.1 < 0 || near.0 >= row  || near.1 >= col{
                        return
                    }
                    
                    // is not exsist or  aleary ripe
                    if tomatios[near.0][near.1] == -1 || tomatios[near.0][near.1] == 1{
                        return
                    }
                    
                    tomatios[near.0][near.1] = 1
                    spreads.append(near)
                }
            }
            
            if spreads.isEmpty{
                break
            }
            
            days += 1
        }
        
        
        
        for i in 0..<row{
            for j in 0..<col{
                if tomatios[i][j] == 0{
                    print("\(-1)")
                    return
                }
            }
        }
            
        print("\(days)")
    }

}
