//
//  ShapeView.swift
//  swipematter
//
//  Created by Jeffery Widroff on 1/16/23.
//

import Foundation
import UIKit

class ShapeView : UIView {
    
//    var shape:Shape = .blank
//    var version = Int()
    var colors = [CGColor]()
//    var switches = Int()
//    var isLocked: Bool?
//    var doesPivot: Bool?
//    var nextPiece: Piece?
    var context : CGContext?
//    var rotations = 0
    
    private var colorTheme = ColorTheme()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, piece: Piece, groups: [Group]?) {

        super.init(frame: frame)

//        if let nextPieceX = piece.nextPiece {
//            self.nextPiece = nextPieceX
//        }
        
//        isLocked = piece.isLocked
//        doesPivot = piece.doesPivot

        makeSoft()
                
        if let groups = groups {
            
            for group in groups {
                
                if group.pieces.contains(where: { (pieceX) -> Bool in
                    pieceX.indexes == piece.indexes
                }) {
                    
//                    self.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                    setViewForGroupedPiece(group: group, piece: piece)
                    
//                    let cushion = (frame.width / 9) / 2
//
//                    self.frame = CGRect(x: frame.minX - cushion, y: frame.minY - cushion, width: frame.width / 9 * 10, height: frame.height / 9 * 10)
//                    self.center =
                }
                
            }
            
           
        }

        addTopView(piece: piece, groups: groups)
        
        
    }
    
  
    
    func addSubview4GroupedPieces(side: String) {
        
        var frame1 = CGRect()
        var frame2 = CGRect()
        
        
        let widthAndHeight = frame.width / 10
        let distanceFromEdge = (frame.width / 4) - (widthAndHeight / 2)
        let topLeftCenter = CGPoint(x: distanceFromEdge, y: distanceFromEdge)
        
        let topRightCenter = CGPoint(x: frame.width - distanceFromEdge, y: distanceFromEdge)
        
        
        
        let bottomLeftCenter = CGPoint(x: distanceFromEdge , y: frame.height - distanceFromEdge)
        
        let bottomRightCenter = CGPoint(x: frame.width - distanceFromEdge, y: frame.height - distanceFromEdge)
        
        switch side {
            
        case "bottom":
            
            

            let width = widthAndHeight
            let height = frame.height - bottomRightCenter.y
            
            frame1 = CGRect(x: bottomRightCenter.x, y: bottomRightCenter.y, width: width, height: height)

            frame2 = CGRect(x: bottomLeftCenter.x - width, y: bottomLeftCenter.y, width: width, height: height)
            
        case "top":

            let width = widthAndHeight
            let height = frame.height - bottomRightCenter.y
            
            frame1 = CGRect(x: topRightCenter.x, y: 0, width: width, height: height)

            frame2 = CGRect(x: topLeftCenter.x - width, y: 0, width: width, height: height)
            
            
        case "right":
            
            print()
            let width = frame.width - topRightCenter.x
            let height = widthAndHeight
            
            frame1 = CGRect(x: bottomRightCenter.x, y: bottomRightCenter.y, width: width, height: height)

            frame2 = CGRect(x: topRightCenter.x, y: topRightCenter.y - height, width: width, height: height)
            
        case "left":
            print()
            let width = frame.width - topRightCenter.x
            let height = widthAndHeight
            
            frame1 = CGRect(x: 0, y: bottomRightCenter.y, width: width, height: height)

            frame2 = CGRect(x: 0, y: topRightCenter.y - height, width: width, height: height)
        default:
            
            break
            
            
        }
        
        let view1 = UIView(frame: frame1)
        let view2 = UIView(frame: frame2)
        
        view1.backgroundColor = UIColor.darkGray
        view2.backgroundColor = UIColor.darkGray
        
        view1.layer.cornerRadius = widthAndHeight / 2
        view2.layer.cornerRadius = widthAndHeight / 2

        addSubview(view1)
        addSubview(view2)
        
        
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
                addSubview4GroupedPieces(side: "bottom")
                
                
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
                addSubview4GroupedPieces(side: "top")
                
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
                addSubview4GroupedPieces(side: "right")
                
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
                
                addSubview4GroupedPieces(side: "left")
                
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
            
            print("Piece Index = \(piece.indexes), subLayer0Width \(subLayer0Width), subLayer0Height \(subLayer0Height), subLayer1Width \(subLayer1Width), subLayer1Height \(subLayer1Height)")
            
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
        var cornerRadius: CGFloat = 1
        var frame = CGRect.zero
        
//        if doesPivot == false {
            
//            cornerRadius = 5
            frame = self.bounds
            
//        } else {
//
////            if shape != .blank {
//                cornerRadius = self.frame.width / 2
//                frame = self.layer.bounds
////            }
//            
//        }
        
        let shadowRadius: CGFloat = 1
        let darkShadow = CALayer()
        darkShadow.frame = frame
        darkShadow.backgroundColor = ColorTheme.pieceBackground.cgColor
        darkShadow.shadowColor = UIColor.black.cgColor
        darkShadow.cornerRadius = cornerRadius
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = shadowRadius
        self.layer.insertSublayer(darkShadow, at: 0)

        let lightShadow = CALayer()
        lightShadow.frame = frame
        lightShadow.backgroundColor = ColorTheme.pieceBackground.cgColor
        lightShadow.shadowColor = UIColor.white.cgColor
        lightShadow.cornerRadius = cornerRadius
        lightShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = shadowRadius
        self.layer.insertSublayer(lightShadow, at: 1)
    }
}

class ShapeViewTopView: UIView {
    
//    var shape:Shape = .blank
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
    
    override func layoutSubviews() {
        
//        if doesPivot == true {
//
//            self.layer.cornerRadius = self.frame.width / 2
//
//        } else {
//            self.layer.cornerRadius = 5
//        }
        
    }

}

