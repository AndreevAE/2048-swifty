//
//  GameBoardCollectionViewCell.swift
//  2048
//
//  Created by Александр Андреев on 10/05/2019.
//  Copyright © 2019 Александр Андреев. All rights reserved.
//

import Foundation
import UIKit

final class GameBoardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    static let identifier = "numberCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
    func configure(number: Int, numberColor: UIColor, backgroundColor: UIColor) {
        if number != 0 {
            self.numberLabel.text = "\(number)"
        } else {
            self.numberLabel.text = ""
        }
        self.numberLabel.textColor = numberColor
        self.backgroundColor = backgroundColor
    }
}
