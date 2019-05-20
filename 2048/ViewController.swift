//
//  ViewController.swift
//  2048
//
//  Created by Александр Андреев on 10/05/2019.
//  Copyright © 2019 Александр Андреев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameBoardCollectionView: UICollectionView!
    
    private var gameBoardDataSource: GameBoardDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
        self.setupDataSource()
    }


}


private extension ViewController {
    
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
        self.gameBoardDataSource = GameBoardDataSource(collectionView: self.gameBoardCollectionView)
        self.gameBoardDataSource.configure()
    }
}
