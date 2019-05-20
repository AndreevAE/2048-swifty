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
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < size && column >= 0 && column < size
    }
    
    // TODO: direct subscript to board [Int] ??
    
    subscript(row: Int) -> [Int] {
        get {
            assert(indexIsValid(row: row, column: 0), "Index out of range")
            
            var column = [Int]()
            
            for j in 0..<self.size {
                column.append(self.board[(row * self.size) + j])
            }
            return column
        }
        set(newValue) {
            assert(indexIsValid(row: row, column: 0), "Index out of range")
            
            for j in 0..<self.size {
                self.board[(row * self.size) + j] = newValue[j]
            }
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


