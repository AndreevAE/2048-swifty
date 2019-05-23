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
    
    init(board: GameBoard) {
        self.board = board
    }
    
    func startGame() {
        self.board.clear()
        self.board.random()
        self.board.random()
    }
    
    func swipe(to direction: SwipeDirection) {
        // Swipe cant realise if numbers dont move, no turn, need try another swipe
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
        @unknown default:
            fatalError("Not Presented Swipe Direction Initialized")
        }
        
        if realized {
            self.board.random()
            if self.isEndGame() {
                self.endGame()
            }
        }
    }
    
    private func isEndGame() -> Bool {
        // if board has 0
        if board.hasEmptyCells() {
            return false
        }
        
        // or adjacent numbers are equal (and can roll up)
        if board.hasAdjacentEqualNumbers() {
            return false
        }
        
        return true
    }
    
    private func swipeToLeft() -> Bool {
        var realized = false
        
        for i in 0..<4 {
            let rolledUpRow = rollUp(row: self.board.row(i))
            if self.board.row(i) != rolledUpRow {
                self.board.row(i, newValue: rolledUpRow)
                realized = true
            }
        }
        
        return realized
    }
    
    private func swipeToRight() -> Bool {
        var realized = false
        
        for i in 0..<4 {
            let reversedRow: [Int] = self.board.row(i).reversed()
            let rolledUpRow = rollUp(row: reversedRow)
            if reversedRow != rolledUpRow {
                self.board.row(i, newValue: rolledUpRow.reversed())
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
        let initCount = row.count
        
        var editedRow = row
        
        // 1. remove zeros
        editedRow = editedRow.filter { $0 != 0 }
        
        if !editedRow.isEmpty {
            // 2. check and 'concat' numbers
            for i in 0..<editedRow.count - 1 {
                if editedRow[i] == editedRow[i+1] {
                    editedRow[i] *= 2
                    editedRow[i+1] = -1
                }
            }
            
            editedRow = editedRow.filter { $0 != -1 }
        }
        
        // 3. advance needed zeros
        while editedRow.count != initCount {
            editedRow.append(0)
        }
        
        return editedRow
    }
    
    func endGame() {
        // TODO:
    }
}
