//
//  Beakjoon11003.swift
//  Beakjoon
//
//  Created by 한현규 on 4/18/24.
//

import Foundation


class Beakjoon11003{

    func main(){
        let fileIO = FileIO()

        
        let n = fileIO.readInt()
        let L = fileIO.readInt()
        
        var nums = [Int]()
        for _ in 0..<n{
            nums.append(fileIO.readInt())
        }
                
        findMinimunNum(n, L, nums)
    }


    typealias Candidate = (index: Int, num : Int)

    func findMinimunNum(_ n: Int, _ L: Int, _ nums: [Int]){
        
        var queue = Dequeue<Candidate>()
        
        
        var results = ""
        
        for i in 0..<n{
            //index가 최소인 것을 pop,  index index+L부터 제거될수 있음
            if  !queue.isEmpty && queue.front()!.index < i - L + 1{
                _ = queue.dequeueFront()
            }
        
            //newElement보다 작은 기존의 값들을 삭제
            while !queue.isEmpty && queue.rear()!.num > nums[i]{
                _ = queue.dequeueRear()
            }
            
            queue.enqueueRear((i, nums[i]))
            results += "\(queue.front()!.num) "
        }
        
        print(results)
    }


    struct Dequeue<T> {
        private var frontStack = [T]()
        private var rearStack = [T]()

        mutating func enqueueFront(_ element: T) {
            frontStack.append(element)
        }

        mutating func enqueueRear(_ element: T) {
            rearStack.append(element)
        }

        mutating func dequeueFront() -> T? {
            if frontStack.isEmpty {
                frontStack = rearStack.reversed()
                rearStack.removeAll()
            }
            return frontStack.popLast()
        }

        mutating func dequeueRear() -> T? {
            if rearStack.isEmpty {
                rearStack = frontStack.reversed()
                frontStack.removeAll()
            }
            return rearStack.popLast()
        }

        func front() -> T? {
            if let element = frontStack.last {
                return element
            } else {
                return rearStack.first
            }
        }

        func rear() -> T? {
            if let element = rearStack.last {
                return element
            } else {
                return frontStack.first
            }
        }

        var isEmpty: Bool {
            frontStack.isEmpty && rearStack.isEmpty
        }
    }


    final class FileIO {
        private var buffer:[UInt8]
        private var index: Int
        
        init(fileHandle: FileHandle = FileHandle.standardInput) {
            buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
            index = 0
        }
        
        @inline(__always) private func read() -> UInt8 {
            defer { index += 1 }
            
            return buffer.withUnsafeBufferPointer { $0[index] }
        }
        
        @inline(__always) func readInt() -> Int {
            var sum = 0
            var now = read()
            var isPositive = true
            
            while now == 10
                    || now == 32 { now = read() } // 공백과 줄바꿈 무시
            if now == 45{ isPositive.toggle(); now = read() } // 음수 처리
            while now >= 48, now <= 57 {
                sum = sum * 10 + Int(now-48)
                now = read()
            }
            
            return sum * (isPositive ? 1:-1)
        }
        
        @inline(__always) func readString() -> String {
            var str = ""
            var now = read()
            
            while now == 10
                    || now == 32 { now = read() } // 공백과 줄바꿈 무시
            
            while now != 10
                    && now != 32 && now != 0 {
                str += String(bytes: [now], encoding: .ascii)!
                now = read()
            }
            
            return str
        }
    }
    
    //    Use PriorityQueue
    //    func findMinimunNum(_ n: Int, _ L: Int, _ nums: [Int]){
    //
    //        var queue = PriorityQueue<Candidate>(ascending: true)
    //
    //
    //        var results = ""
    //
    //        for i in 0..<n{
    //            queue.push(Candidate(index: i, num: nums[i]))
    //
    //            while queue.first!.index <= i-L{
    //                _ = queue.pop()
    //            }
    //
    //            results.append("\(queue.first!.num) ")
    //        }
    //
    //        print(results)
    //    }
    //
    //    struct Candidate: Comparable{
    //        let index: Int
    //        let num: Int
    //
    //        static func < (lhs: Candidate, rhs: Candidate) -> Bool {
    //            if lhs.num == rhs.num{
    //                return lhs.index < rhs.index
    //            }
    //
    //            return lhs.num < rhs.num
    //        }
    //    }

}
