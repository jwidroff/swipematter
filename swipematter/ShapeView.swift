//
//  ShapeView.swift
//  swipematter
//
//  Created by Jeffery Widroff on 1/16/23.
//

import Foundation
import UIKit

class ShapeView : UIView {
    
//    var colors = [CGColor]()
    var context : CGContext?
    var color = UIColor()
    
    private var colorTheme = ColorTheme()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, piece: Piece, groups: [Group]?) {

        super.init(frame: frame)
        color = piece.color
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
    
    func makeSoft() {
        
        self.layer.masksToBounds = false
        let frame = self.bounds
        
        let shadowRadius: CGFloat = 1
        let darkShadow = CALayer()
        darkShadow.frame = frame
        darkShadow.backgroundColor = color.cgColor
        darkShadow.shadowColor = UIColor.black.cgColor
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = shadowRadius
        self.layer.insertSublayer(darkShadow, at: 0)

        let lightShadow = CALayer()
        lightShadow.frame = frame
        lightShadow.backgroundColor = color.cgColor
        lightShadow.shadowColor = UIColor.white.cgColor
        lightShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = shadowRadius
        self.layer.insertSublayer(lightShadow, at: 1)
    }
}

