//
//  ShapeView.swift
//  swipematter
//
//  Created by Jeffery Widroff on 1/16/23.
//

import Foundation
import UIKit

class ShapeView : UIView {
    
    var colors = [CGColor]()
    var context : CGContext?
    
    private var colorTheme = ColorTheme()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, piece: Piece, groups: [Group]?) {

        super.init(frame: frame)
        
        makeSoft()
                
        if let groups = groups {
            
            for group in groups {
                
                if group.pieces.contains(where: { (pieceX) -> Bool in
                    pieceX.indexes == piece.indexes
                }) {
                    
                    setViewForGroupedPiece(group: group, piece: piece)
                }
            }
        }
        addTopView(piece: piece, groups: groups)
    }
    
    func setViewForGroupedPiece(group: Group, piece: Piece) {
        
        if let sublayers = layer.sublayers {
            
            var subLayer0Width = 1
            var subLayer0Height = 1
            var subLayer1Width = -1
            var subLayer1Height = -1
            var layerMaxXMinYCorner = CACornerMask.layerMaxXMinYCorner
            var layerMinXMinYCorner = CACornerMask.layerMinXMinYCorner
            var layerMaxXMaxYCorner = CACornerMask.layerMaxXMaxYCorner
            var layerMinXMaxYCorner = CACornerMask.layerMinXMaxYCorner
            
            //If theres a piece below
            if group.pieces.contains(where: { (pieceXX) in
                
                Indexes(x: pieceXX.indexes?.x, y: (pieceXX.indexes?.y!)! - 1) == piece.indexes
            }) {
                
                layerMaxXMaxYCorner = []
                layerMinXMaxYCorner = []
                subLayer0Height = 0
                
                //And a piece to the left
                if group.pieces.contains(where: { (pieceXXX) -> Bool in
                    Indexes(x: (pieceXXX.indexes?.x!)! + 1, y: pieceXXX.indexes?.y) == piece.indexes
                }) {
                    print("A")
                    
                    if subLayer0Width != 0 {
                        subLayer0Width = 1
                    }
                    
                    subLayer1Width = 0
                    
                    if subLayer1Height != 0 {
                        subLayer1Height = -1
                    }
                }
                
                //And a piece to the right
                if group.pieces.contains(where: { (pieceXXX) -> Bool in
                    Indexes(x: (pieceXXX.indexes?.x!)! - 1, y: pieceXXX.indexes?.y) == piece.indexes
                }) {
                    print("B")
                    
                    subLayer0Width = 0
                    
                    if subLayer1Width != 0 {
                        subLayer1Width = -1
                    }
                    
                    if subLayer1Height != 0 {
                        subLayer1Height = -1
                    }
                }
            }
            
            //If theres a piece above
            if group.pieces.contains(where: { (pieceXX) in
                
                Indexes(x: pieceXX.indexes?.x, y: (pieceXX.indexes?.y!)! + 1) == piece.indexes
            }) {
                
                layerMaxXMinYCorner = []
                layerMinXMinYCorner = []
                subLayer1Height = 0
                
                //And a piece to the left
                if group.pieces.contains(where: { (pieceXXX) -> Bool in
                    Indexes(x: (pieceXXX.indexes?.x!)! + 1, y: pieceXXX.indexes?.y) == piece.indexes
                }) {
                    print("C")
                    
                    if subLayer0Width != 0 {
                        subLayer0Width = 1
                    }
                    
                    if subLayer0Height != 0 {
                        subLayer0Height = 1
                    }
                    
                    subLayer1Width = 0
                }
                
                //And a piece to the right
                if group.pieces.contains(where: { (pieceXXX) -> Bool in
                    Indexes(x: (pieceXXX.indexes?.x!)! - 1, y: pieceXXX.indexes?.y) == piece.indexes
                }) {
                    print("D")
                    
                    subLayer0Width = 0
                    
                    if subLayer0Height != 0 {
                        subLayer0Height = 1
                    }
                    
                    if subLayer1Width != 0 {
                        subLayer1Width = -1
                    }
                }
            }
            
            //If theres a piece to the right
            if group.pieces.contains(where: { (pieceXX) in
                
                Indexes(x: ((pieceXX.indexes?.x!)! - 1), y: pieceXX.indexes?.y) == piece.indexes
            }) {
                
                layerMaxXMinYCorner = []
                layerMaxXMaxYCorner = []
                subLayer0Width = 0
                
                //And a piece on bottom
                if group.pieces.contains(where: { (pieceXXX) -> Bool in
                    Indexes(x: pieceXXX.indexes?.x, y: (pieceXXX.indexes?.y!)! - 1) == piece.indexes
                }) {
                    print("E")
                    
                    subLayer0Height = 0
                    
                    if subLayer1Width != 0 {
                        subLayer1Width = -1
                    }
                    
                    if subLayer1Height != 0 {
                        subLayer1Height = -1
                    }
                }
                
                //And a piece on top
                if group.pieces.contains(where: { (pieceXXX) -> Bool in
                    Indexes(x: pieceXXX.indexes?.x, y: (pieceXXX.indexes?.y!)! + 1) == piece.indexes
                }) {
                    print("F")
                    
                    if subLayer0Height != 0 {
                        subLayer0Height = 1
                    }
                    
                    if subLayer1Width != 0 {
                        subLayer1Width = -1
                    }
                    subLayer1Height = 0
                }
            }
            
            //If theres a piece to the left
            if group.pieces.contains(where: { (pieceXX) in
                
                Indexes(x: ((pieceXX.indexes?.x!)! + 1), y: pieceXX.indexes?.y) == piece.indexes
            }) {
                
                layerMinXMinYCorner = []
                layerMinXMaxYCorner = []
                
                subLayer1Width = 0
                                
                //And a piece on bottom
                if group.pieces.contains(where: { (pieceXXX) -> Bool in
                    Indexes(x: pieceXXX.indexes?.x, y: (pieceXXX.indexes?.y!)! - 1) == piece.indexes
                }) {
                    print("G")
                    
                    if subLayer0Width != 0 {
                        subLayer0Width = 1
                    }
                    subLayer0Height = 0
                    
                    if subLayer1Height != 0 {
                        subLayer1Height = -1
                    }
                }
                
                //And a piece on top
                if group.pieces.contains(where: { (pieceXXX) -> Bool in
                    Indexes(x: pieceXXX.indexes?.x, y: (pieceXXX.indexes?.y!)! + 1) == piece.indexes
                }) {
                    print("H")
                    
                    if subLayer0Width != 0 {
                        subLayer0Width = 1
                    }
                    
                    if subLayer0Height != 0 {
                        subLayer0Height = 1
                    }
                    
                    subLayer1Height = 0
                }
            }
            
            sublayers[0].shadowOffset = CGSize(width: subLayer0Width, height: subLayer0Height)
            sublayers[1].shadowOffset = CGSize(width: subLayer1Width, height: subLayer1Height)
            
            sublayers[0].maskedCorners = [layerMaxXMinYCorner, layerMinXMinYCorner, layerMaxXMaxYCorner, layerMinXMaxYCorner]
            sublayers[1].maskedCorners = [layerMaxXMinYCorner, layerMinXMinYCorner, layerMaxXMaxYCorner, layerMinXMaxYCorner]
        }
    }
    
    var groupBackgroundColors = [UIColor.systemTeal, UIColor.red, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple, UIColor.orange, UIColor.magenta, UIColor.systemIndigo, UIColor.cyan, UIColor.darkGray, UIColor.lightGray, UIColor.gray, UIColor.brown, UIColor.systemPink, UIColor.white, UIColor.black]
    
    func addTopView(piece: Piece, groups: [Group]?) {
        
        var topViewBackgroundColor = ColorTheme.pieceBackground
        
        var frameX = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        var indexX = 0
        
        if let groups = groups {
            
            for group in groups {
                
                if group.pieces.contains(where: { (pieceX) -> Bool in
                    pieceX.indexes == piece.indexes
                }) {
                    
                    frameX = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
                    setViewForGroupedPiece(group: group, piece: piece)
                    topViewBackgroundColor = groupBackgroundColors[indexX]
                    
                }
                indexX += 1
            }
        }
        
        let topView = ShapeViewTopView(frame: frameX, piece: piece, backgroundColor: topViewBackgroundColor)
        self.addSubview(topView)
    }
    
    func makeSoft() {
        self.layer.masksToBounds = false
        let frame = self.bounds
        
        let shadowRadius: CGFloat = 1
        let darkShadow = CALayer()
        darkShadow.frame = frame
        darkShadow.backgroundColor = ColorTheme.pieceBackground.cgColor
        darkShadow.shadowColor = UIColor.black.cgColor
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = shadowRadius
        self.layer.insertSublayer(darkShadow, at: 0)

        let lightShadow = CALayer()
        lightShadow.frame = frame
        lightShadow.backgroundColor = ColorTheme.pieceBackground.cgColor
        lightShadow.shadowColor = UIColor.white.cgColor
        lightShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = shadowRadius
        self.layer.insertSublayer(lightShadow, at: 1)
    }
}

class ShapeViewTopView: UIView {
    
    var version = Int()
    var colors = [CGColor]()
    var switches = Int()
    var isLocked = false
    var doesPivot = true
    var nextPiece: Piece?
    
    private var colorTheme = ColorTheme()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, piece: Piece, backgroundColor: UIColor) {
        
        super.init(frame: frame)
        self.clipsToBounds = true
        self.backgroundColor = backgroundColor
    }
}

