//
//  Instructions.swift
//  swipematter
//
//  Created by Jeffery Widroff on 1/16/23.
//

import UIKit

class InstructionsView: UIView {

    
    var backButton = UIButton()
    var nextButton = UIButton()
    var gameboard = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    
    init(frame: CGRect, levelName: String) {
        

        super.init(frame: frame)
        
        

    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


class Instructions {
    
    var view = InstructionsView()
//    var pieceView = ShapeView()
//    var image = UIImageView()
//    var textView = UITextView()
    var text = String()

    var name = String()
    var goal = [Actions]()
    
    init(text: String, levelName: String, goal: [Actions]) {
        
        
        
        view.backgroundColor = .yellow
        
//        textView.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
//
//        textView.backgroundColor = .green
        
        self.name = levelName
        self.text = text
        
//        let pieceViewFrame = CGRect(x: 25, y: 25, width: 50, height: 50)
        
//        pieceView = ShapeView(frame: pieceViewFrame, piece: piece)
        
        
        
        
//        view.addSubview(textView)
        
//        view.addSubview(pieceView)
        
    }
    
}

enum Actions {
    
    case up
    case down
    case left
    case right
    
    
}
