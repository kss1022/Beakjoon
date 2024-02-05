//
//  Beakjoon1011.swift
//  Beakjoon
//
//  Created by 한현규 on 2/5/24.
//

import Foundation




class Beakjoon1011{
    func main(){
        let n = Int(readLine()!)!
        
        var moves = [(Int, Int)]()
        
        for _ in 0..<n{
            let move = readLine()!.components(separatedBy: .whitespaces).compactMap(Int.init)
            moves.append((move[0], move[1]))
        }
        
        for move in moves {
            minimumMoveCount(move: move)
        }
    }


    ///left: 1 ~ maxLength
    ///right: maxLength ~ 1
    ///left + right =   (1 + maxLength) * maxLength / 2  +  ( (maxLength-1) + 1) * (maxLength-1) / 2
    ///             =  maxLegth^2
    
    func minimumMoveCount(move: (Int, Int)){
        let start = move.0
        let dest = move.1
        
        var moveCount = 0
        
        let distance = dest - start
        var maxLength = Int(sqrt(Double(distance)))
        
        while true{
            let sum = maxLength * maxLength
            
            if distance == sum{
                moveCount = maxLength + (maxLength - 1)
                break
            }
            
            if distance > sum{
                var temp = distance - (sum)
                moveCount = maxLength + (maxLength - 1)
                            
                while temp > 0{
                    temp -= maxLength
                    moveCount += 1
                }
                
                break
            }
            
            maxLength -= 1
        }

        print("\(moveCount)")
    }

}
