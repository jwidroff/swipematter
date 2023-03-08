//
//  Board.swift
//  swipematter
//
//  Created by Jeffery Widroff on 1/16/23.
//


import Foundation
import UIKit


class Board {
    
    var grid = [Indexes: CGPoint]()
    var view = UIView()
    var pieces = [Piece]()
    var heightSpaces = Int()
    var widthSpaces = Int()
    var colorTheme = ColorTheme()
    var instructions: Instructions?
    var pieceGroups = [Group]()
}

class BoardView : UIView {
    
    var context = UIGraphicsGetCurrentContext()
    var xArray = [CGFloat]()
    var yArray = [CGFloat]()
    var colorTheme = ColorTheme()

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, xArray: [CGFloat], yArray: [CGFloat], colorTheme: ColorTheme) {
        
        super.init(frame: frame)
        self.colorTheme = colorTheme
        self.xArray = xArray.sorted(by: { (x1, x2) -> Bool in
            x1 < x2
        })
        self.yArray = yArray.sorted(by: { (y1, y2) -> Bool in
            y1 < y2
        })
        
        addBoardTiles()
    }
    
    private func addGridLines(context: CGContext) {
        
        let point1 = CGPoint(x: xArray[0], y: yArray[0])
        let point2 = CGPoint(x: xArray[1], y: yArray[1])
        let halfX = (point1.x - point2.x) / 2
        let halfY = (point1.y - point2.y) / 2
        
        context.setLineWidth(2.0)
        context.beginPath()
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: 0, y: frame.maxY))
        context.strokePath()
        
        context.beginPath()
        context.move(to: CGPoint(x: frame.maxX, y: 0))
        context.addLine(to: CGPoint(x: 0, y: 0))
        context.strokePath()
        
        for x in xArray {
                        
            context.beginPath()
            context.move(to: CGPoint(x: x + halfX, y: yArray.first! + halfY))
            context.addLine(to: CGPoint(x: x + halfX, y: yArray.last! - halfY))
            context.strokePath()
        }
        
        context.beginPath()
        context.move(to: CGPoint(x: frame.width, y: 0))
        context.addLine(to: CGPoint(x: frame.width, y: frame.height))
        context.strokePath()
        
        for y in yArray {
            
            context.beginPath()
            context.move(to: CGPoint(x: xArray.first! + halfX, y: y + halfY))
            context.addLine(to: CGPoint(x: xArray.last! - halfX, y: y + halfY))
            context.strokePath()
        }
        
        context.beginPath()
        context.move(to: CGPoint(x: 0, y: frame.height))
        context.addLine(to: CGPoint(x: frame.width, y: frame.height))
        context.strokePath()

        setNeedsDisplay()
        self.context = context
    }
    
    private func addBoardTiles() {
        let widthAndHeight = (xArray[1] - xArray [0])
        for x in xArray {
            for y in yArray {
                let rect = CGRect(x: x, y: y, width: widthAndHeight, height: widthAndHeight)
                let viewX = UIView(frame: rect)
                viewX.center = CGPoint(x: x, y: y)
                addSubview(viewX)
                makeSoft(view: viewX)
            }
        }
    }
    
    private func makeSoft(view: UIView) {
        
        view.backgroundColor = ColorTheme.boardBackground
        let shadowRadius: CGFloat = 1
        let darkShadow = CALayer()

        darkShadow.frame = view.layer.bounds
        darkShadow.backgroundColor = ColorTheme.boardBackground.cgColor
        darkShadow.shadowColor = UIColor.black.cgColor
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 1
        view.layer.insertSublayer(darkShadow, at: 1)
    }
}
