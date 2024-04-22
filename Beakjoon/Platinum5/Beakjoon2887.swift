//
//  Beakjoon2887.swift
//  Beakjoon
//
//  Created by 한현규 on 4/22/24.
//

import Foundation



class Beakjoon2887{

    //n 개의 행성
    //3차원 좌표 a , b의  비용   min(|aX-bX|, |aY-bY|, |aZ-bZ|)
    //n - 1개의 터널을 건설하여  모든 행성으로 서로 연결 하는데 최소 비용

    typealias Coordinate = (x: Int,y: Int,z: Int)
    typealias Edge = (a: Int, b: Int, distance: Int)

    func main(){
        let n = Int(readLine()!)!
        
        var planetCoordnates  = [Coordinate]()
        for _ in 0..<n{
            let planetCoordinate = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            planetCoordnates.append((planetCoordinate[0],planetCoordinate[1],planetCoordinate[2]))
        }
        minConnectionPrice(n, planetCoordnates)
    }


    //kruskal
    func minConnectionPrice(_ n: Int, _ planetCoordinates: [Coordinate]){
        let edges = sortedEdges(n, planetCoordinates)
               
        var parents = Array.init(repeating: 0, count: n)
        for i in 0..<n{
            parents[i] = i
        }
        
        
        var result = 0

        for i in 0..<edges.count{
            let edge = edges[i]
                    
            if parent(edge.a, &parents) == parent(edge.b, &parents){
                continue
            }
            
            union(edge.a, edge.b, &parents)
            result += edge.distance
        }
        
        
        print(result)
    }


    func sortedEdges(_ n: Int, _ planetCoordinates: [Coordinate]) -> [Edge]{
        
        
        let sortedByX =  planetCoordinates.enumerated()
            .map { ($0.offset, $0.element.x)}
            .sorted { $0.1 < $1.1 }
        
        let sortedByY =  planetCoordinates.enumerated()
            .map { ($0.offset, $0.element.y)}
            .sorted { $0.1 < $1.1 }
        
        let sortedByZ =  planetCoordinates.enumerated()
            .map { ($0.offset, $0.element.z)}
            .sorted { $0.1 < $1.1 }
        
        var distances = [Edge]()
        
        for i in 1..<n{
            //(vertext, coordinate)
            [sortedByX, sortedByY, sortedByZ].forEach {
                let a = $0[i].0
                let b = $0[i-1].0
                let distance = $0[i].1 - $0[i-1].1
                distances.append((a, b, distance))
            }
        }
             
            
        return distances.sorted { $0.distance < $1.distance }
    }


    func parent(_ planet: Int, _ parents: inout [Int]) -> Int{
        if parents[planet] == planet{
            return planet
        }
        
        parents[planet] = parent(parents[planet], &parents)
        return parents[planet]
    }

    func union(_ a: Int, _ b: Int,_ parents: inout [Int]){
        let aParent = parent(a, &parents)
        let bParent = parent(b, &parents)
            
        if aParent < bParent{
            parents[bParent] = aParent
            return
        }
        
        parents[aParent] = bParent
    }

}
