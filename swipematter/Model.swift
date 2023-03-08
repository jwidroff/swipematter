//
//  Model.swift
//  swipematter
//
//  Created by Jeffery Widroff on 1/16/23.
//

import Foundation
import UIKit

//TODO: Consider making the double elbow have more options than spliting apart - make it that one line goes straight and the other curves right or left

//TODO: Make it that the pieceMakers can have multiple openings

//TODO: Make cracks for ice

//TODO: Consider making walls that have the power to move and freeze in place

//TODO: May want to consider saving pieces from a level and using all those pieces for the bonus level

//TODO: Consider making pieces stick together

//TODO: Fix up menuView


//TODO: Fix - Sometimes there are multiple popups trying to come up at the same time since there is multiple reasons why the user has lost (Ex losing an entrance piece as a last moveable piece)


//TODO: Make it that when a user taps on a not switching piece, it animates it trying to switch but doesnt work

//TODO: Need to also make it that popup for no more moves only comes about after an actual piece moves (right now, if theres a piecemaker and you can swipe down to move it but if you swipe up and no other pieces move, the popup comes on even though you can technically swipe down)

//TODO: Make it that when you press on the level, you get the option to switch levels (instead of the menu button)

//TODO: Countdown to zero doesnt show a popup when its game over

//TODO: Fix popups

//TODO: Need to make it that you cant tap on a piece once the ball is moving

//TODO: Use threading for moving pieces and moving ball

//TODO: implement other types of ads

//TODO: Shorten the time for ball moving

//TODO: Shorted loop time

//TODO: make pieces move like they used to when there are no more moves instead of making user hit restart

//TODO: Change ice image

//TODO: Consider making it that when you do a loop, you get an extra move

//TODO: Make rewarded ads

//TODO: increase loop speed

//TODO: Haptics

//TODO: Sounds

//TODO: Colors

//TODO: Make instructions for certain levels (or previews)

//TODO: Perhaps the blank pieces should be square

//TODO: Need to make it that pieceMakers can spit out entrances/exits

//TODO: Consider getting rid of the balls altogether and just fill the space with white

//TODO: Sometimes when there is an entrance in (0,0) the ball background isnt clear and messes with the UI. Look into this.

//TODO: Make it that when theres no moves left, the game is over

//TODO: Consider making the pieces that loop into locked pieces instead of getting rid of the pieces

//TODO: Make it that when a path ends in the entrance that it started with, it should move

//TODO: Grouped Pieces - Need logic for ice and holes

//TODO: Grouped pieces - when they separate from a group because the ball went through it, the piece in the model.groupedPieces that it belongs to, needs to be removed

//TODO: NEED TO make the grid show their indexes for testing so that its easier to setup and debug

//TODO: Make different level challenges like cover all parts of a certain area with the given grouped pieces

//TODO: Make different background colors for grouped pieces

//TODO: Make game just like tetris that the object of the game is to make horizontal or vertical lines like you do in regular tetris except the pieces just appear in an open area (like in 2048) and the pieces move per swipe like they do in pipequest

//MARK: 7x12 seems to be the ideal board setup for most sizes





protocol ModelDelegate {
    func setUpGameViews(board: Board)
    func setUpControlViews()
    func setUpPiecesView()
    func movePieceView(piece: Piece)
//    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String)
    func addPieceView(piece: Piece)
    func removeView(view: UIView)
    func runPopUpView(title: String, message: String)
    func clearPiecesAnimation(view: UIView)
//    func crashBallViewIntoCross(piece: Piece, ball: Ball)
    func removeViews()
    func addSwipeGestureRecognizer(view: UIView)
//    func switchCrissCross(piece: Piece)
    func enlargePiece(view: UIView)
//    func disableSwipes()
    func setupInstructionsView(instructions: Instructions)
    func setUpNextView(nextPiece: Piece)
}

class Model {
    
    var board = Board()
    var level = Level()
    var delegate: ModelDelegate?
    var levelModel = LevelModel()
    let defaults = UserDefaults.standard
    
    init(){
        
    }
    
    func setUpGame() {
        
        level.number = defaults.integer(forKey: "level")
        getLevel()
        setBoard()
    }
    
    func setUpControlsAndInstructions() {
        
        delegate?.setUpControlViews()
        setupInstructions()
        setupNextView()
    }
    
    func getLevel() {
        
        levelModel = LevelModel()
        self.board = levelModel.returnBoard(levelNumber: level.number)
        setUpLevelDefaults()
    }
    
