//
//  ColorTheme.swift
//  swipematter
//
//  Created by Jeffery Widroff on 1/16/23.
//

import Foundation
import UIKit

class ColorTheme { //TODO: Make all of these into static vars
    
    var gameBackground = UIColor()
    static var boardBackground = UIColor()
    static var pieceBackground = UIColor()
    static var lockedPieceBackground = UIColor()
    var holeColor = UIColor()
    var gridLineColor = UIColor()
    var lockPieceScrewColor = UIColor()
    var buttonColors = UIColor()
    var buttonTextColor = UIColor()
    
    var gradientBackgroundColor = [UIColor]()
    
    init() {
        
//        gameBackground = UIColor.yellow
        ColorTheme.boardBackground = UIColor(red: 0.6, green: 0.5, blue: 0.7, alpha: 0.5)
        ColorTheme.pieceBackground = UIColor(red: 0.6, green: 0.5, blue: 0.7, alpha: 0.7)
//        pieceBackground = UIColor.clear
        ColorTheme.lockedPieceBackground = UIColor(red: 0.2, green: 0.1, blue: 0.2, alpha: 1.0)
        
        lockPieceScrewColor = UIColor.lightGray
        holeColor = gameBackground
        gridLineColor = gameBackground
        buttonColors = UIColor.white
        buttonTextColor = UIColor.black
        gradientBackgroundColor = [UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0), UIColor.init(red: 0.9, green: 0.1, blue: 0.7, alpha: 1.0)] // DEFAULT
    }
}

struct PieceColors {
    
    static var red = UIColor.init(red: 0.8, green: 0.4, blue: 0.0, alpha: 0.8)
    static var blue = UIColor.init(red: 0.0, green: 0.8, blue: 0.8, alpha: 0.8)
    static var green = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.8)
}






