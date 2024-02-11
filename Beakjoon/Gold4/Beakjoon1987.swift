//
//  Beakjoon1987.swift
//  Beakjoon
//
//  Created by 한현규 on 2/11/24.
//

import Foundation



class Beakjoon1987{
    
    func main(){
        let sizes = readLine()!.components(separatedBy: .whitespaces)
            .compactMap(Int.init)
        
        
        let l = sizes[0]
        let _ = sizes[1]
        
        
        var boards = [[Int]]()
        
        for _ in 0..<l{
            let row = readLine()!.map { Int($0.asciiValue!) - 65 }
            boards.append(row)
        }
        
        maxMoveCount(boards)
    }

    func maxMoveCount(_ board: [[Int]]){
        var maxMove = 1
        var visited = Array.init(repeating: false, count: 36)
        visited[board[0][0]] = true
        maxMoveRecursive(board, row: 0, col: 0, deepth: 1, visited: &visited, maxMove: &maxMove)
        print("\(maxMove)")
    }


    func maxMoveRecursive(_ board: [[Int]], row: Int, col: Int, deepth: Int, visited: inout [Bool], maxMove: inout Int){
        let moves = [(1,0),(-1,0),(0,1),(0,-1)]
        for move in moves {
            let nextRow = row + move.0
            let nextCol = col + move.1
            
            if nextRow < 0 || nextRow >= board.count || nextCol < 0 || nextCol >= board[0].count{
                continue
            }
            
            let new = board[nextRow][nextCol]
            if visited[new]{
                maxMove = max(deepth, maxMove)
                continue
            }
            
            visited[new] = true
            maxMoveRecursive(board, row: nextRow, col: nextCol, deepth:  deepth + 1, visited: &visited, maxMove: &maxMove)
            visited[new] = false
        }
    }

}
