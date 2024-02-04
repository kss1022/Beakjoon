//
//  Beakjoon7569.swift
//  Beakjoon
//
//  Created by 한현규 on 2/4/24.
//

import Foundation



class Beakjoon7569{

    func main(){
        let nums = readLine()!.components(separatedBy: .whitespaces)
            .compactMap(Int.init)
        
        let n = nums[1] // row
        let m = nums[0] // col
        let h = nums[2] // height
        
        var boxes = [[[Int]]]()
        
        for _ in 0..<h{
            var box = [[Int]]()
            for _ in 0..<n{
                let row = readLine()!.components(separatedBy: .whitespaces)
                    .compactMap(Int.init)
                box.append(row)
            }
            boxes.append(box)
        }
        
        checkTomatoRipsDays(boxes, row: n, col: m, height: h)
    }


    func checkTomatoRipsDays(_ boxes: [[[Int]]], row : Int, col : Int , height: Int){
        
        
        var boxes = boxes
        
        var spreads = [(Int, Int, Int)]()
        
        for i in 0..<height{
            for j in 0..<row{
                for k in 0..<col{
                    if boxes[i][j][k] == 1{
                        let spread = (i, j, k)
                        spreads.append(spread)
                    }
                }
            }
        }
        
        
        var days = 0
        
        while true{
            let willSpread = spreads
            spreads.removeAll()
            
            
            for spread in willSpread {
                // up down left right
                let moves = [(-1,  0, 0), (1,  0, 0), (0,  -1 , 0), (0,  1, 0), (0, 0, -1) ,(0, 0, 1)]
                
                moves.forEach { move in
                    let near = (spread.0 + move.0, spread.1 + move.1, spread.2 + move.2)
                    
                    if near.0 < 0 || near.1 < 0 || near.2 < 0 || near.0 >= height  || near.1 >= row || near.2 >= col{
                        return
                    }
                    
                    if boxes[near.0][near.1][near.2] == -1 ||
                        boxes[near.0][near.1][near.2] == 1{
                        return
                    }
                    
                    boxes[near.0][near.1][near.2] = 1
                    spreads.append(near)
                }
            }
            
            if spreads.isEmpty{
                break
            }
            
            days += 1
        }
        

        for i in 0..<height{
            for j in 0..<row{
                for k in 0..<col{
                    if boxes[i][j][k] == 0{
                        print("\(-1)")
                        return
                    }
                }
            }
        }
            
        print("\(days)")}

}
