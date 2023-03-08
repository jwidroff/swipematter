//
//  ShapeView.swift
//  swipematter
//
//  Created by Jeffery Widroff on 1/16/23.
//

import Foundation
import UIKit

class ShapeView : UIView {
    
    var shape:Shape = .blank
    var version = Int()
    var colors = [CGColor]()
    var switches = Int()
    var isLocked: Bool?
    var doesPivot: Bool?
    var nextPiece: Piece?
    var context : CGContext?
    var rotations = 0
    
    private var colorTheme = ColorTheme()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, piece: Piece, groups: [Group]?) {

        super.init(frame: frame)

        if let nextPieceX = piece.nextPiece {
            self.nextPiece = nextPieceX
        }
        
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
            
            cornerRadius = 5
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
    
    var shape:Shape = .blank
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
        
        for color in piece.colors {
            
            self.colors.append(color.cgColor)
        }
        
        super.init(frame: frame)
//        self.shape = piece.shape
//        self.version = piece.version
//        self.isLocked = piece.isLocked
//        self.doesPivot = piece.doesPivot
        
        if let nextPieceX = piece.nextPiece {
            self.nextPiece = nextPieceX
        }
        
        
        
        self.clipsToBounds = true
        
        
        if isLocked == true {
            
            self.backgroundColor = ColorTheme.lockedPieceBackground
            
            
        } else {
            
            self.backgroundColor = backgroundColor
            
        }
        
        
        
        
        
    }
    
    override func layoutSubviews() {
        
//        if doesPivot == true {
//
//            self.layer.cornerRadius = self.frame.width / 2
//
//        } else {
            self.layer.cornerRadius = 5
//        }
        
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        guard let context2 = UIGraphicsGetCurrentContext() else {return}
        let path = UIBezierPath()
        let path2 = UIBezierPath()
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let topCenterPoint = CGPoint(x: frame.width / 2, y: 0)
        let bottomCenterPoint = CGPoint(x: frame.width / 2, y: frame.height)
        let leftCenterPoint = CGPoint(x: 0, y: frame.height / 2)
        let rightCenterPoint = CGPoint(x: frame.width, y: frame.height / 2)
        let centerPoint = CGPoint(x: frame.width / 2, y: frame.height / 2)
        context.setLineWidth(frame.height / 4)
        
        switch shape {
            
            
        case .blank:

            print()
//            backgroundColor = PieceColors.green
            

        case .elbow: //MARK: ELBOW VIEW
            
            context.setFillColor(colors[0])
            
            switch version {
            
            case 1:
                drawGradientPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, colors: colors)
            case 2:
                drawGradientPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, colors: colors)
            case 3:
                drawGradientPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, colors: colors)
            case 4:
                drawGradientPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, colors: colors)
                
            default:
                break
            }
            
        case .doubleElbow: //MARK: DOUBLEELBOW VIEW
            
            switch version {
                
            case 1:
                context2.setFillColor(colors[1])
                drawPath(path: path2, context: context2, pivotPoint: topCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[1])
                
                context.setFillColor(colors[0])
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
            case 2:
                context.setFillColor(colors[1])
                drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[1])
                
                context2.setFillColor(colors[0])
                drawPath(path: path2, context: context2, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, color: colors[0])
            case 3:
                context.setFillColor(colors[1])
                drawPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[1])
                
                context2.setFillColor(colors[0])
                drawPath(path: path2, context: context2, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[0])
            case 4:
                context2.setFillColor(colors[1])
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: center, endPoint: topCenterPoint, color: colors[1])
                
                context.setFillColor(colors[0])
                drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[0])
            case 5:
                context.setFillColor(colors[0])
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
                
                context2.setFillColor(colors[1])
                drawPath(path: path2, context: context2, pivotPoint: topCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[1])
            case 6:
                context2.setFillColor(colors[0])
                drawPath(path: path2, context: context2, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, color: colors[0])
                
                context.setFillColor(colors[1])
                drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[1])
            case 7:
                context2.setFillColor(colors[0])
                drawPath(path: path2, context: context2, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[0])
                
                context.setFillColor(colors[1])
                drawPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[1])
            case 8:
                context.setFillColor(colors[0])
                drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[0])
                
                context2.setFillColor(colors[1])
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: center, endPoint: topCenterPoint, color: colors[1])
            default:
                break
            }
            
        case .diagElbow: //MARK: DIAGELBOW VIEW
            
            switch version {
            
            case 1:
                drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, color: colors[0])
                
                context.setFillColor(colors[0])
                
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[1])
                
                context2.setFillColor(colors[1])
                
            case 2:
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[1])
                
                context.setFillColor(colors[1])
                
                drawPath(path: path2, context: context2, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[0])
                
                context2.setFillColor(colors[0])
                
                
            case 3:
                
                drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, color: colors[1])
                
                context.setFillColor(colors[1])
                
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[0])
                
                context2.setFillColor(colors[0])
                
                
            case 4:
                
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
                
                context.setFillColor(colors[0])
                
                drawPath(path: path2, context: context2, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[1])
                
                context2.setFillColor(colors[1])
                
                
                
            default:
                break
            }
            
        case .cross: //MARK: CROSS VIEW
            
            switch version {
            
            case 1:
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: centerPoint, endPoint: bottomCenterPoint, color: colors[0])
                
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: centerPoint, endPoint: rightCenterPoint, color: colors[1])
            case 2:
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: centerPoint, endPoint: rightCenterPoint, color: colors[0])
                
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: centerPoint, endPoint: bottomCenterPoint, color: colors[1])
            case 3:
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: centerPoint, endPoint: rightCenterPoint, color: colors[1])
                
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: centerPoint, endPoint: bottomCenterPoint, color: colors[0])
            case 4:
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: centerPoint, endPoint: bottomCenterPoint, color: colors[1])
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: centerPoint, endPoint: rightCenterPoint, color: colors[0])
            default:
                break
            }
            
        case .pieceMaker: //MARK: PIECEMAKER VIEW
            
            
            let w = frame.width / 2
            let h = frame.height / 2
            let x = ((frame.width / 9 * 10) - w) / 2
            let y = x
            let fillColor = UIColor.yellow.cgColor
            
            context.setFillColor(fillColor)

            switch version {
            case 1:
                
                //Spits a new piece out of the bottom
                let point1 = CGPoint(x: x, y: h )
                let point2 = CGPoint(x: 0, y: frame.height)
                let point3 = CGPoint(x: frame.width , y: frame.height)
                let point4 = CGPoint(x: frame.width - (x), y: h )
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.fillPath()
                
            case 2:
                
                //Spits a new piece out of the left
                let point1 = CGPoint(x: frame.width - ( w), y: y)
                let point2 = CGPoint(x: 0, y: 0)
                let point3 = CGPoint(x: 0, y: frame.height)
                let point4 = CGPoint(x: frame.width - (w), y: frame.height - ((y)))
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.fillPath()
                
            case 3:
                
                //Spits a new piece out of the top
                let point1 = CGPoint(x: x, y: frame.height - ( y))
                let point2 = CGPoint(x: 0, y: 0)
                let point3 = CGPoint(x: frame.width, y: 0)
                let point4 = CGPoint(x: frame.width - (x), y: frame.height - ( y))
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.fillPath()
                
            case 4:
                
                //Spits a new piece out of the right
                let point1 = CGPoint(x:  w, y: y)
                let point2 = CGPoint(x: frame.width, y: 0)
                let point3 = CGPoint(x: frame.width, y: frame.height)
                let point4 = CGPoint(x: w, y: frame.width - (y))
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.fillPath()
                
            default:
                break
            }
            
            //Show Next Piece
