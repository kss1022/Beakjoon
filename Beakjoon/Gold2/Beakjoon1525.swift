//
//  Beakjoon1525.swift
//  Beakjoon
//
//  Created by 한현규 on 4/12/24.
//

import Foundation


class Beakjoon1525{

    func main(){
        
        var boards = ""
        
        for _ in 0..<3{
            readLine()!.split(separator: " ")
                .forEach{
                    boards.append(String($0)
                    )
                }
        }
        
        setBoards(boards)
    }




    func setBoards(_ board: String){
        let end = "123456780"
        var visited = [String:Int]()
        
        let moves = [
            [1,3],
            [0,2,4],
            [1,5],
            [0,4,6],
            [1,3,5,7],
            [2,4,8],
            [3,7],
            [6,4,8],
            [5,7],
        ]
        
        
        var queue = [(String, Int)]()       //board, zero pos
        queue.reserveCapacity(1000000)
        queue.append((board, findZero(board)))
        visited[board] = 0
        
        var index = 0
        
        while index < queue.count{
            
            let pop = queue[index]
            index += 1
            
            let board = pop.0
            let pos = pop.1
            let count = visited[board]!
            
            
            if board == end{
                print(count)
                return
            }
            
            for nextPos in moves[pos]{
                let newboard = swapAt(board, pos, nextPos)
                if visited[newboard] != nil {
                    continue
                }
                
                visited[newboard] = count + 1
                queue.append((newboard, nextPos))
            }
        }
        
        
        print(-1)
    }



    func findZero(_ boards: String) -> Int{
        for (index, char) in boards.enumerated(){
            if char == "0"{
                return index
            }
        }
        
        
        return -1
    }


    func swapAt(_ board: String, _ i: Int, _ j: Int) -> String{
        var newBoard = Array(board)
        newBoard.swapAt(i, j)
        return String(newBoard)
    }

}
