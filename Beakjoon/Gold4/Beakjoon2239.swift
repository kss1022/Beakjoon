//
//  Beakjoon2239.swift
//  Beakjoon
//
//  Created by 한현규 on 1/31/24.
//

import Foundation



class Beakjoon2239{
    
    func main(){
        var board = [[Int]]()
        for _ in 0..<9{
            let row = readLine()!.map(String.init).compactMap(Int.init)
            board.append(row)
        }
        Sudoku(board)
    }



    func Sudoku(_ board: [[Int]]){
        var zeros = [(Int, Int)]()
        for i in 0..<9{
            for j in 0..<9{
                if board[i][j] == 0{
                    zeros.append((i, j))
                }
            }
        }
        
        playSudoku(board: board, zeros: zeros)
    }

    func playSudoku(board: [[Int]], zeros: [(Int, Int)]){
        if zeros.isEmpty{
            printBoard(board: board)
            return
        }
        
        var list = [ ([[Int]] , Int)]() //board , deepth
        list.append((board, 0))

        while !list.isEmpty{
            let pop = list.removeFirst()
            
            let board = pop.0
            let deepth = pop.1
            
            if deepth == zeros.count{
                printBoard(board: board)
                return
            }
                    
            for newValue in stride(from: 9, through: 1, by: -1){
                let row = zeros[deepth].0
                let col = zeros[deepth].1
                
                if checkRow(board, row: row, value: newValue) &&
                    checkCol(board, col: col, value: newValue) &&
                    checkBox(board, row: row, col: col, value: newValue){
                    var newBoard = board
                    newBoard[row][col] = newValue
                    list.insert((newBoard, deepth + 1), at: 0)
                }
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
        let x = row / 3
        let y = col / 3
        
        for i in 0..<3{
            for j in 0..<3{
                if board[x*3+i][y*3+j] == value{
                    return false
                }
            }
        }
        
        return true
    }



    func printBoard(board: [[Int]]){
        for i in 0..<9{
            let row = board[i].map(String.init).joined()
            print(row)
        }
        
    }

}
