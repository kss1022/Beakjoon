//
//  Beakjoon1918.swift
//  Beakjoon
//
//  Created by 한현규 on 3/5/24.
//

import Foundation



class Beakjoon1918{

    func main(){
        let notation = readLine()!
        postFix(notation)
    }

    func postFix(_ notation: String){
        var result = ""
            
        var stack = [Character]()
        
        
        let isOperator = Set<Character>(["+", "-", "*", "/", "(", ")"])
        let priority: [Character: Int] =  ["+": 0, "-": 0, "*": 1, "/": 1, "(": 2, ")": 2 ]
        
        
        for char in notation{
            if !isOperator.contains(char){   //isOperand
                result.append(char)
                continue
            }
            
            
            if char == "("{
                stack.append(char)
                continue
            }
            
            if char == ")"{
                while true{
                    let pop = stack.removeLast()
                    if pop == "("{
                        break
                    }
                    result.append(pop)
                }
                continue
            }
            
            
            if stack.isEmpty{
                stack.append(char)
                continue
            }
            
            while !stack.isEmpty{
                if stack.last! == "("{
                    break
                }
                
                if priority[stack.last!]! < priority[char]!{
                   break
                }
                
                result.append(stack.removeLast())
            }
            stack.append(char)
        }
        
        print(result + stack.reversed())
    }

}
