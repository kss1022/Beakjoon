//
//  Beakjoon14503.swift
//  Beakjoon
//
//  Created by 한현규 on 2/7/24.
//

import Foundation



class Beakjoon14503{

    func main(){
        let sizes = readLine()!.components(separatedBy: .whitespaces)
            .compactMap(Int.init)
            
        let row = sizes[0]
        let _ = sizes[1]
        
        let start = readLine()!.components(separatedBy: .whitespaces)
            .compactMap(Int.init)
        
        var room = [[Int]]()
        for _ in 0..<row{
            let row = readLine()!.components(separatedBy: .whitespaces)
                .compactMap(Int.init)
            room.append(row)
        }
        
        cleanRooms(room: room, position: (start[0], start[1]), direction: Direction(rawValue: start[2])!)
    }



    func cleanRooms(room: [[Int]], position: (Int, Int), direction: Direction){
        var room = room
        var count = 0
        cleanRoomRecursive(room: &room, position: position, direction: direction, count: &count)
        print(count)
    }

    //0: not clean , 1: wall
    func cleanRoomRecursive(room: inout [[Int]], position: (Int, Int), direction: Direction, count: inout Int){
        
        //1.
        if room[position.0][position.1] == 0{
            room[position.0][position.1] = -1
            count += 1
            cleanRoomRecursive(room: &room, position: position, direction: direction, count: &count)
            return
        }
        
        
        //3
        var nextDirection = direction
        for _ in 0..<4{
            nextDirection = nextDirection.rotate()
            let move = nextDirection.move()
            
            let row = move.0 + position.0
            let col = move.1 + position.1
            
            if row < 0 || col < 0 || row >= room.count || col >= room[0].count{
                continue
            }

            if room[row][col] == 0{
                cleanRoomRecursive(room: &room, position: (row, col), direction: nextDirection, count: &count)
                return
            }
        }
        
        
        //2
        let move = direction.backward().move()
        let row = move.0 + position.0
        let col = move.1 + position.1
        
        if row < 0 || col < 0 || row >= room.count || col >= room[0].count{
            return
        }
        
        if room[row][col] == 1{
            return
        }
        
        cleanRoomRecursive(room: &room, position: (row, col), direction: direction, count: &count)
    }


    enum Direction: Int{
        case up     //0
        case right  //1
        case down   //2
        case left   //3
        
        func move() -> (Int , Int){
            switch self {
            case .up: return (-1 ,0)
            case .right: return (0 ,1)
            case .down: return (1, 0)
            case .left: return (0, -1)
            }
        }
        
        func rotate() -> Direction{
            switch self {
            case .up: return .left
            case .right: return .up
            case .down: return .right
            case .left: return .down
            }
        }
        
        func backward() -> Direction{
            switch self {
            case .up: return .down
            case .right: return .left
            case .down: return .up
            case .left: return .right
            }
        }
    }


}
