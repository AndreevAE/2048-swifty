//
//  GameBoardDataSource.swift
//  2048
//
//  Created by Александр Андреев on 10/05/2019.
//  Copyright © 2019 Александр Андреев. All rights reserved.
//

import Foundation
import UIKit

final class GameBoardDataSource: NSObject {
    
    let numberColorDict: [Int: UIColor] = [
        0: UIColor.cellBackground_empty,
        2: UIColor.cellBackground_2,
        4: UIColor.cellBackground_4,
        8: UIColor.cellBackground_8,
        16: UIColor.cellBackground_16,
        32: UIColor.cellBackground_32,
        64: UIColor.cellBackground_64,
        128: UIColor.cellBackground_128,
        256: UIColor.cellBackground_256,
        512: UIColor.cellBackground_512,
        1024: UIColor.cellBackground_1024,
        2048: UIColor.cellBackground_2048
    ]
    
    private var collectionView: UICollectionView
    private var board: GameBoard
    private var swipeDirection: SwipeDirection = .none
    
    init(collectionView: UICollectionView, board: GameBoard) {
        self.collectionView = collectionView
        self.board = board
    }
    
    
    func update(swipeDirection: SwipeDirection) {
        self.swipeDirection = swipeDirection
        
        for cell in self.collectionView.visibleCells {
            
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                var cellFrame = cell.frame

                if let direction = self?.swipeDirection {
                    switch direction {
                    case .left:
                        cellFrame.origin.x -= cellFrame.size.width
                        cellFrame.size.width = 0
                    case .right:
                        cellFrame.origin.x += cellFrame.size.width
                        cellFrame.size.width = 0
                    case .up:
                        cellFrame.origin.y -= cellFrame.size.height
                        cellFrame.size.height = 0
                    case .down:
                        cellFrame.origin.y += cellFrame.size.height
                        cellFrame.size.height = 0
                    case .none:
                        break
                    }
                } else {

                }

                cell.frame = cellFrame
            })
        }
        
        self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
    }
    
    func configure() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension GameBoardDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.board.size * self.board.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameBoardCollectionViewCell.identifier, for: indexPath) as? GameBoardCollectionViewCell {
            
            let number = self.board[indexPath.row]
            let numberColor: UIColor = number > 32 ? UIColor.whiteNumber : UIColor.blackNumber
            let backgroundColor: UIColor = self.numberColorDict[self.board[indexPath.row]] ?? UIColor.cellBackground_empty
            
            cell.configure(number: number,
                           numberColor: numberColor,
                           backgroundColor: backgroundColor)
            
            return cell
            
        } else {
            fatalError("Cannot dequeue Game Board Collection View Cell")
        }
    }
    
}

extension GameBoardDataSource: UICollectionViewDelegateFlowLayout {
    
}
