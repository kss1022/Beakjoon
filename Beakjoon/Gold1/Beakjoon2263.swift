//
//  Beakjoon2263.swift
//  Beakjoon
//
//  Created by 한현규 on 3/25/24.
//

import Foundation



class Beakjoon2263{

    func main(){
        let n = Int(readLine()!)!
        
        let inOrder = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        let postOrder = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        preOrder(n, inOrder, postOrder)
    }


    //inorder : left  root  right
    //postOrder: left right root
    //preOrder: root left right


    func preOrder(_ n: Int, _ inOrder: [Int], _ postOrder: [Int]){
        var result = ""
        preOrderRecursive(0, n-1, 0, n-1)
        print(result)
        
        func preOrderRecursive(_ inOrderLeft: Int, _ inOrderRight: Int, _ postOrderLeft: Int, _ postOrderRight: Int){
            if inOrderLeft > inOrderRight || postOrderLeft > postOrderRight{
                return
            }
        
            //post last == root
            let root = postOrder[postOrderRight]
            result += "\(root) "
            
            //inorder : left  root  right
            let rootIndexAtInOrder = inOrder.firstIndex(of: root)!
            let offset =  rootIndexAtInOrder - inOrderLeft
            
            //find Left
            preOrderRecursive(inOrderLeft, rootIndexAtInOrder-1, postOrderLeft, postOrderLeft + offset - 1)
            
            //find Right
            preOrderRecursive(rootIndexAtInOrder+1, inOrderRight, postOrderLeft + offset, postOrderRight - 1)
        }

    }

}
