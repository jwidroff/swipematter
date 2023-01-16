//
//  NextView.swift
//  swipematter
//
//  Created by Jeffery Widroff on 1/16/23.
//

import Foundation
import UIKit



class NextView: UIView {
    
    
    var xArray = [CGFloat]()
    var yArray = [CGFloat]()
    var grid = GridPoints()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        print("FRAME \(frame)")
        
        
        backgroundColor = UIColor.systemPink
        
        
        
        
        grid.dictionary = GridPoints(frame: self.frame, height: 4, width: 4).getGrid()


        print("GRID DICTIONARY \(grid.dictionary)")


        addGrid()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    private func addGrid() {
        
        for point in grid.dictionary.values {
                        
            if !xArray.contains(point.x) {
                
                xArray.append(point.x)
            }
            
            if !yArray.contains(point.y) {
                
                yArray.append(point.y)
            }
        }
        
        addBoardTiles()
        
        
    }
    
    private func addBoardTiles() {
        let widthAndHeight = (xArray[1] - xArray [0])
        for x in xArray {
            for y in yArray {
                
//                if !holeLocations.contains(where: { (indexesX) -> Bool in
//                    self.xArray[indexesX.x!] == x && self.yArray[indexesX.y!] == y
//                }) {
                    
                    let rect = CGRect(x: x, y: y, width: widthAndHeight, height: widthAndHeight)
                    let viewX = UIView(frame: rect)
                    viewX.center = CGPoint(x: x, y: y)
                    addSubview(viewX)
                    makeSoft(view: viewX)
//                }
            }
        }
    }
    
    private func makeSoft(view: UIView) {
        
        self.backgroundColor = ColorTheme.boardBackground
        let shadowRadius: CGFloat = 1
        let darkShadow = CALayer()
        let lightShadow = CALayer()
        
        lightShadow.frame = layer.bounds
        lightShadow.backgroundColor = ColorTheme.boardBackground.cgColor
        lightShadow.shadowColor = UIColor.white.cgColor
        lightShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
        lightShadow.shadowOpacity = 1
//        lightShadow.cornerRadius = 5
        layer.insertSublayer(lightShadow, at: 0)

        darkShadow.frame = layer.bounds
        darkShadow.backgroundColor = ColorTheme.boardBackground.cgColor
        darkShadow.shadowColor = UIColor.black.cgColor
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 1
//        darkShadow.cornerRadius = 5
        layer.insertSublayer(darkShadow, at: 1)
    }
    

}



class NextPiece {
    
    var pieces = [Piece]()
    
    init(pieces: [Piece] = [Piece]()) {
        self.pieces = pieces
    }
    
    
    
    
}
