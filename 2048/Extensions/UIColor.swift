//
//  UIColor.swift
//  2048
//
//  Created by Александр Андреев on 10/05/2019.
//  Copyright © 2019 Александр Андреев. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let background = UIColor(r: 242, g: 243, b: 245)
    
    static let blackNumber = UIColor.black
    static let whiteNumber = UIColor.white
    
    static let cellBackground_empty = UIColor(r: 185, g: 192, b: 202)
    static let cellBackground_2 = UIColor.white
    static let cellBackground_4 = UIColor(r: 225, g: 226, b: 229)
    static let cellBackground_8 = UIColor(r: 175, g: 220, b: 253)
    static let cellBackground_16 = UIColor(r: 124, g: 178, b: 250)
    static let cellBackground_32 = UIColor(r: 81, g: 137, b: 231)
    static let cellBackground_64 = UIColor(r: 56, g: 100, b: 210)
    static let cellBackground_128 = UIColor(r: 42, g: 74, b: 179)
    static let cellBackground_256 = UIColor(r: 44, g: 64, b: 130)
    static let cellBackground_512 = UIColor(r: 30, g: 47, b: 130)
    static let cellBackground_1024 = UIColor(r: 25, g: 30, b: 180)
    static let cellBackground_2048 = UIColor(r: 19, g: 11, b: 110)
    
    convenience init(r: Int, g: Int, b: Int, a: Int = 255) {
        self.init(red:CGFloat(r)/255.0, green:CGFloat(g)/255.0, blue:CGFloat(b)/255.0, alpha:CGFloat(a)/255.0)
    }
}
