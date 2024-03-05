//
//  Beakjoon1655.swift
//  Beakjoon
//
//  Created by 한현규 on 3/5/24.
//

import Foundation



class Beakjoon1655{
    
    func main(){
        let n = Int(readLine()!)!
        printMiddleNums(n)
    }

    ///  mid -> maxHeap Top
    ///  maxHeap <  mid < minHeap
    ///
    ///  maxRoot > minRoot
    ///  swap maxRoot, minRoot
    
    func printMiddleNums(_ n: Int){
        var result = ""
        var maxHeap = PriorityQueue<Int>(ascending: false)
        var minHeap = PriorityQueue<Int>(ascending: true)
                
        result += ""
        
        for _ in 0..<n{
            let num = Int(readLine()!)!
            if maxHeap.count == minHeap.count{
                maxHeap.push(num)
            }else{
                minHeap.push(num)
            }
            
            if !minHeap.isEmpty && !maxHeap.isEmpty &&  maxHeap.peek()! > minHeap.peek()!{
                let maxTop = maxHeap.pop()!
                let minTop = minHeap.pop()!
                
                maxHeap.push(minTop)
                minHeap.push(maxTop)
            }
            
            result += "\(maxHeap.peek()!)\n"
        }
        print(result)
    }
}