//            let w2 = frame.width// / 10 * 5
//            let h2 = frame.height// / 10 * 5
//            let x2 = (frame.width - w2) / 2
//            let y2 = x2
//            let frameX = CGRect(x: x2, y: y2, width: w2, height: h2)
//            let nextPieceView = ShapeView(frame: frameX, piece: nextPiece!)
//            addSubview(nextPieceView)
//            nextPieceView.layer.cornerRadius = nextPieceView.frame.width / 2
//            nextPieceView.layer.shadowRadius = 0
//            nextPiece?.view = nextPieceView
//
//            let scale2 = CGAffineTransform(scaleX: 0.5, y: 0.5)
//            nextPiece!.view.transform = scale2
            
        case .stick: //MARK: STICK VIEW
                       
            let path = UIBezierPath()
            var pivotPoint = CGPoint()
            var center = CGPoint()
            var endpoint = CGPoint()
            
            switch version { //MARK: Had to make changes here
            
            case 1:

                pivotPoint = CGPoint(x: bounds.minX, y: bounds.midY)
                center = CGPoint(x: bounds.midX, y: bounds.midY)
                endpoint = CGPoint(x: bounds.maxX, y: bounds.midY)
                
            case 2:
                
                pivotPoint = CGPoint(x: bounds.midX, y: bounds.minY)
                center = CGPoint(x: bounds.midX, y: bounds.midY)
                endpoint = CGPoint(x: bounds.midX, y: bounds.maxY)

            case 3:
  
                pivotPoint = CGPoint(x: bounds.minX, y: bounds.midY)
                center = CGPoint(x: bounds.midX, y: bounds.midY)
                endpoint = CGPoint(x: bounds.maxX, y: bounds.midY)
                
            case 4:
                
                pivotPoint = CGPoint(x: bounds.midX, y: bounds.minY)
                center = CGPoint(x: bounds.midX, y: bounds.midY)
                endpoint = CGPoint(x: bounds.midX, y: bounds.maxY)

            default:
                break
            }
            
            drawGradientPath(path: path, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint, colors: colors)
            
        case .entrance, .exit: //MARK: ENT & EXIT VIEW
            
            switch version {
            
            case 1:
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endPoint = CGPoint(x: bounds.midX, y: bounds.minY)
                
                drawPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
                context.saveGState()
                
                let eclipseHeight1 = frame.height / 1.75
                let eclipseWidth1 = frame.width / 1.75
                let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
                
                
                if isLocked == true {
                    context.setFillColor(UIColor.lightGray.cgColor)

                } else {
                    context.setFillColor(UIColor.darkGray.cgColor)

                }
                context.addEllipse(in: rect2)
                context.fillEllipse(in: rect2)
                
                let eclipseHeight2 = frame.height / 2
                let eclipseWidth2 = frame.width / 2
                let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.setFillColor(colors[0])
                context.addEllipse(in: rect3)
                context.fillEllipse(in: rect3)
                
                context.restoreGState()
                
                overlapPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])

            case 2:
                
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endPoint = CGPoint(x: bounds.maxX, y: bounds.midY)
                drawPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
                context.saveGState()
                
                let eclipseHeight1 = frame.height / 1.75
                let eclipseWidth1 = frame.width / 1.75
                let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
                if isLocked == true {
                    context.setFillColor(UIColor.lightGray.cgColor)

                } else {
                    context.setFillColor(UIColor.darkGray.cgColor)

                }
                context.addEllipse(in: rect2)
                context.fillEllipse(in: rect2)

                let eclipseHeight2 = frame.height / 2
                let eclipseWidth2 = frame.width / 2
                let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.setFillColor(colors[0])
                context.addEllipse(in: rect3)
                context.fillEllipse(in: rect3)
                
                context.restoreGState()
                
                overlapPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
            case 3:
                
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endPoint = CGPoint(x: bounds.midX, y: bounds.maxY)
                
                drawPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
                context.saveGState()
                
                let eclipseHeight1 = frame.height / 1.75
                let eclipseWidth1 = frame.width / 1.75
                let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
                if isLocked == true {
                    context.setFillColor(UIColor.lightGray.cgColor)

                } else {
                    context.setFillColor(UIColor.darkGray.cgColor)

                }
                context.addEllipse(in: rect2)
                context.fillEllipse(in: rect2)

                let eclipseHeight2 = frame.height / 2
                let eclipseWidth2 = frame.width / 2
                let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.setFillColor(colors[0])
                context.addEllipse(in: rect3)
                context.fillEllipse(in: rect3)
                
                context.restoreGState()
                
                overlapPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
            case 4:
                
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endPoint = CGPoint(x: bounds.minX, y: bounds.midY)
                drawPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
                context.saveGState()
                
                let eclipseHeight1 = frame.height / 1.75
                let eclipseWidth1 = frame.width / 1.75
                let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
                if isLocked == true {
                    context.setFillColor(UIColor.lightGray.cgColor)

                } else {
                    context.setFillColor(UIColor.darkGray.cgColor)

                }
                context.addEllipse(in: rect2)
                context.fillEllipse(in: rect2)

                let eclipseHeight2 = frame.height / 2
                let eclipseWidth2 = frame.width / 2
                let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.setFillColor(colors[0])
                context.addEllipse(in: rect3)
                context.fillEllipse(in: rect3)
                
                context.restoreGState()
                
                overlapPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
            default:
                break
            }
            
        case .wall: //MARK: WALL VIEW
            
            print()
            
        case .ball: //MARK: BALL VIEW
            
            let eclipseHeight1 = frame.height / 4
            let eclipseWidth1 = frame.width / 4
            let rect1 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
            context.addEllipse(in: rect1)
            context.setFillColor(UIColor.black.cgColor)
            context.fillEllipse(in: rect1)
            
            guard let context2 = UIGraphicsGetCurrentContext() else { return }
            let eclipseHeight2 = frame.height / 5
            let eclipseWidth2 = frame.width / 5
            let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
            context2.addEllipse(in: rect2)
            context2.setFillColor(UIColor.black.cgColor)
            context2.fillEllipse(in: rect2)
            
