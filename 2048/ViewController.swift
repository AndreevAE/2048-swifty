//
//  ViewController.swift
//  2048
//
//  Created by Александр Андреев on 10/05/2019.
//  Copyright © 2019 Александр Андреев. All rights reserved.
//

import UIKit

// TODO: SAVE BOARD ON RESTART APP (UserDefaults) !!!
// TODO: add animations
// TODO: add restart button

class ViewController: UIViewController {

    @IBOutlet weak var gameBoardCollectionView: UICollectionView!
    
    private var gameBoard: GameBoard!
    private var gameBoardDataSource: GameBoardDataSource!
    private var gameController: GameController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
        self.setupDataSource()
        self.addSwipeGesture()
        
        self.gameController.startGame()
    }

    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        print("swipe")
        switch gesture.direction {
        case .left:
            print("left")
            self.gameController.swipe(to: .left)
            self.gameBoardDataSource.update()
        case .right:
            print("right")
            self.gameController.swipe(to: .right)
            self.gameBoardDataSource.update()
        case .up:
            print("up")
            self.gameController.swipe(to: .up)
            self.gameBoardDataSource.update()
        case .down:
            print("down")
            self.gameController.swipe(to: .down)
            self.gameBoardDataSource.update()
        default:
            print(gesture.direction)
        }
    }
    
}


private extension ViewController {
    
    func addSwipeGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.yellow
        self.gameBoardCollectionView.backgroundColor = UIColor.green
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let layout = UICollectionViewFlowLayout()
        // TODO: normalize item size calculating
        let itemSize = ((screenWidth - 10 * 3 - 20 * 2) / 4)
        print("ScreenSize \(screenSize)")
        print("ScreenWidth \(screenWidth)")
        print("ItemSize \(itemSize)")
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        self.gameBoardCollectionView.collectionViewLayout = layout
    }
    
    func setupDataSource() {
        self.gameBoard = GameBoard()
        self.gameController = GameController(board: self.gameBoard)
        self.gameBoardDataSource = GameBoardDataSource(collectionView: self.gameBoardCollectionView, board: self.gameBoard)
        self.gameBoardDataSource.configure()
    }
}
