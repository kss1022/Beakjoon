//
//  Beakjoon2580.swift
//  Beakjoon
//
//  Created by 한현규 on 2/14/24.
//

import Foundation



class Beakjoon2580{
    func main(){
        var board = [[Int]]()
        
        for _ in 0..<9{
            let row = readLine()!.split(separator: " ")
                .map(String.init)
                .compactMap(Int.init)
            board.append(row)
        }
        
        sudoku(board: board)
    }

    func sudoku(board: [[Int]]){
        var zeros = [(Int,Int)]()
        
        for i in 0..<9{
            for j in 0..<9{
                if board[i][j] == 0{
                    zeros.append((i,j))
                }
            }
        }
        
        
        //dfs
        var board = board
        var find = false
        sudokuRecursive(board: &board, find: &find, zeros: zeros, deepth: 0)

    }

    func sudokuRecursive(board: inout [[Int]], find: inout Bool, zeros: [(Int,Int)], deepth: Int){
        if find{
            return
        }
        
        if deepth == zeros.count{
            find = true
            printBoard(board: board)
            return
        }
        
        for newValue in 1...9{
            let row = zeros[deepth].0
            let col = zeros[deepth].1
            
            
            if checkRow(board, row: row, value: newValue) &&
                checkCol(board, col: col, value: newValue) &&
                checkBox(board, row: row, col: col, value: newValue){
                
                let temp = board[row][col]
                board[row][col] = newValue
                sudokuRecursive(board: &board, find: &find,zeros: zeros, deepth: deepth + 1)
                board[row][col] = temp
            }
        }
        
    }


    func checkRow(_ board: [[Int]], row: Int, value: Int) -> Bool{
        for i in 0..<9{
            if board[row][i] == value{
                return false
            }
        }
        
        return true
    }

    func checkCol(_ board: [[Int]], col: Int, value: Int) -> Bool{
        for i in 0..<9{
            if board[i][col] == value{
                return false
            }
        }
        
        return true
    }

    func checkBox(_ board: [[Int]], row: Int, col: Int, value: Int) -> Bool{
        let boxRow = row / 3
        let boxCol = col / 3
        
        for i in 0..<3{
            for j in 0..<3{
                if board[boxRow*3+i][boxCol*3+j] == value{
                    return false
                }
            }
        }
        return true
    }


    func printBoard(board: [[Int]]){
        for i in 0..<9{
            let row = board[i].map(String.init).joined(separator: " ")
            print(row)
        }
        
    }

}
