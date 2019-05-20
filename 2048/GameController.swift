//
//  GameController.swift
//  2048
//
//  Created by Александр Андреев on 21/05/2019.
//  Copyright © 2019 Александр Андреев. All rights reserved.
//

import Foundation

enum SwipeDirection {
    case left, right, up, down
}


class GameController {
    
    private var board: GameBoard
    
    init() {
        self.board = GameBoard()
    }
    
    func startGame() {
        
    }
    
    func restartGame() {
        
    }
    
    func randomNewNumber() {
        // TODO: 2 - 50%, 4 - 50% in free cell of board
        
    }
    
    func swipe(to direction: SwipeDirection) -> Bool {
        // Swipe cant realise if numbers dont move, no turn
        var realized = false
        
        switch direction {
        case .left:
            realized = swipeToLeft()
        case .right:
            realized = swipeToRight()
        case .up:
            realized = swipeToUp()
        case .down:
            realized = swipeToDown()
        default:
            fatalError("Not Presented Swipe Direction Initialized")
        }
        
        return realized
    }
    
    private func swipeToLeft() -> Bool {
        var realized = false
        
        for i in 0..<4 {
            let rolledUpRow = rollUp(row: self.board[i])
            if self.board[i] != rolledUpRow {
                self.board[i] = rolledUpRow
                realized = true
            }
        }
        
        return realized
    }
    
    private func swipeToRight() -> Bool {
        var realized = false
        
        for i in 0..<4 {
            let reversedRow: [Int] = self.board[i].reversed()
            let rolledUpRow = rollUp(row: reversedRow)
            if reversedRow != rolledUpRow {
                self.board[i] = rolledUpRow.reversed()
                realized = true
            }
        }
        
        return realized
    }
    
    private func swipeToUp() -> Bool {
        var realized = false
        
        for j in 0..<4 {
            let rolledUpRow = rollUp(row: self.board.column(j))
            if self.board.column(j) != rolledUpRow {
                self.board.column(j, newValue: rolledUpRow)
                realized = true
            }
        }
        
        return realized
    }
    
    private func swipeToDown() -> Bool {
        var realized = false
        
        for j in 0..<4 {
            let reversedColumn: [Int] = self.board.column(j).reversed()
            let rolledUpRow = rollUp(row: reversedColumn)
            if reversedColumn != rolledUpRow {
                self.board.column(j, newValue: rolledUpRow.reversed())
                realized = true
            }
        }
        
        return realized
    }
    
    private func rollUp(row: [Int]) -> [Int] {
        // Always to left, only one row
        // TODO: calculate rolling up row
        
        return row
    }
    
    func endGame() {
        
    }
}
