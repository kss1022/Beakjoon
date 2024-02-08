//
//  Beakjoon9663.swift
//  Beakjoon
//
//  Created by 한현규 on 2/8/24.
//

import Foundation



class Beakjoon9663{
    
    func main(){
        let n = Int(readLine()!)!
        nQueenProblem(n: n)
    }


    func nQueenProblem(n: Int){
        
        var board = Array<Int>.init(repeating: -1,count: n)
        
        var count = 0
        nQueenProblemRecursive(n: n, index: 0, board: &board, count: &count)
        print("\(count)")
    }



    func nQueenProblemRecursive(n: Int, index: Int, board: inout [Int], count: inout Int){
        if index == n{
            count += 1
            return
        }
        
        for col in 0..<n{
            var promising = true
            for row in 0..<index{
                if board[row] == col || (abs(index - row) == abs(col - board[row])){
                    promising = false
                    break
                }
            }
                 
            if promising{
                board[index] = col
                nQueenProblemRecursive(n: n, index: index+1, board: &board, count: &count)
            }
        }
    }

}
