//
//  Beakjoon1725.swift
//  Beakjoon
//
//  Created by 한현규 on 4/19/24.
//

import Foundation



class Beakjoon1725{
    func main(){
        let n = Int(readLine()!)!
        
        var heights = [Int]()
        for _ in 0..<n{
            heights.append(Int(readLine()!)!)
        }
        
        rectangleInHistogram2(n, heights)
    }


    func rectangleInHistogram(_ n: Int, _ heights: [Int]){
        print(rectangleInHistogramRecursive(0, n-1, 0, heights))
    }


    func rectangleInHistogramRecursive(_ start: Int, _ end: Int, _ index: Int, _ heights: [Int]) -> Int{
        if start == end{
            return heights[start]
        }
        
        
        let mid = (start + end) / 2
        let leftIndex = (index + 1) * 2
        let rightIndex = leftIndex + 1
        
        let left = rectangleInHistogramRecursive(start, mid, leftIndex, heights)
        let right = rectangleInHistogramRecursive(mid+1, end, rightIndex, heights)
        let merge = mergeHistogram(start, mid, end, heights)
        
        return max(left, right, merge)
    }


    func mergeHistogram(_ start: Int, _ mid: Int, _ end: Int, _ heights: [Int]) -> Int{
        var leftIndex = mid
        var rightIndex = mid
        
        var minHeight = heights[leftIndex]
        var result = minHeight
        
        while start < leftIndex && rightIndex < end{
            
            if heights[leftIndex-1] > heights[rightIndex+1]{
                leftIndex -= 1
                minHeight = min(heights[leftIndex], minHeight)
            }else{
                rightIndex += 1
                minHeight = min(heights[rightIndex], minHeight)
            }
            
            result = max((rightIndex-leftIndex+1) * minHeight , result)
        }
        
        
        while start < leftIndex{
            leftIndex -= 1
            minHeight = min(heights[leftIndex], minHeight)
            result = max((rightIndex-leftIndex+1) * minHeight , result)
        }
        
        while rightIndex < end{
            rightIndex += 1
            minHeight = min(heights[rightIndex], minHeight)
            result = max((rightIndex-leftIndex+1) * minHeight , result)

        }
                
        return result
    }


    typealias Index = Int

    func rectangleInHistogram2(_ n: Int, _ heights: [Int]){
        var result = 0
        
        var stack = [Index]()        //index, height
        
        stack.append(0)
        
        for i in 1..<heights.count{
            
            while !stack.isEmpty && heights[stack.last!] >= heights[i]{
                let height = heights[stack.removeLast()]
                
                //stack.isEmpty  -> width = i
                //before = i-1-topIndex
                let width = stack.isEmpty ? i : (i - 1 - stack.last!);
                result = max(height * width, result);
            }
            stack.append(i)
        }
        
        
        while !stack.isEmpty{
            let height = heights[stack.removeLast()]
            let width = stack.isEmpty ? n : (n - 1 - stack.last!);
            result = max(height * width, result);
        }
        
        print(result)
        
    }

}
