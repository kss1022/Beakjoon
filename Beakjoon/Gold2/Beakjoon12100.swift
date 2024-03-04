//
//  Beakjoon12100.swift
//  Beakjoon
//
//  Created by 한현규 on 3/4/24.
//

import Foundation


class Beakjoon12100{
    
    func main(){
        let n = Int(readLine()!)!
        var boards = [[Int]]()
        
        for _ in 0..<n{
            let row = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            boards.append(row)
        }
        
        maxBoardMove5(n, boards: boards)
    }


    func maxBoardMove5(_ n : Int, boards: [[Int]]){
        var maxNum = 0
        moveBoxRecursive(n, deepth: 0, boards: boards, maxNum: &maxNum)
        print("\(maxNum)")
    }

    func moveBoxRecursive(_ n : Int,  deepth: Int, boards: [[Int]], maxNum: inout Int){
        if deepth == 5{
            //Set MaxNum
            maxNum = max(boardMaxNum(), maxNum)
            return
        }
        
        let moves = [shitUp, shitDown, shitLeft, shitRight]
        for move in moves {
            var newBoards = boards
            move(n, &newBoards)
            moveBoxRecursive(n, deepth: deepth+1, boards: newBoards, maxNum: &maxNum)
        }
        
        func boardMaxNum() -> Int{
            var result = 0
            for i in 0..<n{
                for j in 0..<n{
                    result = max(boards[i][j], result)
                }
            }
            return result
        }
    }


    func shitUp(_ n: Int, _ boards: inout [[Int]]){
        var beforeSum = (-1,-1)
        for c in 0..<n{
            for r in 0..<n{
                shit(row: r, col: c, move: (-1,0), beforeSum: &beforeSum, n: n, boards: &boards)
            }
        }
    }

    func shitDown(_ n: Int, _ boards: inout [[Int]]){
        var beforeSum = (-1,-1)
        for c in 0..<n{
            for r in stride(from: n-1, through: 0, by: -1){
                shit(row: r, col: c, move: (1,0), beforeSum: &beforeSum, n: n, boards: &boards)
            }
        }
    }

    func shitLeft(_ n: Int, _ boards: inout [[Int]]){
        var beforeSum = (-1,-1)
        for r in 0..<n{
            for c in 0..<n{
                shit(row: r, col: c, move: (0,-1), beforeSum: &beforeSum, n: n, boards: &boards)
            }
        }
    }

    func shitRight(_ n: Int, _ boards: inout [[Int]]){
        var beforeSum = (-1,-1)
        for r in 0..<n{
            for c in stride(from: n-1, through: 0, by: -1){
                shit(row: r, col: c, move: (0,1), beforeSum: &beforeSum, n: n, boards: &boards)
            }
        }
    }


    func shit(row: Int, col: Int, move: (Int, Int), beforeSum: inout (Int, Int), n: Int,  boards: inout [[Int]]){
        let nextRow = row + move.0
        let nextCol = col + move.1
        
        if nextRow < 0 || nextCol < 0 || nextRow >= n || nextCol >= n{
            return
        }
        
        //empty
        if boards[nextRow][nextCol] == 0{
            boards[nextRow][nextCol] = boards[row][col]
            boards[row][col] = 0
            shit(row: nextRow, col: nextCol, move: move, beforeSum: &beforeSum, n: n, boards: &boards)
            return
        }
        
        //sameNum , isNotSum
        if boards[nextRow][nextCol] == boards[row][col] && (nextRow, nextCol) != beforeSum{
            boards[nextRow][nextCol] += boards[row][col]
            boards[row][col] = 0
            beforeSum = (nextRow , nextCol)
        }
    }

}
