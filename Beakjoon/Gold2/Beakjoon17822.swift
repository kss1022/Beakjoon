//
//  Beakjoon17822.swift
//  Beakjoon
//
//  Created by 한현규 on 3/15/24.
//

import Foundation



final class Beakjoon17822{
    func main(){
        let nums = readLine()!.split(separator: " ")
            .compactMap{ Int(String($0)) }
        
        let circleCount = nums[0]
        let numCount = nums[1]
        let rotateCount = nums[2]
        
        
        var circles = [[Int]]()
        for _ in 0..<circleCount{
            let nums = readLine()!.split(separator: " ")
                .compactMap{ Int(String($0)) }
            circles.append(nums)
        }
        
        var rotates = [(Int, Int, Int)]()
        
        for _ in 0..<rotateCount{
            let rotate = readLine()!.split(separator: " ")
                .compactMap{ Int(String($0)) }
            rotates.append((rotate[0], rotate[1], rotate[2]))
        }
        
        circleSum(circleCount, numCount, rotateCount, circles, rotates)
    }


    func circleSum(_ circleCount: Int, _ numCount: Int, _ rotateCount: Int, _ circles: [[Int]], _ rotates: [(Int,Int,Int)]){
        
        var circles = circles
        
        print(rotateCircleRecursive(0))
        
        func rotateCircleRecursive(_ deepth: Int) -> Int{
            if deepth == rotateCount{
                return sum()
            }
            
            let rotate = rotates[deepth]
            
            let index = rotate.0
            let direction = rotate.1  // 0 : Clockwise  1: counterclockwise
            let rotateCount = rotate.2
            
            var currentIndex = index
            
            while currentIndex <= circleCount{
                rotateCircle(currentIndex-1, direction == 0, rotateCount)
                currentIndex += index
            }
            
            
            checkNeighbors()
            
            return rotateCircleRecursive(deepth+1)
        }
        
        func rotateCircle(_ index: Int, _ isClockwise: Bool, _ count: Int){
            for _ in 0..<count{
                if isClockwise{
                    let last = circles[index].removeLast()
                    circles[index].insert(last, at: 0)
                }else{
                    let first = circles[index].removeFirst()
                    circles[index].append(first)
                }
            }
        }
        
        func checkNeighbors(){
            
            var isFind = false
            for i in 0..<circleCount{
                for j in 0..<numCount{
                    removeSameNeighbor(i, j, &isFind)
                }
            }
            
            if isFind{
                return
            }
                        
            adjustAverage(average())
        }
        
        func removeSameNeighbor(_ i: Int , _ j: Int, _ find: inout Bool){
            let num = circles[i][j]
            if num == -1{
                return
            }
                    
            var visited = Array.init(
                repeating: Array.init(repeating: false, count: numCount),
                count: circleCount
            )
            
            var results = [(Int, Int)]()
                    
            var stack = [(Int, Int)]()
            stack.append((i,j))
                            
            while !stack.isEmpty{
                let pop = stack.removeLast()
                        
                results.append(pop)
                
                let neighbors = [(0,1), (0,-1), (1,0), (-1,0)]
                for neighbor in neighbors {
                    let nextRow = pop.0 + neighbor.0
                    var nextCol = pop.1 + neighbor.1
                    
                    if nextRow < 0 || nextRow >= circleCount {
                        continue
                    }
                    
                    if nextCol >= numCount{
                        nextCol = 0
                    }
                    
                    if nextCol < 0 {
                        nextCol = numCount-1
                    }
                    
                    if circles[nextRow][nextCol] == -1{
                        continue
                    }
                    
                    if visited[nextRow][nextCol]{
                        continue
                    }
                    
                    if circles[nextRow][nextCol] != num{
                        continue
                    }
                    
                    visited[nextRow][nextCol] = true
                    stack.append((nextRow, nextCol))
                }
            }
            
            if results.count == 1{
                return
            }
            
            find = true
            results.forEach {
                circles[$0.0][$0.1] = -1
            }
        }
        
        
        func sum() -> Int{
            circles.reduce(0) { partialResult, circle in
                let circleSum = circle.filter { $0 != -1 }
                    .reduce(0) { partialResult, num in
                        partialResult + num
                    }
                
                return partialResult + circleSum
            }
        }
        
        func average() -> Double{
            var count = 0
            
            let sum = circles.reduce(0) { partialResult, circle in
                let circleSum = circle.filter { $0 != -1 }
                    .reduce(0) { partialResult, num in
                        count += 1
                        return partialResult + num
                    }
                
                return partialResult + circleSum
            }
            
            return Double(sum) / Double(count)
        }
        
        func adjustAverage(_ average: Double){
            for i in 0..<circleCount{
                for j in 0..<numCount{
                    let current = Double(circles[i][j])
                    if circles[i][j] == -1 || current  == average{
                        continue
                    }
                                    
                     
                    if current < average{
                        circles[i][j] += 1
                        continue
                    }

                    circles[i][j] -= 1
                }
            }
        }
        
    }

}
