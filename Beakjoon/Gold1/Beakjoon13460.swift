//
//  Beakjoon13460.swift
//  Beakjoon
//
//  Created by 한현규 on 3/18/24.
//

import Foundation



class Beakjoon13460{
    
    func main(){
        let sizes = readLine()!.split(separator: " ")
            .compactMap {  Int(String($0)) }
        
        let r = sizes[0]
        let c = sizes[1]
        
        var board = [[Character]]()
        for _ in 0..<r{
            let row = readLine()!.compactMap { $0 }
            board.append(row)
        }
        moveBead(r, c, board)
    }

    typealias Bead = (row: Int, col: Int, distance: Int)


    func moveBead(_ r: Int, _ c: Int, _ board: [[Character]]){
        var board = board
        
        var red: Bead!
        var blue: Bead!
        
        
        for i in 0..<r{
            for j in 0..<c{
                if board[i][j] == "R"{
                    red = (i, j, 0)
                    board[i][j] = "."
                    continue
                }
                
                if board[i][j] == "B"{
                    blue = (i, j, 0)
                    board[i][j] = "."
                    continue
                }
            }
        }
        
        //[rR][rC][bR][bC]
        let emptyBoard = Array.init(
            repeating: Array.init(repeating: false, count: c),
            count: r
        )
        
        var visited = Array.init(
            repeating: Array.init(repeating: emptyBoard, count: c),
            count: r
        )
        
        var queue = [(Bead, Bead, Int)]()  //red, blue, deepth
        queue.append((red, blue, 0))
        visited[red.row][red.col][blue.row][blue.col] = true
        
        while !queue.isEmpty{
            
            let pop = queue.removeFirst()
            
            let deepth = pop.2
            
            if deepth == 10{
                continue
            }
            
            
            let moves = [(1,0),(-1,0),(0,1),(0,-1)]
            
            for move in moves {
                var red = pop.0
                var blue = pop.1
                                        
                moveBead(board, &red, move)
                moveBead(board, &blue, move)
                
                //blue out
                if isOut(board, blue){
                    continue
                }
                
                //red out
                if isOut(board, red){
                    print("\(deepth+1)")
                    return
                }
                
                if red.row == blue.row && red.col == blue.col{
                    if red.distance > blue.distance{
                        moveBack(&red, move)
                    }else{
                        moveBack(&blue, move)
                    }
                }
                

                if visited[red.row][red.col][blue.row][blue.col]{
                    continue
                }
                            
                visited[red.row][red.col][blue.row][blue.col] = true
                queue.append((red, blue, deepth+1))
            }
            
        }
       
        print(-1)
    }


    func moveBead(_ board: [[Character]], _ bead: inout Bead, _ move: (Int, Int)){
        var nextRow = bead.row + move.0
        var nextCol = bead.col + move.1
        
        
        while true{
            if board[nextRow][nextCol] == "#"{
                nextRow -= move.0
                nextCol -= move.1
                break
            }
            
            if board[nextRow][nextCol] == "O"{
                break
            }
            
                
            nextRow += move.0
            nextCol += move.1
        }
        
        let move = abs(nextRow-bead.row) + abs(nextCol-bead.col)
        bead = (nextRow, nextCol, move)
    }

    func moveBack( _ bead: inout Bead, _ move: (Int, Int)){
        bead = (bead.row-move.0,bead.col-move.1,bead.distance-1)
    }

    func isOut(_ board: [[Character]], _ bead: Bead) -> Bool{
        board[bead.row][bead.col] == "O"
    }

}
