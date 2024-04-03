//
//  Beakjooon1799.swift
//  Beakjoon
//
//  Created by 한현규 on 4/3/24.
//

import Foundation




class Beakjooon1799{

    func main(){
        let size = Int(readLine()!)!
        
        var boards = [[Int]]()
        
        for _ in 0..<size{
            let row = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            
            boards.append(row)
        }
        
        nBishopProblem(size, boards)
    }


    func nBishopProblem(_ n: Int, _ board: [[Int]]){
        var evens = [(Int, Int)]()
        var odds = [(Int, Int)]()
        
        for i in 0..<n{
            for j in 0..<n{
                if board[i][j] == 1{
                    if (i + j) % 2 == 0{
                        evens.append((i,j))
                    }else{
                        odds.append((i,j))
                    }
                }
            }
        }
        
        var oddResults = 0
        var oddChekced = Array.init(repeating: false, count: odds.count)
        nBishopProblemRecursive(0, odds, 0, &oddChekced, &oddResults)
        
        var evenResults = 0
        var evenChekced = Array.init(repeating: false, count: evens.count)
        nBishopProblemRecursive(0, evens, 0, &evenChekced, &evenResults)
        print(oddResults + evenResults)
    }


    func nBishopProblemRecursive(_ deepth: Int, _ positions: [(Int, Int)], _ count: Int ,_ checked: inout [Bool], _ result : inout Int){
        result = max(count, result)
        
        if deepth == positions.count{
            return
        }
        
        for i in deepth..<positions.count{
            let newPosition = positions[i]
            
            if isPromiss(newPosition.0, newPosition.1, deepth, positions, checked){
                checked[i] = true
                nBishopProblemRecursive(i+1, positions, count+1 ,&checked, &result)
                checked[i] = false
            }
        }
    }


    func isPromiss(_ row: Int, _ col: Int, _ deepth: Int, _ positions: [(Int, Int)], _ checked: [Bool]) -> Bool{
        for i in 0..<deepth{
            if !checked[i]{
                continue
            }
            
            let before = positions[i]
            if abs(before.0 - row) == abs(before.1 - col){
                return false
            }
        }
        
        return true
    }

}
