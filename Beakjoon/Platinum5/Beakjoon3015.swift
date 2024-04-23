//
//  Beakjoon3015.swift
//  Beakjoon
//
//  Created by 한현규 on 4/23/24.
//

import Foundation



class Beakjoon3015{

    func main(){
        let n = Int(readLine()!)!
        var heights = [Int]()
        for _ in 0..<n{
            heights.append(Int(readLine()!)!)
        }
        
        faceToFace(n, heights)
    }


    ///(1 ≤ N ≤ 500,000)
    /// height <  2^31

    ///
    /// Stack descending
    /// if stack.top < newHeight ->
    /// 가려지는 인원들을 제거 -> 오른쪽과 마주치는거 추가
    ///
    ///
    /// if stack.top == newHeight ->
    /// 같은 높이의 인원을 증가시키고.  같은 높이에서의 pair추가
    ///
    ///
    /// if !stack.isEmpty -> 왼쪽과 마주봄
    ///
    ///


    typealias HEIGHT = (height: Int, n: Int)


    func faceToFace(_ n: Int, _ heights: [Int]){
        var stack = [HEIGHT]()
        
        var result = 0
                
        for i in 0..<n{
            let height = heights[i]
            var count = 1
            
            while !stack.isEmpty && stack.last!.height < height{
                let pop = stack.removeLast()
                result += pop.n
                
            }
            
            if !stack.isEmpty && stack.last!.height == height{
                let pop = stack.removeLast()
                count += pop.n
                result += pop.n
            }
            
            if !stack.isEmpty{
                result += 1
                
            }
            
            stack.append((height, count))
        }


        
        
        
        print(result)
    }

}
