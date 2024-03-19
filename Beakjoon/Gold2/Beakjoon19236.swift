//
//  Beakjoon19236.swift
//  Beakjoon
//
//  Created by 한현규 on 3/15/24.
//

import Foundation



final class Beakjoon19236{

    func main(){
        
        var board = [[Fish]]()
        
        let N = 4
        for _ in 0..<N{
            let row = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            
            var rowFishs = [Fish]()
            for j in stride(from: 0, to: 2 * N, by: 2){
                let fish = Fish(row[j],Rotate(rawValue: row[j+1]-1)!)
                rowFishs.append(fish)
            }
            
            board.append(rowFishs)
        }
        
        
        eatFishs(N, board)
    }

    func eatFishs(_ N: Int, _ board: [[Fish]]){
        var fishs = [Int: (Int, Int)]()
        
        for i in 0..<N{
            for j in 0..<N{
                fishs[board[i][j].num] = (i, j)
            }
        }
        
        var result = 0
        var board: [[Fish?]] = board
        
        let shark = Shark((0, 0), board[0][0]!.rotate)
        let sum = board[0][0]!.num
        
        
        fishs[board[0][0]!.num] = nil
        board[0][0] = nil
        
        moveSharkRecursive(sum, shark, fishs, board, N, &result)
        print(result)
        
        
        
        
        
        
        
        
    }

    func moveSharkRecursive(_ sum: Int, _ shark: Shark,_ fishs: [Int: (Int,Int)], _ board:  [[Fish?]], _ N: Int, _ result: inout Int ){
        result = max(sum, result)
        
        
        var movedFishs = fishs
        var movedBoard = board
        
        moveFishs(shark, &movedFishs, &movedBoard, N)

        //MoveShark
        let move = shark.rotate.move()
        var nextRow = shark.position.row + move.0
        var nextCol = shark.position.col + move.1
        
        while true{
            //invalid index
            if nextRow < 0 || nextCol < 0 || nextRow >= N || nextCol >= N{
                return
            }
            
            //Empty
            if movedBoard[nextRow][nextCol] == nil{
                nextRow += move.0
                nextCol += move.1
                continue
                //return
            }
            
            let fish = movedBoard[nextRow][nextCol]!
            let nextShark = Shark((nextRow, nextCol), fish.rotate)
            let nextSum = sum + fish.num
            var nextBoard = movedBoard
            var nextFishs = movedFishs
            
            nextBoard[nextRow][nextCol] = nil
            nextFishs[fish.num] = nil
            
            
            moveSharkRecursive(nextSum, nextShark, nextFishs, nextBoard, N, &result)
            
            nextRow += move.0
            nextCol += move.1
        }
        
    }

    func moveFishs(_ shark: Shark,  _ fishs: inout [Int: (Int,Int)], _ board: inout [[Fish?]], _ N: Int){
        for i in 1...16{
            guard let position = fishs[i],
                  let fish =  board[position.0][position.1] else { continue }
            
            
            var rotate = fish.rotate
            
            for _ in 1...7{
                if moveFish(position: position, num: fish.num, rotate: rotate){
                    break
                }
                rotate = rotate.next()
            }
        }
        
        
        func moveFish(position: (Int, Int), num: Int, rotate: Rotate) -> Bool{
            let row = position.0
            let col = position.1
            
            let nextRow = row + rotate.move().0
            let nextCol = col + rotate.move().1
            
            //invalid index
            if nextRow < 0 || nextCol < 0 || nextRow >= N || nextCol >= N{
                return false
            }
            
            //shark
            if nextRow == shark.position.row && nextCol == shark.position.col{
                return false
            }
            
            //empty
            if board[nextRow][nextCol] == nil{
                board[nextRow][nextCol] = Fish(num, rotate)
                fishs[num] = (nextRow, nextCol)
                
                board[row][col] = nil
                return true
            }
            
            //swap
            let temp = board[nextRow][nextCol]!
            
            
            board[nextRow][nextCol] = Fish(num, rotate)
            fishs[num] = (nextRow, nextCol)
            
            board[row][col] = temp
            fishs[temp.num] = (row, col)
            
            return true
        }
        
    }

    func printBoard(_ board: [[Fish?]]){
        for i in 0..<4{
            let row = board[i].map {
                guard let fish = $0 else { return "    "}
                return "\(fish.num) \(fish.rotate)"
            }.joined(separator: " ")
            
            print(row)
        }
    }


    //↑, ↖, ←, ↙, ↓, ↘, →, ↗
    enum Rotate: Int{
        case rotate0
        case rotate325
        case rotate270
        case rotate225
        case rotate180
        case rotate125
        case rotate90
        case rotate45
        
        func move() -> (Int, Int){
            switch self {
            case .rotate0: return (-1 ,0)       //↑
            case .rotate325: return (-1 ,-1)    //↖
            case .rotate270: return (0 ,-1)     //←
            case .rotate225: return (1, -1)     //↙
            case .rotate180: return (1, 0)      //↓
            case .rotate125: return (1, 1)      //↘
            case .rotate90: return (0, 1)       //→
            case .rotate45: return (-1, 1)      //↗
            }
        }
        
        func next() -> Rotate{
            switch self {
            case .rotate0: return .rotate325
            case .rotate325: return .rotate270
            case .rotate270: return .rotate225
            case .rotate225: return .rotate180
            case .rotate180: return .rotate125
            case .rotate125: return .rotate90
            case .rotate90: return .rotate45
            case .rotate45: return .rotate0
            }
        }
    }



//    extension Rotate: CustomStringConvertible{
//        var description: String{
//            switch self {
//            case .rotate0: return "↑"
//            case .rotate325: return "↖"
//            case .rotate270: return "←"
//            case .rotate225: return "↙"
//            case .rotate180: return "↓"
//            case .rotate125: return "↘"
//            case .rotate90: return  "→"
//            case .rotate45: return  "↗"
//            }
//        }
//    }



    struct Shark{
        let position: (row: Int, col: Int)
        let rotate: Rotate
        
        init(_ position: (Int, Int), _ rotate: Rotate) {
            self.position = position
            self.rotate = rotate
        }
        
    }


    struct Fish: Hashable{
        let num: Int
        let rotate: Rotate
        
        init(_ num: Int,_ rotate: Rotate) {
            self.num = num
            self.rotate = rotate
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(num)
        }
        
        static func ==(lhs: Fish, rhs: Fish) -> Bool{
            lhs.num == rhs.num
        }
        
    }

}
