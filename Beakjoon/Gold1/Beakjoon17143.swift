//
//  Beakjoon17143.swift
//  Beakjoon
//
//  Created by 한현규 on 3/19/24.
//

import Foundation



class Beakjoon17143{
    func main(){
        let nums = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let R = nums[0]
        let C = nums[1]
        let N = nums[2]
        
        var sharks = [Position: Shark]()
        
        
        for _ in 0..<N{
            let sharkInfo = readLine()!.split(separator: " ")
                .compactMap{ Int(String($0)) }
            
            let position = Position(sharkInfo[0]-1, sharkInfo[1]-1)
            
            let shark = Shark(
                position: position,
                speed: sharkInfo[2],
                direction: directions(sharkInfo[3]),
                size: sharkInfo[4]
            )
            
            sharks[position] = shark
        }
            
        catchSharks(R, C, N, sharks)
    }

    func catchSharks(_ R: Int, _ C: Int, _ N: Int, _ sharks: [Position: Shark]){
        var sharks = sharks
        
        var result = 0
        
        for fisher in 0..<C{
            let weight = catchShark(R, fisher, &sharks) ?? 0
            result += weight
            
            sharks = moveSharks(R, C, sharks)
        }
        
        
        print(result)
    }

    func catchShark(_ R: Int, _ at: Int,_ sharks: inout [Position: Shark]) -> Int?{
        for i in 0..<R{
            let nearest = sharks[Position(i, at)]
            if nearest == nil{
                continue
            }
            
            sharks[Position(i, at)] = nil
            return nearest!.size
        }
        
        return nil
    }

    func moveSharks(_ R: Int, _ C: Int, _ sharks: [Position: Shark]) -> [Position: Shark]{
        var newSharks = [Position: Shark]()
        
        for (_ , shark) in sharks{
            let moved = moveShark(R, C, shark)
            
            if newSharks[moved.position] == nil{
                newSharks[moved.position] = moved
                continue
            }
            
            newSharks[moved.position] = max(newSharks[moved.position]!, moved)
        }
        
        return newSharks
    }

    func moveShark(_ R: Int, _ C: Int, _ shark: Shark) -> Shark{
        var nextRow = shark.row
        var nextCol = shark.col
        
        var count = shark.speed
        var direction = shark.direction
        
        count %= mod(R, C, direction)
        
        while count > 0{
            let tempRow = nextRow + direction.0
            let tempCol = nextCol + direction.1
            
            if tempRow < 0 || tempCol < 0 || tempRow >= R || tempCol >= C{
                direction = reverseDirection(direction)
                continue
            }
            
            nextRow = tempRow
            nextCol = tempCol
            count -= 1
        }
        
        return Shark(
            position: Position(nextRow, nextCol),
            speed: shark.speed,
            direction: direction,
            size: shark.size
        )
    }

    struct Position: Hashable, Comparable{
        let row: Int
        let col: Int
        
        init(_ row: Int, _ col: Int) {
            self.row = row
            self.col = col
        }
        
        static func < (lhs: Position, rhs: Position) -> Bool {
            if lhs.row == rhs.row{
                return lhs.col < rhs.col
            }
            
            return lhs.row < rhs.row
        }
    }

    struct Shark: Comparable{
        let position: Position
        let speed: Int
        let direction: (Int, Int)
        let size: Int
        
        
        var row: Int{
            position.row
        }
        
        var col: Int{
            position.col
        }
        
        static func < (lhs: Shark, rhs: Shark) -> Bool {
            lhs.size < rhs.size
        }
        
        static func == (lhs: Shark, rhs: Shark) -> Bool {
            false
        }
    }


    func directions(_ i: Int) -> (Int, Int){
        [(-1,0), (1,0), (0,1), (0,-1)][i-1]
    }

    func reverseDirection(_ direction: (Int, Int)) -> (Int, Int){
        (direction.0 * -1, direction.1 * -1)
    }


    func mod(_ R: Int, _ C: Int, _ direction: (Int, Int)) -> Int{
        let size = direction.1 == 0 ? R : C
        return 2 * (size - 1)
    }


}
