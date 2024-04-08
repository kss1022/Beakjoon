//
//  Beakjoon9328.swift
//  Beakjoon
//
//  Created by 한현규 on 4/8/24.
//

import Foundation



class Beakjoon9328{
    func main(){
        let testCases = Int(readLine()!)!
        for _ in 0..<testCases{
            steakKeys()
        }
    }


    //'.': empty
    //'*': wall
    //'$': steak
    //upper: door
    //lower: key


    func steakKeys(){
        let sizes = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let r = sizes[0]
        let c = sizes[1]
        
        
        var map = [[Character]]()
        
        
        map.append(Array.init(repeating: ".", count: c+2))
        for _ in 0..<r{
            var row = [Character]()
            row += ["."]
            row += readLine()!.compactMap { $0 }
            row += ["."]
            map.append(row)
        }
        map.append(Array.init(repeating: ".", count: c+2))
        
        var keys = Set<Int>()
        
        readLine()!.forEach { key in
            if key != "0"{
                setKey(&keys, key)
            }
        }
        
        
        var result = 0
        searchDocument(r+2, c+2, map, keys, &result)
        print(result)
    }


    func searchDocument(
        _ r: Int, _ c: Int,
        _ defaultMap: [[Character]], _ defaultKeys: Set<Int>,_ result: inout Int
    ){
        var map = defaultMap
        var keys = defaultKeys
        
        
        var visited = emptyVisited(r, c)
        
        
        var queue = [(Int, Int)]()
        queue.append((0,0))
        visited[0][0] = true
        
        while !queue.isEmpty{
            let position = queue.removeFirst()
            
            if isDocument(map[position.0][position.1]){
                map[position.0][position.1] = "."
                result += 1
            }
            
            let moves = [(1,0),(-1,0),(0,1),(0,-1)]
            for move in moves {
                let nextRow = move.0 + position.0
                let nextCol = move.1 + position.1
                
                if nextRow < 0 || nextCol < 0 || nextRow >= r || nextCol >= c{
                    continue
                }
                
                if visited[nextRow][nextCol]{
                    continue
                }
                
                let next = map[nextRow][nextCol]
                if isWall(next){
                    continue
                }
                
                if isDoor(next){
                    if !openDoor(keys, next){
                        continue
                    }
                    
                    visited[nextRow][nextCol] = true
                    queue.append((nextRow, nextCol))
                    continue
                }
                
                
                if isKey(next) && !hasKey(keys, next){
                    setKey(&keys, next)
                    visited = emptyVisited(r, c)
                    queue.append((nextRow, nextCol))
                    continue
                }
                
                visited[nextRow][nextCol] = true
                queue.append((nextRow, nextCol))
            }
        }
    }



    //A ~ Z
    //65 ~ 90
    //97 ~ 122



    func isDoor(_ character: Character) -> Bool{
        guard let ascii = character.asciiValue else  { return false }
        return 65 <= ascii && ascii <= 90
    }

    func openDoor(_ keys: Set<Int>, _ door: Character) -> Bool{
        assert(isDoor(door) == true)
        let key = Int(door.asciiValue! - 65)
        return keys.contains(key)
    }

    func isKey(_ character: Character) -> Bool{
        guard let ascii = character.asciiValue else  { return false }
        return 97 <= ascii && ascii <= 122
    }


    func setKey(_ keys: inout Set<Int>, _ key: Character){
        let key = Int(key.asciiValue! - 97)
        keys.insert(key)
    }

    func hasKey(_ keys: Set<Int>, _ key: Character) -> Bool{
        let key = Int(key.asciiValue! - 97)
        return keys.contains(key)
    }

    func isWall(_ char: Character) -> Bool{
        char == "*"
    }

    func isDocument(_ char: Character) -> Bool{
        char == "$"
    }


    func emptyVisited(_ r: Int, _ c : Int) -> [[Bool]]{
        Array.init(
            repeating: Array.init(repeating: false, count: c),
            count: r
        )
    }

}
