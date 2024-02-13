//
//  Beakjoon3190.swift
//  Beakjoon
//
//  Created by 한현규 on 2/13/24.
//

import Foundation



class Beakjoon3190{
    func main(){
        let size = Int(readLine()!)!
        
        var apples = Array.init(
            repeating: Array.init(repeating: false, count: size),
            count: size
        )
        
        let appleNum = Int(readLine()!)!
        
        for _ in 0..<appleNum{
            let apple = readLine()!.split(separator: " ").map(String.init)
                .compactMap(Int.init)
            
            apples[apple[0]-1][apple[1]-1] = true
        }
        
        
        var rotates = [Int: Character]()
        let rotateNum = Int(readLine()!)!
        for _ in 0..<rotateNum{
            let move = readLine()!.split(separator: " ").map(String.init)
            let time = Int(move[0])!
            let rotate = Character(move[1])
            rotates[time] = rotate
        }
        
        endGameTimes(size: size,apples: apples, rotates: rotates)
    }


    func endGameTimes(size:Int, apples: [[Bool]], rotates: [Int:Character]){
        var times = 0
        
        
        var bodys =  Array.init(
            repeating: Array.init(repeating: false, count: size),
            count: size
        )
        bodys[0][0] = true
        var moves = [(Int,Int)]()
        moves.append((0,0))
        var apples = apples
        
        
        var head = (0,0)
        var direction = Direction.right
        
        while true{
            head = move(point: head, direction: direction)
            times += 1
            
            
            if head.0 < 0 || head.1 < 0 || head.0 >= size || head.1 >= size{
                print("\(times)")
                return
            }
            
            
            if bodys[head.0][head.1]{
                print("\(times)")
                return
            }
            
            
            if apples[head.0][head.1]{
                apples[head.0][head.1] = false
            }else{
                let tail = moves.removeFirst()
                bodys[tail.0][tail.1] = false
            }
            
            bodys[head.0][head.1] = true
            moves.append(head)
            
            
            if let rotate = rotates[times]{
                if rotate == "D"{
                    direction = rotateRight(direction: direction)
                }else{
                    direction = rotateLeft(direction: direction)
                }
            }
        }
    }

    func move(point: (Int, Int), direction: Direction) -> (Int, Int){
        switch direction {
        case .up: return (point.0-1, point.1)
        case .right: return (point.0, point.1+1)
        case .down: return (point.0+1, point.1)
        case .left: return (point.0, point.1-1)
        }
    }

    func rotateLeft(direction: Direction) -> Direction{
        switch direction {
        case .up: return .left
        case .right: return .up
        case .down: return .right
        case .left: return .down
        }
    }


    func rotateRight(direction: Direction) -> Direction{
        switch direction {
        case .up: return .right
        case .right: return .down
        case .down: return .left
        case .left: return .up
        }
    }

    enum Direction{
        case up
        case right
        case down
        case left
    }



}
