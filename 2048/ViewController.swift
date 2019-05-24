//
//  ViewController.swift
//  2048
//
//  Created by Александр Андреев on 10/05/2019.
//  Copyright © 2019 Александр Андреев. All rights reserved.
//

import UIKit

// TODO: add animations

class ViewController: UIViewController {

    @IBOutlet weak var gameBoardCollectionView: UICollectionView!
    @IBOutlet weak var restartButton: UIButton!
    
    private var gameBoard: GameBoard!
    private var gameBoardDataSource: GameBoardDataSource!
    private var gameController: GameController!
    
    private let gameBoardIdentifier = "GameBoard"
    private var wasLoading: Bool = false
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupDataSource()
        self.addSwipeGesture()
        
        if !wasLoading {
            self.gameController.startGame()
        }
    }
    
    @IBAction func onRestartGame(_ sender: UIButton) {
        self.gameController.startGame()
        self.gameBoardDataSource.update()
        
        self.saveGameBoard()
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            self.gameController.swipe(to: .left)
            self.gameBoardDataSource.update()
        case .right:
            self.gameController.swipe(to: .right)
            self.gameBoardDataSource.update()
        case .up:
            self.gameController.swipe(to: .up)
            self.gameBoardDataSource.update()
        case .down:
            self.gameController.swipe(to: .down)
            self.gameBoardDataSource.update()
        default:
            print(gesture.direction)
        }
        
        self.saveGameBoard()
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
        self.view.backgroundColor = UIColor.background
        self.gameBoardCollectionView.backgroundColor = UIColor.clear
        
        self.restartButton.layer.cornerRadius = 10.0
        self.restartButton.layer.shadowRadius = 5.0
        self.restartButton.layer.shadowOpacity = 0.5
        self.restartButton.layer.shadowColor = UIColor.black.cgColor
        self.restartButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let layout = UICollectionViewFlowLayout()
        // TODO: normalize item size calculating
        let itemSize = ((screenWidth - 10 * 3 - 20 * 2) / 4)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        self.gameBoardCollectionView.collectionViewLayout = layout
    }
    
    func setupDataSource() {
        self.wasLoading = self.loadGameBoard()
        
        self.gameController = GameController(board: self.gameBoard)
        self.gameBoardDataSource = GameBoardDataSource(collectionView: self.gameBoardCollectionView, board: self.gameBoard)
        self.gameBoardDataSource.configure()
    }
    
    func loadGameBoard() -> Bool {
        guard let gameBoardData = UserDefaults.standard.object(forKey: self.gameBoardIdentifier) as? NSData else {
            self.gameBoard = GameBoard()
            return false
        }

        guard let board = NSKeyedUnarchiver.unarchiveObject(with: gameBoardData as Data) as? GameBoard else {
            self.gameBoard = GameBoard()
            return false
        }

        self.gameBoard = board
        return true
    }

    func saveGameBoard() {
        let defaults = UserDefaults.standard
        
        let gameBoardData = NSKeyedArchiver.archivedData(withRootObject: self.gameBoard as Any)

        defaults.set(gameBoardData, forKey: self.gameBoardIdentifier)
        defaults.synchronize()
    }
}
