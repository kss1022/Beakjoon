//
//  Beakjoon15685.swift
//  Beakjoon
//
//  Created by 한현규 on 3/1/24.
//

import Foundation



class Beakjoon15685{
    func main(){
        let n = Int(readLine()!)!
        var curves = [(Int, Int, Int, Int)]()
        
        for _ in 0..<n{
            let curve = readLine()!.split(separator: " ")
                .compactMap{ Int(String($0)) }
            curves.append((curve[0], curve[1], curve[2], curve[3]))
        }
        
        dragonCurveSquare(n, curves)
    }

    //  0: (→)
    //  1: (↑)
    //  2: (←)
    //  3: (↓)

    func dragonCurveSquare(_ n: Int, _ curves: [(Int, Int, Int, Int)]){
        var points = Set<Point>()
        
        curves.forEach { curve in
            let newPoints = dragonCurve(x: curve.0, y: curve.1, direction: curve.2, generation: curve.3)
            for newPoint in newPoints {
                points.insert(newPoint)
            }
        }

            
        
        var result = 0
        points.forEach { point in
            let neighbors = [(1,0), (0,1), (1,1)]
            
            var isSquare = true
            for neighbor in neighbors {
                
                let newPoint = Point(point.x+neighbor.0, point.y+neighbor.1)
                if !points.contains(newPoint){
                    isSquare = false
                    break
                }
            }
            
            if isSquare{
                result += 1
            }
        }
        
        print(result)
    }



    func dragonCurve(x: Int, y: Int, direction: Int, generation: Int) -> [Point]{
        var points = [Point]()
        let moves =  drawCurveRecursive(x: x, y: y, generation: generation, direction: direction)
        
        var point = Point(x, y)
        points.append(point)
        
        for move in moves {
            let directions = [(1,0), (0,-1), (-1,0), (0,1)]//r , t  l , d
            
            let nextX = directions[move].0 + point.x
            let nextY = directions[move].1 + point.y
                    
            point = Point(nextX, nextY)
            points.append(point)
        }
        
        return points
    }

    func drawCurveRecursive(x: Int, y: Int, generation: Int, direction: Int) -> ([Int]){
        if generation == 0{
            return [direction]
        }
        
        
        var result =  drawCurveRecursive(x: x, y: y, generation: generation-1, direction: direction)
            
        for i in stride(from: result.count-1, through: 0, by: -1){
            result.append(rotate(result[i]))
        }
        
        return result
    }


    //  rotate      reverse             result
    //  0 -> 3      3 -> 1              0 -> 1
    //  1 -> 0      0 -> 2              0 -> 2
    //  2 -> 1      1 -> 3              1 -> 3
    //  3 -> 2      2 -> 0              2 -> 0
    func rotate(_ direction: Int) -> Int{
        var result = direction + 1
        
        while result >= 4{
            result -= 4
        }

        return result
    }


    struct Line{
        let start: (Int, Int)
        let end: (Int, Int)
    }


    struct Point: Hashable{
        let x: Int
        let y: Int
        
        init(_ x: Int , _ y: Int){
            self.x = x
            self.y = y
        }

    }


}
