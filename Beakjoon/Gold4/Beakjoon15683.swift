//
//  Beakjoon15683.swift
//  Beakjoon
//
//  Created by 한현규 on 4/15/24.
//

import Foundation



class Beakjoon15683{


    func main(){
        let sizes = readLine()!.split(separator: " ")
            .compactMap { Int(String($0)) }
        
        let r = sizes[0]
        let c = sizes[1]
        
        var office = [[Int]]()
        
        for _ in 0..<r{
            let row = readLine()!.split(separator: " ")
                .compactMap { Int(String($0)) }
            office.append(row)
        }
        
        blindSpot(r, c, office)
            
    }


    //0: empty
    //6: wall
    //1~5: cctv
    //1: >
    //2: <>
    //3: ^>
    //4: <^>
    //5: <^v>

    func blindSpot(_ r: Int, _ c: Int, _ office: [[Int]]){
        var cctvs = [CCTV]()
                
        for i in 0..<r{
            for j in 0..<c{
                if office[i][j] != 0 && office[i][j] != 6{
                    cctvs.append(CCTV.createCCTV(i, j, office[i][j]))
                }
            }
        }
        
        
        var result = Int.max
        rotateAndCheckCCTVRecursive(0, cctvs, office, &result)
        print(result)
    }


    func rotateAndCheckCCTVRecursive(_ deepth: Int, _ cctvs: [CCTV],_ office: [[Int]], _ result: inout Int){
        if deepth == cctvs.count{
            result = min(blindSpot(office), result)
            return
        }
        
        
        var cctv = cctvs[deepth]
        
        for _ in 0..<4{
            var newOffce = office
            cctv.check(&newOffce)
            rotateAndCheckCCTVRecursive(deepth+1, cctvs, newOffce, &result)
            cctv = cctv.turn()
        }
    }




    func blindSpot(_ office: [[Int]]) -> Int{
        var result = 0
        
        for i in 0..<office.count{
            for j in 0..<office[0].count{
                if office[i][j] == 0{
                    result += 1
                }
            }
        }
        
        return result
    }




    //1: >
    //2: <>
    //3: ^>
    //4: <^>
    //5: <^v>

    class CCTV{
        let row: Int
        let col: Int
        let rotates: [Rotate]
        
        init(_ row: Int, _ col: Int, _ rotate: [Rotate]) {
            self.row = row
            self.col = col
            self.rotates = rotate
        }
        
        static func createCCTV(_ row: Int, _ col: Int, _ type: Int) -> CCTV{
            switch type{
            case 1: return CCTV1(row, col)
            case 2: return CCTV2(row, col)
            case 3: return CCTV3(row, col)
            case 4: return CCTV4(row, col)
            case 5: return CCTV5(row, col)
            default: fatalError()
            }
        }
        
        static func CCTV1(_ row: Int, _ col: Int) -> CCTV{
            CCTV(row, col, [.right])
        }
        
        static func CCTV2(_ row: Int, _ col: Int) -> CCTV{
            CCTV(row, col, [.left, .right])
        }
        
        static func CCTV3(_ row: Int, _ col: Int) -> CCTV{
            CCTV(row, col, [.top, .right])
        }
        
        
        static func CCTV4(_ row: Int, _ col: Int) -> CCTV{
            CCTV(row, col, [.left, .top, .right])
        }
        
        static func CCTV5(_ row: Int, _ col: Int) -> CCTV{
            CCTV(row, col, [.left, .top, .bottom,.right])
        }
        
        func turn() -> CCTV{
            let newRorate = rotates.map {
                $0.rotate()
            }
            return CCTV(row, col, newRorate)
        }
        
        func check(_ office: inout [[Int]]){
            rotates.forEach {
                check($0.move, &office)
            }
        }
        
        private func check(_ move: (Int, Int) ,_ office: inout [[Int]]){
            var nextRow = row + move.0
            var nextCol = col + move.1
            
            while true{
                if nextRow < 0 || nextCol < 0 || nextRow >= office.count || nextCol >= office[0].count{
                    return
                }
                
                if office[nextRow][nextCol] == 6{
                    return
                }
                
                office[nextRow][nextCol] = -1
                
                nextRow += move.0
                nextCol += move.1
            }
        }
    }



    enum Rotate: Int{
        case right
        case bottom
        case left
        case top
        
        var move: (Int, Int){
            switch self {
            case .right: return (0,1)
            case .bottom: return (1,0)
            case .left: return (0,-1)
            case .top: return (-1,0)
            }
        }
        
        func rotate() -> Rotate{
            switch self {
            case .right: return .bottom
            case .bottom: return .left
            case .left: return .top
            case .top: return .right
            }
        }
    }

}
