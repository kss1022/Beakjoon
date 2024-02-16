//
//  Beakjoon14499.swift
//  Beakjoon
//
//  Created by 한현규 on 2/16/24.
//

import Foundation


class Beakjoon14499{
    
    func main(){
        let nums = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
        
        let row = nums[0]
        let startRow = nums[2]
        let startcol = nums[3]
        
        var maps = [[Int]]()
        
        for _ in 0..<row{
            let row = readLine()!.split(separator: " ")
                .map(String.init)
                .compactMap(Int.init)
            
            maps.append(row)
        }
            
        let commands = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
        
        diceTopNums(map: maps, startRow: startRow, startCol: startcol, commands: commands)
    }


    ///e: 1
    ///w: 2
    ///n: 3
    ///s: 4


    ///  2
    ///4 1 3
    ///  5
    ///  6

    func diceTopNums(map: [[Int]], startRow: Int, startCol: Int, commands: [Int]){
        var map = map
        
        var queue = commands
        
        var dice = Array.init(repeating: 0, count: 7)
        
        var row = startRow
        var col = startCol
        
        while !queue.isEmpty{
            let direction = queue.removeFirst()
            
            
            let moves = [(0,1),(0,-1),(-1,0),(1,0)]
            let move = moves[direction-1]
                    
            let nextRow = row + move.0
            let nextCol = col + move.1
            if nextRow < 0 || nextCol < 0 || nextRow >= map.count || nextCol >= map[0].count{
                continue
            }
                    
            switch direction{
            case 1: east(dice: &dice)
            case 2: west(dice: &dice)
            case 3: north(dice: &dice)
            case 4: south(dice: &dice)
            default: fatalError()
            }
            
            if map[nextRow][nextCol] == 0{
                map[nextRow][nextCol] = dice[6]
            }else{
                dice[6] = map[nextRow][nextCol]
                map[nextRow][nextCol] = 0
            }

                    
            row = nextRow
            col = nextCol
            print(dice[1])
        }
    }

    // 6 4 1 3 -> 3 6 4 1
    func east(dice: inout [Int]){
        let before = dice
        dice[6] = before[3]
        dice[4] = before[6]
        dice[1] = before[4]
        dice[3] = before[1]
    }

    // 6 4 1 3 -> 4 1 3 6
    func west(dice: inout [Int]){
        let before = dice
        dice[6] = before[4]
        dice[4] = before[1]
        dice[1] = before[3]
        dice[3] = before[6]
    }



    // 2 1 5 6 -> 1 5 6 2
    func north(dice: inout [Int]){
        let before = dice
        dice[2] = before[1]
        dice[1] = before[5]
        dice[5] = before[6]
        dice[6] = before[2]
    }

    // 2 1 5 6 -> 6 2 1 5
    func south(dice: inout [Int]){
        let before = dice
        dice[2] = before[6]
        dice[1] = before[2]
        dice[5] = before[1]
        dice[6] = before[5]
    }

}