    func setUpLevelDefaults() {
        setUpRandomPieces()
//        setupNextPieces()
//        setupBalls()
    }
    
    func setBoard() {
        
        delegate?.setUpGameViews(board: self.board)
        delegate?.setUpPiecesView()
    }
    
    func setupNextView() {
        
    //MARK: NEED TO WORK ON THIS
        
        let piece1 = Piece(indexes: Indexes(x: 1, y: 2), color: UIColor.red)
        delegate?.setUpNextView(nextPiece: piece1)
    }
    
    func setupInstructions() {
        
        if board.instructions == nil {
            return
        } else {
            delegate?.setupInstructionsView(instructions: board.instructions!)
        }
    }
    
    func setUpRandomPieces() {
        
        for _ in 0..<board.amountOfRandomPieces {
            
            let piece = Piece()
            setPieceIndex(piece: piece)
            board.pieces.append(piece)
        }
    }
    
    private func setPieceIndex(piece: Piece) {

        let index = Indexes(x: Int(arc4random_uniform(UInt32(board.widthSpaces))), y: Int(arc4random_uniform(UInt32(board.heightSpaces))))

        // This is to make sure that the pieces dont start on another piece
        if board.pieces.contains(where: { (pieceX) -> Bool in
            pieceX.indexes == index
        }){
            setPieceIndex(piece: piece)
        } else {
            // This is to make sure that the pieces dont start on a hole
            if board.holeLocations.contains(where: { (holeIndex) -> Bool in
                holeIndex == index
            }) {
                setPieceIndex(piece: piece)
            } else {
                piece.indexes = index
            }
        }
    }
    
    func isNextSpaceBlocked(direction: Direction, indexes: Indexes, pieces: [Piece]) -> Bool {
        
        var bool = true

        switch direction {
        case .up:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
            }){
                bool = false
            }
            
