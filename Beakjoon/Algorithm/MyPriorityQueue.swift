//
//  MyPriorityQueue.swift
//  Beakjoon
//
//  Created by 한현규 on 2/22/24.
//

import Foundation


public struct MyPriorityQueue<T: Comparable>{
    
    fileprivate var heap = [T]()
    private let ordered: (T, T) -> Bool
    
    init(ascending: Bool = false) {
        ordered = ascending ? { $0 > $1} : { $0 < $1 }
    }

    mutating func push(_ element: T){
        heap.append(element)
        swim(heap.count-1)
    }
    
    mutating func pop() -> T?{
        if heap.isEmpty{ return nil}
        
        let count = heap.count
        if count == 1{ return heap.removeFirst() }
        
        return fastPop(newCount: count - 1)
    }
    
    
    
    private mutating func swim(_ index: Int){
        var index = index

        while index > 0 ||  ordered(parent() , current()){
            heap.swapAt( (index-1), index)
            index = (index-1) / 2
        }
                
        func parent() -> T{
            heap[(index-1) / 2]
        }
        func current() -> T{
            heap[index]
        }
    }
    

    private mutating func fastPop(newCount: Int) -> T?{
        var index = 0
                
        //swap rootNode, lastNode
        //order
        //heap.removeLast
        
        heap.withUnsafeMutableBufferPointer { bufferPointer in
            let _list = bufferPointer.baseAddress!
                        
            swap(&_list[0], &_list[newCount])
            
            //2 * index + 1  = left child
            while 2 * index + 1 < newCount {
                var j = 2 * index + 1
                if j < (newCount - 1) && ordered(_list[j], _list[j+1]) { j += 1 } //has right child &&  left < right
                if !ordered(_list[index], _list[j]) { return }
                swap(&_list[index], &_list[j])
                index = j
            }
        }
        
        return heap.removeLast()
    }
    
    
}
