//
//  Beakjoon2210.swift
//  Beakjoon
//
//  Created by 한현규 on 1/4/24.
//

import Foundation


class Beakjoon2210{
    func run(){
        var board = [[Character]]()
        
        for _ in 0..<5{
            let row = readLine()!.components(separatedBy: .whitespaces).compactMap(Character.init)
            board.append(row)
        }
        
        var results = Set<String>()
        
        for i in 0..<5{
            for j in 0..<5{
                let nums =  getNumbers(board: board, row: i, col: j)
                for num in nums {
                    results.insert(num)
                }
            }
        }
        
        print(results.count)
    }


    func getNumbers(board: [[Character]], row: Int, col: Int) -> Set<String>{
        var results = Set<String>()
        getNumberRecursive(board: board, string: [], results: &results, row: row, col: col)
        return results
    }

    func getNumberRecursive(board: [[Character]], string: [Character], results: inout Set<String>, row: Int, col: Int){
        if string.count == 6{
            let result = string.map(String.init).joined()
            results.insert(result)
            return
        }
        
        if row < 0 || row == 5 || col < 0 || col == 5{
            return
        }
        
        var newString = string
        newString.append(board[row][col])
        
        getNumberRecursive(board: board, string: newString, results: &results, row: row-1, col: col)
        getNumberRecursive(board: board, string: newString, results: &results, row: row, col: col-1)
        getNumberRecursive(board: board, string: newString, results: &results, row: row+1, col: col)
        getNumberRecursive(board: board, string: newString, results: &results, row: row, col: col+1)
    }

}
