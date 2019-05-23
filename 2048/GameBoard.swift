//
//  GameBoard.swift
//  2048
//
//  Created by Александр Андреев on 21/05/2019.
//  Copyright © 2019 Александр Андреев. All rights reserved.
//

import Foundation


class GameBoard {
    
    let size: Int
    private var board: [Int]
    
    init(size: Int = 4) {
        self.size = size
        self.board = [Int](repeating: 0, count: size * size)
    }
    
    func clear() {
        self.board.removeAll(keepingCapacity: true)
        self.board = [Int](repeating: 0, count: size * size)
    }
    
    func random() {
        // 2 - 50%, 4 - 50% in free cell of board
        let randomNumber = [2, 4].randomElement() ?? 2
        
        let boardEmptyPositions = self.board.enumerated().filter { $0.element == 0 }.map { $0.offset }
        let randomPosition = boardEmptyPositions.randomElement()
        
        if let position = randomPosition {
            self.board[position] = randomNumber
        }
    }
    
    func hasEmptyCells() -> Bool {
        return board.contains(0)
    }
    
    // TODO: move this logic to GameController?
    func hasAdjacentEqualNumbers() -> Bool {
        // check rows:
        for i in 0..<self.size {
            for j in 0..<self.size - 1 {
                if self.board[(i * self.size) + j] == self.board[(i * self.size) + j + 1] {
                    return true
                }
            }
        }
        
        // check columns:
        for j in 0..<self.size {
            for i in 0..<self.size - 1 {
                if self.board[(i * self.size) + j] == self.board[((i + 1) * self.size) + j] {
                    return true
                }
            }
        }
        
        return false
    }
    
    // MARK: Subscript funcs
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < size && column >= 0 && column < size
    }
    
    subscript(cell: Int) -> Int {
        get {
            assert(indexIsValid(row: cell / 4, column: cell % 4), "Index out of range")
            return self.board[cell]
        }
        set(newValue) {
            assert(indexIsValid(row: cell / 4, column: cell % 4), "Index out of range")
            self.board[cell] = newValue
        }
    }
    
    func row(_ row: Int) -> [Int] {
        assert(indexIsValid(row: row, column: 0), "Index out of range")
        
        var column = [Int]()
        
        for j in 0..<self.size {
            column.append(self.board[(row * self.size) + j])
        }
        return column
    }
    
    func row(_ row: Int, newValue: [Int]) {
        assert(indexIsValid(row: row, column: 0), "Index out of range")
        
        for j in 0..<self.size {
            self.board[(row * self.size) + j] = newValue[j]
        }
    }
    
    func column(_ column: Int) -> [Int] {
        assert(indexIsValid(row: 0, column: column), "Index out of range")
        
        var row = [Int]()
        
        for i in 0..<self.size {
            row.append(self.board[(i * self.size) + column])
        }
        return row
    }
    
    func column(_ column: Int, newValue: [Int]) {
        assert(indexIsValid(row: 0, column: column), "Index out of range")
        
        for i in 0..<self.size {
            self.board[(i * self.size) + column] = newValue[i]
        }
    }
    
    subscript(row: Int, column: Int) -> Int {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return self.board[(row * self.size) + column]
        }
        set(newValue) {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            self.board[(row * self.size) + column] = newValue
        }
    }
}


