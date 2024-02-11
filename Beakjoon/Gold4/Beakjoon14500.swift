//
//  Beakjoon14500.swift
//  Beakjoon
//
//  Created by 한현규 on 2/11/24.
//

import Foundation



class Beakjoon14500{

    func main(){
        let size = readLine()!.split(separator: " ")
            .map(String.init)
            .compactMap(Int.init)
        
        let row = size[0]
        let _ = size[1]
        
        
        var board = [[Int]]()
        for _ in 0..<row{
            let row = readLine()!.split(separator: " ")
                .map(String.init)
                .compactMap(Int.init)
            
            board.append(row)
        }
        
        maxSum(board: board)
    }



    func maxSum(board: [[Int]]){
        var result = 0
        var visited = Array.init(
            repeating: Array.init(repeating: false, count: board[0].count),
            count: board.count
        )
        
        for i in 0..<board.count{
            for j in 0..<board[0].count{
                technominoRecursive(board: board, row: i, col: j, deepth: 0, sum: 0, visited: &visited, maxSum: &result)
                lastTechnomino(board: board, row: i, col: j, maxSum: &result)
            }
        }
        
        
        print(result)
    }





    func technominoRecursive(board:[[Int]], row: Int, col: Int, deepth: Int, sum: Int, visited: inout [[Bool]],maxSum: inout Int){
        if deepth == 4{
            maxSum = max(sum, maxSum)
            return
        }
                    
        let moves = [(-1,0),(1,0),(0,-1),(0,1)]
        
        for move in moves {
            let nextRow = move.0 + row
            let nextCol = move.1 + col
            
            if nextRow < 0 || nextCol < 0 || nextRow >= board.count || nextCol >= board[0].count{
                continue
            }
            
            if visited[nextRow][nextCol]{
                continue
            }
                    
            visited[nextRow][nextCol] = true
            technominoRecursive(board: board, row: nextRow, col: nextCol, deepth: deepth+1, sum: sum + board[nextRow][nextCol], visited: &visited, maxSum: &maxSum)
            visited[nextRow][nextCol] = false
        }
    }


    ///  ***        *       *       *
    ///   *        **      ***      **
    ///             *               *
    ///
    func lastTechnomino(board: [[Int]], row: Int, col: Int, maxSum: inout Int){
        
        
        //1.
        if !(row + 1 >= board.count || col + 2 >= board[0].count){
            let basic = [(0,0), (0,1), (0,2), (1,1)]
            let sum =  basic.reduce(0) { result, point in
                result + board[row + point.0][col + point.1]
            }
            maxSum = max(sum, maxSum)
        }
        

        
        //2.
        if !(row + 2 >= board.count || col + 1 >= board[0].count){
            let rotate90 = [(0,1), (1,0), (1,1), (2,1)]
            let sum =  rotate90.reduce(0) { result, point in
                result + board[row + point.0][col + point.1]
            }
            maxSum = max(sum, maxSum)
        }
        
        
        
        //3.
        if !(row + 1 >= board.count || col + 2 >= board[0].count){
            let rotate180 = [(0,1) ,(1,0), (1,1), (1,2)]
            let sum =  rotate180.reduce(0) { result, point in
                result + board[row + point.0][col + point.1]
            }
            maxSum = max(sum, maxSum)
        }
        
        
        
        //4.
        if !(row + 2 >= board.count || col + 1 >= board[0].count){
            let rotate270 = [(0,0) ,(1,0), (1,1), (2,0)]
            let sum =  rotate270.reduce(0) { result, point in
                result + board[row + point.0][col + point.1]
            }
            maxSum = max(sum, maxSum)
        }
        
    }

}