//        case .blank:
//
//            print()
        }
    }
    
    func drawPath(path: UIBezierPath, context: CGContext, pivotPoint: CGPoint, center: CGPoint, endPoint: CGPoint, color: CGColor) {
        
        context.saveGState()
        path.move(to: pivotPoint)
        path.addQuadCurve(to: endPoint, controlPoint: center)
        context.addPath(path.cgPath)
        
        if isLocked == true {
            context.setStrokeColor(UIColor.lightGray.cgColor)
            
//            context.setStrokeColor(ColorTheme.boardBackground.cgColor)

        } else {
            context.setStrokeColor(UIColor.darkGray.cgColor)

//            context.setStrokeColor(ColorTheme.boardBackground.cgColor)
        }
        context.setLineWidth(frame.height / 3)
        context.strokePath()
        path.move(to: pivotPoint)
        path.addQuadCurve(to: endPoint, controlPoint: center)
        context.addPath(path.cgPath)
        context.setStrokeColor(color)
        context.setLineWidth(frame.height / 4)
        context.strokePath()
        context.restoreGState()
    }
    
    func drawGradientPath(path: UIBezierPath, context: CGContext, pivotPoint: CGPoint, center: CGPoint, endPoint: CGPoint, colors: [CGColor]) {
    
        
        context.saveGState()
        path.move(to: pivotPoint)
        path.addQuadCurve(to: endPoint, controlPoint: center)
        context.addPath(path.cgPath)

        if isLocked == true {
            context.setStrokeColor(UIColor.lightGray.cgColor)

        } else {
            context.setStrokeColor(UIColor.darkGray.cgColor)

        }
        context.setLineWidth(frame.height / 3)
        context.strokePath()
        path.move(to: pivotPoint)
        path.addQuadCurve(to: endPoint, controlPoint: center)
        path.lineCapStyle = CGLineCap.round
        context.strokePath()
        let gradient = CGGradient(colorsSpace: nil, colors: colors as CFArray, locations: nil)!
        context.setLineWidth(frame.height / 4)
        context.addPath(path.cgPath)
        context.replacePathWithStrokedPath()
        context.clip()
        
        
        var startPoint = CGPoint()
        var endPoint = CGPoint()

        if shape == .elbow {
            
            if version == 1 {
                startPoint = CGPoint(x: frame.width / 4 * 3, y: 0)
                endPoint = CGPoint(x: 0, y: frame.height / 4 * 3)
            }
            
            if version == 2 {
                startPoint = CGPoint(x: frame.width, y: frame.height / 4 * 3)
                endPoint = CGPoint(x: frame.width / 4, y: 0)
            }
            
            if version == 3 {
                startPoint = CGPoint(x: 0, y: frame.width / 4 * 3)
                endPoint = CGPoint(x: frame.height / 4 * 3, y: 0)
            }
            
            if version == 4 {
                startPoint = CGPoint(x: 0, y: frame.height / 4)
                endPoint = CGPoint(x: frame.width / 4 * 3, y: frame.height)
            }
        }
        
        if shape == .stick {
            
            if version == 1 {
                startPoint = CGPoint(x: frame.minX, y: frame.midY)
                endPoint = CGPoint(x: frame.maxX, y: frame.midY)
            }
            
            if version == 2 {
                startPoint = CGPoint(x: frame.midX, y: frame.minY)
                endPoint = CGPoint(x: frame.midX, y: frame.maxY)
            }
            
            if version == 3 {
                startPoint = CGPoint(x: frame.maxX, y: frame.midY)
                endPoint = CGPoint(x: frame.minX, y: frame.midY)
            }
            
            if version == 4 {
                startPoint = CGPoint(x: frame.midX, y: frame.maxY)
                endPoint = CGPoint(x: frame.midX, y: frame.minY)
            }
        }
        
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])

        context.restoreGState()
    }
    
    func overlapPath(path: UIBezierPath, context: CGContext, pivotPoint: CGPoint, center: CGPoint, endPoint: CGPoint, color: CGColor) {
        path.move(to: pivotPoint)
        path.addQuadCurve(to: endPoint, controlPoint: center)

        context.addPath(path.cgPath)
        context.setStrokeColor(color)
        context.setLineWidth(frame.height / 4)
        context.strokePath()
    }
}


class BallView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)

        context.saveGState()

        context.setShadow(offset: CGSize(width: 0, height: 6), blur: 3.0, color: shadowColor.cgColor)
        context.setFillColor(UIColor.black.cgColor)
//
//        context.fill(frame)

        let eclipseHeight1 = frame.height / 4
        let eclipseWidth1 = frame.width / 4
        let rect1 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
        context.addEllipse(in: rect1)
        context.setFillColor(UIColor.black.cgColor)
        context.fillEllipse(in: rect1)
        
        let eclipseHeight2 = frame.height / 5
        let eclipseWidth2 = frame.width / 5
        let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
        context.addEllipse(in: rect2)
        context.setFillColor(UIColor.white.cgColor)
        context.fillEllipse(in: rect2)
    }
}

enum Shape {
    
    case elbow
    case diagElbow
    case cross
    case stick
    case doubleElbow
    case entrance
    case exit
    case wall
    case pieceMaker
    case ball
    case blank
}
