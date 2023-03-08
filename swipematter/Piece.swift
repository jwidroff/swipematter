//
//  Piece.swift
//  swipematter
//
//  Created by Jeffery Widroff on 1/16/23.
//


import Foundation
import UIKit


class Piece {
    
    var indexes: Indexes?
    var view = ShapeView()
    var color = UIColor()
    var center = CGPoint()

    init(){
        
    }
    
    init(indexes: Indexes?, color: UIColor) {
        
        self.indexes = indexes
        self.color = color
    }
}

class Group {
    
    var pieces = [Piece]()
    var didMove = false
    var colorBackground = UIColor()
    
    init(pieces: [Piece]) {
        self.pieces = pieces
    }
}

enum Direction {
    
    case up
    case down
    case left
    case right
    case none
}


