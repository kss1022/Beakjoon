//
//  Beakjoon1911.swift
//  Beakjoon
//
//  Created by 한현규 on 1/15/24.
//

import Foundation



class Beakjoon1911{
    func main(){
        let n = Int(readLine()!)!
        
        
        var nodes =  [Character: Node]()
        
        let root = Node("A")
        nodes["A"] = root

                
        for _ in 1..<n{
            let nodeInfo = readLine()!.components(separatedBy: .whitespaces).compactMap(Character.init)
            
            let node = nodeInfo[0]
            
            if nodeInfo[1] != "."{
                let left = Node(nodeInfo[1])
                nodes[nodeInfo[1]] = left
                nodes[node]!.left = left
            }
            
            if nodeInfo[2] != "."{
                let right = Node(nodeInfo[2])
                nodes[nodeInfo[2]] = right
                nodes[node]!.right = right
            }
        }
        
        var preOrder = ""
        preOrderRecursive(node: root, result: &preOrder)
            
        var inOrder = ""
        inOrderRecursive(node: root, result: &inOrder)
        
        var postOrder = ""
        postOrderRecursive(node: root, result: &postOrder)
        
        print(preOrder)
        print(inOrder)
        print(postOrder)
    }

    func preOrderRecursive(node: Node?, result: inout String){
        guard let node = node else { return }
        result.append(node.value)
        preOrderRecursive(node: node.left, result: &result)
        preOrderRecursive(node: node.right, result: &result)
    }

    func inOrderRecursive(node: Node?, result: inout String){
        guard let node = node else { return }
        inOrderRecursive(node: node.left, result: &result)
        result.append(node.value)
        inOrderRecursive(node: node.right, result: &result)
    }

    func postOrderRecursive(node: Node?, result: inout String){
        guard let node = node else { return }
        postOrderRecursive(node: node.left, result: &result)
        postOrderRecursive(node: node.right, result: &result)
        result.append(node.value)
    }


    class Node: Hashable{
        let value: Character
        var left: Node?
        var right: Node?
        
        
        init(_ value: Character) {
            self.value = value
            self.left = nil
            self.right = nil
        }

        func hash(into hasher: inout Hasher){
            hasher.combine(value)
        }
        
        static func == (lhs: Node, rhs: Node) -> Bool {
            lhs.value == rhs.value
        }

    }

}