        case .down:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
            }){
                bool = false
            }
            
        case .left:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
            }){
                bool = false
            }
            
        case .right:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
            }){
                bool = false
            }
        default:
            break
        }
        return bool
    }
    
    func getPieceInfo(index: Indexes, pieces: [Piece]) -> Piece? {
        
        var piece = Piece()
        
        for pieceX in pieces {
            
            if pieceX.indexes == index {
                
                piece = pieceX
            }
        }
        return piece
    }
    
    func checkForIce(piece: Piece) -> Bool {

        var bool = false

        if board.iceLocations.contains(where: { (index) -> Bool in
            index == piece.indexes
        }) {
            bool = true
        }
        return bool
    }

    func movePiecesHelper(piece: Piece, direction: Direction) {
        
        if let indexes = piece.indexes {
            
            switch direction {
                
            case .up:
                
                let spaceIsntBlocked = isNextSpaceBlocked(direction: .up, indexes: indexes, pieces: board.pieces)
                
                if spaceIsntBlocked {
                    
                    if indexes.y != 0 {
                        piece.indexes?.y = (indexes.y)! - 1
                    }
                } else {
                    return
                }
                
            case .down:
                
                let spaceIsntBlocked = isNextSpaceBlocked(direction: .down, indexes: indexes, pieces: board.pieces)
                
                if spaceIsntBlocked {
                    
                    if indexes.y != board.heightSpaces - 1 {
                        piece.indexes?.y = indexes.y! + 1
                    }
                } else {
                    return
                }
                
            case .left:
                
                let spaceIsntBlocked = isNextSpaceBlocked(direction: .left, indexes: indexes, pieces: board.pieces)
                
                if spaceIsntBlocked {
                    
                    if indexes.x != 0 {
                        piece.indexes?.x = indexes.x! - 1
                    }
                } else {
                    return
                }
                
            case .right:
                
                let spaceIsntBlocked = isNextSpaceBlocked(direction: .right, indexes: indexes, pieces: board.pieces)
                
                if spaceIsntBlocked {
                    
                    if indexes.x != board.widthSpaces - 1 {
                        piece.indexes?.x = indexes.x! + 1
                    }
                    
                } else {
                    return
                }
                
            default:
                break
            }
        }
    }
    
    func pieceIsPartOfAGroup(piece: Piece, groups: [Group]) -> Bool {
        
        var bool = false
        
        for group in groups {
            if group.pieces.contains(where: { pieceX -> Bool in
                piece.indexes == pieceX.indexes
            }) {
                bool = true
            }
        }
        return bool
    }
    
    func movePiece2(direction: Direction, pieces: [Piece]) {
        
        var piecesToRetry = [Piece]()
        var pieceDidMove = false
        
        sortPieces(direction: direction)
                
        for piece in pieces {
            
            if pieceIsPartOfAGroup(piece: piece, groups: board.pieceGroups) == false {
                                
                let startIndexes = piece.indexes
                
                movePiecesHelper(piece: piece, direction: direction)
                
                self.delegate?.movePieceView(piece: piece)
                                
                let endIndexes = piece.indexes
                
                if startIndexes == endIndexes {
                    
                    piecesToRetry.append(piece)
                } else {
                    pieceDidMove = true
                }
                
            }
        }
        
        for group in board.pieceGroups {
            
            var groupDidMove = group.didMove
            
            if group.didMove == false {
                
                var groupCanMove = true
                
                var piecesIndexes = [Indexes]()
                
                switch direction {
                    
                case .up:
                    
                    for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
                        (piece1.indexes?.y!)! < (piece2.indexes?.y!)!
                    }) {
                        
                        if board.pieces.contains(where: { pieceX -> Bool in
                            pieceX.indexes == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! - 1)
                        }) {
                            if !group.pieces.contains(where: { pieceXX -> Bool in
                                pieceXX.indexes == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! - 1)
                            }) {
                                groupCanMove = false
                            }
                            
                        } else {
                            
                            if piecesIndexes.contains(where: { indexX -> Bool in
                                indexX == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! - 1)
                            }) {
                                groupCanMove = false
                            } else {
                                
                                if piece.indexes?.y! != 0 {
                                    piecesIndexes.append(Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! - 1))
                                } else {
                                    groupCanMove = false
                                }
                            }
                        }
                    }
                    
                    if groupCanMove == true {

                        for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
                            (piece1.indexes?.y!)! < (piece2.indexes?.y!)!
                        }) {
                            
                            let beforeIndexes = piece.indexes

                            movePiecesHelper(piece: piece, direction: direction)
                            self.delegate?.movePieceView(piece: piece)

                            let afterIndexes = piece.indexes
                            
                            if beforeIndexes != afterIndexes {
                                groupDidMove = true
                                pieceDidMove = true
                            }
                        }
                    }
                    
                case .down:
                    
                    for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
                        (piece1.indexes?.y!)! > (piece2.indexes?.y!)!
                    }) {
                                                
                        if board.pieces.contains(where: { pieceX -> Bool in
                            pieceX.indexes == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! + 1)
                        }) {
                            if !group.pieces.contains(where: { pieceXX -> Bool in
                                pieceXX.indexes == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! + 1)
                            }) {
                                groupCanMove = false
                            }
                            
                        } else {
                            
                            if piecesIndexes.contains(where: { indexX -> Bool in
                                indexX == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! + 1)
                            }) {
                                groupCanMove = false
                            } else {
                                
                                if piece.indexes?.y! != board.heightSpaces - 1 {
                                    piecesIndexes.append(Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! + 1))
                                } else {
                                    groupCanMove = false
                                }
                            }
                        }
                    }
                    
                    if groupCanMove == true {

                        for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
                            (piece1.indexes?.y!)! > (piece2.indexes?.y!)!
                        }) {

                            let beforeIndexes = piece.indexes

                            movePiecesHelper(piece: piece, direction: direction)
                            self.delegate?.movePieceView(piece: piece)

                            let afterIndexes = piece.indexes
                            
                            if beforeIndexes != afterIndexes {
                                groupDidMove = true
                                pieceDidMove = true
                            }
                        }
                    }
                    
                case .left:
                    
                    for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
                        (piece1.indexes?.x!)! < (piece2.indexes?.x!)!
                    }) {
                        
                        if board.pieces.contains(where: { pieceX -> Bool in
                            pieceX.indexes == Indexes(x: (piece.indexes?.x!)! - 1, y: piece.indexes?.y)
                        }) {
                            if !group.pieces.contains(where: { pieceXX -> Bool in
                                pieceXX.indexes == Indexes(x: (piece.indexes?.x!)! - 1, y: piece.indexes?.y)
                            }) {
                                groupCanMove = false
                            }
                            
                        } else {
                            
                            if piecesIndexes.contains(where: { indexX -> Bool in
                                indexX == Indexes(x: (piece.indexes?.x!)! - 1, y: piece.indexes?.y)
                            }) {
                                
                                groupCanMove = false
                                
                            } else {
                                
                                if piece.indexes?.x! != 0 {
                                    piecesIndexes.append(Indexes(x: (piece.indexes?.x!)! - 1, y: piece.indexes?.y))
                                } else {
                                    groupCanMove = false
                                }
                            }
                        }
                    }
                    
                    if groupCanMove == true {

                        for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
                            (piece1.indexes?.x!)! < (piece2.indexes?.x!)!
                        }) {

                            let beforeIndexes = piece.indexes

                            movePiecesHelper(piece: piece, direction: direction)
                            self.delegate?.movePieceView(piece: piece)

                            let afterIndexes = piece.indexes
                            
                            if beforeIndexes != afterIndexes {
                                groupDidMove = true
                                pieceDidMove = true
                            }
                        }
                    }
                    
                case .right:
                    
                    for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
                        (piece1.indexes?.x!)! > (piece2.indexes?.x!)!
                    }) {
                        
                        if board.pieces.contains(where: { pieceX -> Bool in
                            pieceX.indexes == Indexes(x: (piece.indexes?.x!)! + 1, y: piece.indexes?.y)
                        }) {
                            if !group.pieces.contains(where: { pieceXX -> Bool in
                                pieceXX.indexes == Indexes(x: (piece.indexes?.x!)! + 1, y: piece.indexes?.y)
                            }) {
                                groupCanMove = false
                            }
                            
                        } else {
                            
                            if piecesIndexes.contains(where: { indexX -> Bool in
                                indexX == Indexes(x: (piece.indexes?.x!)! + 1, y: piece.indexes?.y)
                            }) {
                                
                                groupCanMove = false
                            } else {
                                
                                if piece.indexes?.x! != board.widthSpaces - 1 {
                                    piecesIndexes.append(Indexes(x: (piece.indexes?.x!)! + 1, y: piece.indexes?.y))
                                } else {
                                    groupCanMove = false
                                }
                            }
                        }
                    }
                    
                    if groupCanMove == true {

                        for piece in group.pieces.sorted(by: { (piece1, piece2) -> Bool in
                            (piece1.indexes?.x!)! > (piece2.indexes?.x!)!
                        }) {

                            let beforeIndexes = piece.indexes

                            movePiecesHelper(piece: piece, direction: direction)
                            self.delegate?.movePieceView(piece: piece)

                            let afterIndexes = piece.indexes
                            
                            if beforeIndexes != afterIndexes {
                                groupDidMove = true
                                pieceDidMove = true
                            }
                        }
                    }
                    
                default:
                    
                    break
                }
            }
            group.didMove = groupDidMove
        }

        if pieceDidMove {
            
            movePiece2(direction: direction, pieces: piecesToRetry)
        }
    }
    
    func movePiece(direction: Direction, pieces: [Piece]) {
        
        movePiece2(direction: direction, pieces: pieces)
        //Adding the next pieces last in order to make sure that there are no pieces blocking the pieceMaker
        
        for group in board.pieceGroups {
            group.didMove = false
        }
    }
    
    func sortPieces(direction: Direction) {
        
        switch direction {
            
        case .up:
            
            board.pieces.sort { (piece1, piece2) -> Bool in
                
                (piece1.indexes?.y!)! < (piece2.indexes?.y!)!
            }

        case .down:
            
            board.pieces.sort { (piece1, piece2) -> Bool in
                (piece1.indexes?.y!)! > (piece2.indexes?.y!)!
            }

        case .left:
            
            board.pieces.sort { (piece1, piece2) -> Bool in
                (piece1.indexes?.x!)! < (piece2.indexes?.x!)!
            }

        case .right:
            
            board.pieces.sort { (piece1, piece2) -> Bool in
                (piece1.indexes?.x!)! > (piece2.indexes?.x!)!
            }

        default:
            break
        }
    }
 
    func updateUserDefaults() {
        
        defaults.set(level.number, forKey: "level")
        if self.level.number > self.defaults.integer(forKey: "highestLevel") {
            
            self.defaults.set(self.level.number, forKey: "highestLevel")
        }
    }
    
    func resetGame() {
        
        updateUserDefaults()
        
        for piece in board.pieces {
            delegate?.clearPiecesAnimation(view: piece.view)
        }
        
        board.pieces.removeAll()
        
        for ball in board.balls {
            ball.piecesPassed = [Piece]()
            delegate?.clearPiecesAnimation(view: ball.view)
        }
        
        for ball in board.balls {
            
            delegate?.removeView(view: ball.view)
        }
                
        board.balls.removeAll()
    }
}
