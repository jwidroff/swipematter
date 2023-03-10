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
//    var level = Level()
    var delegate: ModelDelegate?
//    var levelModel = LevelModel()
    let defaults = UserDefaults.standard
    var colors = PieceColors()
    var piecesMoved = false
    var red = PieceColors().colors["red"]!
    var blue = PieceColors().colors["blue"]!
    var green = PieceColors().colors["green"]!

    var groupCount = 0
    
    init(){
        
        
        
        
    }
    
    func setUpGame() {
        
//        level.number = defaults.integer(forKey: "level")
        setLevel()
        setBoard()
    }
    
    func setUpControlsAndInstructions() {
        
        delegate?.setUpControlViews()
        setupInstructions()
        setupNextView()
    }
    
    func setLevel() {
        
        board.heightSpaces = 9
        board.widthSpaces = 9

        let piece1 = Piece(indexes: Indexes(x: 3, y: 2), color: green)
        board.pieces.append(piece1)
        
        let piece2 = Piece(indexes: Indexes(x: 6, y: 2), color: green)
        board.pieces.append(piece2)
        

//        let piece2 = Piece(indexes: Indexes(x: 7, y: 1), color: green)
//        board.pieces.append(piece2)
//
        let piece3 = Piece(indexes: Indexes(x: 1, y: 0), color: green)
        board.pieces.append(piece3)
//
//
//        let group = Group(pieces: [piece1, piece2, piece3])//, piece4])
//
//
//        let pieceX = Piece(indexes: Indexes(x: 5, y: 1), color: green)
//        board.pieces.append(pieceX)
//
//
//        let piece4 = Piece(indexes: Indexes(x: 5, y: 2), color: green)
//        board.pieces.append(piece4)
//
//
//
//        let piece5 = Piece(indexes: Indexes(x: 5, y: 3), color: green)
//        board.pieces.append(piece5)
//
//        let piece6 = Piece(indexes: Indexes(x: 6, y: 3), color: green)
//        board.pieces.append(piece6)
//
//        let piece7 = Piece(indexes: Indexes(x: 6, y: 4), color: green)
//        board.pieces.append(piece7)
//
//
//        let group2 = Group(pieces: [piece4, piece5, piece6, piece7, pieceX])
//

        let piece8 = Piece(indexes: Indexes(x: 3, y: 8), color: blue)
        board.pieces.append(piece8)
//
//        let piece9 = Piece(indexes: Indexes(x: 3, y: 7), color: blue)
//        board.pieces.append(piece9)
//
//        let piece10 = Piece(indexes: Indexes(x: 2, y: 8), color: blue)
//        board.pieces.append(piece10)
//
//        let piece11 = Piece(indexes: Indexes(x: 2, y: 7), color: blue)
//        board.pieces.append(piece11)
//
//
//        let group3 = Group(pieces: [piece8, piece9, piece10, piece11])
////
//
//        let piece12 = Piece(indexes: Indexes(x: 8, y: 0), color: red)
//        board.pieces.append(piece12)
//
//        let piece13 = Piece(indexes: Indexes(x: 8, y: 1), color: red)
//        board.pieces.append(piece13)
//
//        let piece14 = Piece(indexes: Indexes(x: 8, y: 2), color: red)
//        board.pieces.append(piece14)
//
//        let piece15 = Piece(indexes: Indexes(x: 8, y: 3), color: red)
//        board.pieces.append(piece15)
//
//
//        let group4 = Group(pieces: [piece12, piece13, piece14, piece15])

        
        
        
        
        
        
        
        
//
//        let piece16 = Piece(indexes: Indexes(x: 6, y: 8), color: UIColor.cyan)
//        board.pieces.append(piece16)
//
//        let piece17 = Piece(indexes: Indexes(x: 7, y: 8), color: UIColor.red)
//        board.pieces.append(piece17)
//
//        let piece18 = Piece(indexes: Indexes(x: 8, y: 8), color: UIColor.red)
//        board.pieces.append(piece18)
//
//        let piece19 = Piece(indexes: Indexes(x: 7, y: 7), color: UIColor.red)
//        board.pieces.append(piece19)
//
//
//        let group5 = Group(pieces: [piece16, piece17, piece18, piece19])
//
//
//        let piece20 = Piece(indexes: Indexes(x: 6, y: 6), color: UIColor.red)
//        board.pieces.append(piece20)
//
//        let piece21 = Piece(indexes: Indexes(x: 6, y: 5), color: UIColor.red)
//        board.pieces.append(piece21)
//
//
//        let group6 = Group(pieces: [piece20, piece21])
//
//
//        let piece22 = Piece(indexes: Indexes(x: 1, y: 6), color: UIColor.red)
//        board.pieces.append(piece22)
//
//        let piece23 = Piece(indexes: Indexes(x: 2, y: 6), color: UIColor.red)
//        board.pieces.append(piece23)
//
//
//        let piece24 = Piece(indexes: Indexes(x: 2, y: 7), color: UIColor.red)
//        board.pieces.append(piece24)
//
//        let piece25 = Piece(indexes: Indexes(x: 3, y: 7), color: UIColor.red)
//        board.pieces.append(piece25)
//
//        let piece26 = Piece(indexes: Indexes(x: 3, y: 8), color: UIColor.red)
//        board.pieces.append(piece26)
//
//        let group7 = Group(pieces: [piece22, piece23, piece24, piece25, piece26])
//
//        let piece27 = Piece(indexes: Indexes(x: 4, y: 6), color: UIColor.red)
//        board.pieces.append(piece27)
//
//        let group8 = Group(pieces: [piece27])
//
//
//        let piece28 = Piece(indexes: Indexes(x: 0, y: 0), color: UIColor.red)
//        board.pieces.append(piece28)
//
//        let piece29 = Piece(indexes: Indexes(x: 0, y: 1), color: UIColor.red)
//        board.pieces.append(piece29)
//
//        let group9 = Group(pieces: [piece28 ,piece29])
        
        
        
        
//        board.pieceGroups = [group]//, group2, group3, group4]//, group5, group6, group7, group8, group9]
//
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
    
    private func setPieceIndex(piece: Piece) {

        let index = Indexes(x: Int(arc4random_uniform(UInt32(board.widthSpaces))), y: Int(arc4random_uniform(UInt32(board.heightSpaces))))

        // This is to make sure that the pieces dont start on another piece
        if board.pieces.contains(where: { (pieceX) -> Bool in
            pieceX.indexes == index
        }){
            setPieceIndex(piece: piece)
        } else {

            piece.indexes = index
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
        
//        sortPieces(direction: direction)
                
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
                    piecesMoved = true
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
                                piecesMoved = true
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
                                piecesMoved = true
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
                                piecesMoved = true
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
                                piecesMoved = true
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
    
    func movePieces(direction: Direction, pieces: [Piece]) {
        
        sortPieces(direction: direction)
        
        piecesMoved = true
        
        while piecesMoved == true {
            
            piecesMoved = false
            
            movePiece2(direction: direction, pieces: pieces)
            //Adding the next pieces last in order to make sure that there are no pieces blocking the pieceMaker
            
            for group in board.pieceGroups {
                group.didMove = false
            }
        }
        
        groupPiecesTogether()
        
        addPieceToBoard() //TODO:
    }
    
    func groupPiecesTogether() {
        
        board.pieceGroups = []
        
        var tempBoardPieces = board.pieces //TODO: May want to consider taking pieces out of here after they've been added to a group because of another piece
        
        tempBoardPieces.sort { (piece1, piece2) in
            piece1.indexes!.x! < piece2.indexes!.x!
        }
        
        tempBoardPieces.sort { (piece1, piece2) in
            piece1.indexes!.y! < piece2.indexes!.y!
        }
        
        for piece in tempBoardPieces {
            
            for pieceX in board.pieces {
                
                if piece.indexes!.y! == pieceX.indexes!.y! - 1 && piece.indexes!.x! == pieceX.indexes!.x! && piece.color == pieceX.color{
                    
                    if piece.groupNumber == nil && pieceX.groupNumber == nil {
                        
//                        print("AA")
                        piece.groupNumber = groupCount + 1
                        pieceX.groupNumber = groupCount + 1
                        groupCount += 1
                        
                    } else if pieceX.groupNumber != nil && piece.groupNumber == nil {
                        
//                        print("BB")
                        piece.groupNumber = pieceX.groupNumber
                        
                    } else if pieceX.groupNumber == nil && piece.groupNumber != nil {
                        
//                        print("CC")
                        pieceX.groupNumber = piece.groupNumber
                    }
                }
                
                if piece.indexes!.y! == pieceX.indexes!.y! && piece.indexes!.x! == pieceX.indexes!.x! - 1 && piece.color == pieceX.color{
                    
                    if piece.groupNumber == nil && pieceX.groupNumber == nil {
                        
//                        print("AA")
                        piece.groupNumber = groupCount + 1
                        pieceX.groupNumber = groupCount + 1
                        groupCount += 1
                        
                    } else if pieceX.groupNumber != nil && piece.groupNumber == nil {
                        
//                        print("BB")
                        piece.groupNumber = pieceX.groupNumber
                        
                    } else if pieceX.groupNumber == nil && piece.groupNumber != nil {
                        
//                        print("CC")
                        pieceX.groupNumber = piece.groupNumber
                    }
                }
            }
        }
        
        addBoardGroups()
    }
    
    func addBoardGroups() {
        
        for number in 0..<groupCount {
            
            var groupPieces = [Piece]()
            
            for piece in board.pieces {
                
                if let groupNum = piece.groupNumber {
                    
                    if groupNum == number + 1 {
                        
                        groupPieces.append(piece)
                    }
                }
            }
            let group = Group(pieces: groupPieces)
            board.pieceGroups.append(group)
        }
    }
    
    
//    func groupPiecesTogether() {
//
//        for pieceX in board.pieces {
//
//            if pieceX.groupNumber == nil {
//
//                print("PIECE X INDEX = \(pieceX.indexes!)")
//
//                for pieceY in board.pieces {
//
//                    if pieceX.groupNumber == nil {
//
//                        if let indexX = pieceX.indexes {
//
//                            if let indexY = pieceY.indexes {
//
//                                if indexX != indexY {
//
//                                    print("PIECE Y INDEX = \(pieceY.indexes!)")
//
//                                    let xX = indexX.x!
//                                    let xY = indexX.y!
//                                    let yX = indexY.x!
//                                    let yY = indexY.y!
//
//                                    if yY == xY && yX == xX - 1 && pieceY.color == pieceX.color {
//
//                                        print("HERE")
//
//                                        if pieceX.groupNumber == nil && pieceY.groupNumber == nil {
//
//                                            print("AA")
//
//                                            pieceX.groupNumber = groupCount + 1
//                                            pieceY.groupNumber = groupCount + 1
//                                            groupCount += 1
//
//
//                                        } else if pieceX.groupNumber != nil && pieceY.groupNumber == nil {
//
//                                            print("BB")
//
//
//                                            pieceY.groupNumber = pieceX.groupNumber
//
//
//                                        } else if pieceX.groupNumber == nil && pieceY.groupNumber != nil {
//
//                                            print("CC")
//
//                                            pieceX.groupNumber = pieceY.groupNumber
//                                        }
//                                    }
//
//                                    if yY == xY && yX == xX + 1 && pieceY.color == pieceX.color {
//
//                                        print("HERE")
//
//                                        if pieceX.groupNumber == nil && pieceY.groupNumber == nil {
//
//                                            print("AA")
//
//                                            pieceX.groupNumber = groupCount + 1
//                                            pieceY.groupNumber = groupCount + 1
//                                            groupCount += 1
//
//                                        } else if pieceX.groupNumber != nil && pieceY.groupNumber == nil {
//
//                                            print("BB")
//
//
//                                            pieceY.groupNumber = pieceX.groupNumber
//
//                                        } else if pieceX.groupNumber == nil && pieceY.groupNumber != nil {
//
//                                            print("CC")
//
//                                            pieceX.groupNumber = pieceY.groupNumber
//                                        }
//                                    }
//
//                                    if yY == xY - 1 && yX == xX && pieceY.color == pieceX.color {
//
//                                        print("HERE")
//
//                                        if pieceX.groupNumber == nil && pieceY.groupNumber == nil {
//
//                                            print("AA")
//
//                                            pieceX.groupNumber = groupCount + 1
//                                            pieceY.groupNumber = groupCount + 1
//                                            groupCount += 1
//
//                                        } else if pieceX.groupNumber != nil && pieceY.groupNumber == nil {
//
//                                            print("BB")
//
//
//                                            pieceY.groupNumber = pieceX.groupNumber
//
//                                        } else if pieceX.groupNumber == nil && pieceY.groupNumber != nil {
//
//                                            print("CC")
//
//                                            pieceX.groupNumber = pieceY.groupNumber
//                                        }
//                                    }
//
//                                    if yY == xY + 1 && yX == xX && pieceY.color == pieceX.color {
//
//                                        print("HERE")
//
//                                        if pieceX.groupNumber == nil && pieceY.groupNumber == nil {
//
//                                            print("AA")
//
//                                            pieceX.groupNumber = groupCount + 1
//                                            pieceY.groupNumber = groupCount + 1
//                                            groupCount += 1
//
//                                        } else if pieceX.groupNumber != nil && pieceY.groupNumber == nil {
//
//                                            print("BB")
//
//
//                                            pieceY.groupNumber = pieceX.groupNumber
//
//                                        } else if pieceX.groupNumber == nil && pieceY.groupNumber != nil {
//
//                                            print("CC")
//
//                                            pieceX.groupNumber = pieceY.groupNumber
//                                        }
//                                    }
//
//                                }
//
//
//
//
//
//                            }
//                        }
//
//
//                    }
//
//
//
//
//                }
//            }
//
//
//        }
//
//
//        createGroups()
//
//        print(board.pieceGroups.count)
//    }
    
//    func createGroups() {
//
//
//
//        for number in 0..<groupCount {
//
//            var tempGroup = [Piece]()
//
//            for piece in board.pieces {
//
//                if piece.groupNumber == number {
//
//                    tempGroup.append(piece)
//
//                }
//
//
//            }
//
//            board.pieceGroups.append(Group(pieces: tempGroup))
//
//        }
//
//
//
//
//    }
    
    
//    func check4NewGroups(direction: Direction) {
//
//        board.pieceGroups = []
//
//
//        for piece in board.pieces.sorted(by: { (piece1, piece2) in
//            piece1.indexes!.x! < piece2.indexes!.x! && piece1.indexes!.y! < piece2.indexes!.y!
//        }) {
//
//
////            calcNewGroup(piece: piece)
//            createNewGroups(piece: piece)
//
//        }
//
//        print(board.pieceGroups.map({$0.pieces}))
//
//    }
//
//
//    var tempGroups = [[Piece]]()
//
//    func createNewGroups(piece: Piece) {
//
//
//        for group in tempGroups {
//
//            for pieceX in group {
//
////                if pieceX.indexes ==
//
//            }
//
//
//        }
//
//
//
//
//
//
//
//        //Check if piece is already part of a group or not
////        for group in board.pieceGroups {
//
////            if group.pieces.contains(where: { (pieceX) in
////                piece.indexes == pieceX.indexes
////            }) {
//
//                //Since its alreadt part of a group, exit the func
////                break
//
//
//
////            } else {
//
//                //Since its not part of a group, see if its touching a piece
//                for pieceX in board.pieces {
//
//                    if piece.indexes!.y == pieceX.indexes!.y && piece.indexes!.x == pieceX.indexes!.x! - 1 && piece.color == pieceX.color {
//
////                        if !group.pieces.contains(where: { (pieceX) in
////                            piece.indexes == pieceX.indexes
////                        }) {
////                            let group = Group(pieces: [piece, pieceX])
////                            board.pieceGroups.append(group)
////                            break
////                        }
//                    }
//
//                    if piece.indexes!.y == pieceX.indexes!.y && piece.indexes!.x == pieceX.indexes!.x! + 1 && piece.color == pieceX.color {
//
////                        if !group.pieces.contains(where: { (pieceX) in
////                            piece.indexes == pieceX.indexes
////                        }) {
////                            let group = Group(pieces: [piece, pieceX])
////                            board.pieceGroups.append(group)
////                            break
////                        }
//                    }
//
//                    if piece.indexes!.y == pieceX.indexes!.y! + 1 && piece.indexes!.x == pieceX.indexes!.x && piece.color == pieceX.color {
//
////                        if !group.pieces.contains(where: { (pieceX) in
////                            piece.indexes == pieceX.indexes
////                        }) {
////                            let group = Group(pieces: [piece, pieceX])
////                            board.pieceGroups.append(group)
////                            break
////                        }
//                    }
//
//                    if piece.indexes!.y == pieceX.indexes!.y! - 1 && piece.indexes!.x == pieceX.indexes!.x && piece.color == pieceX.color {
//
////                        if !group.pieces.contains(where: { (pieceX) in
////                            piece.indexes == pieceX.indexes
////                        }) {
////                            let group = Group(pieces: [piece, pieceX])
////                            board.pieceGroups.append(group)
////                            break
////                        }
//                    }
//
//
//                }
//
//
//
////            }
//
//
//            //Check to see if piece2 is also part of another group
//
//            //If it is, add the entire group (piece2's group) to piece's group
//
//            //If its not, just add piece2 to piece's group
//
////        }
//
//
//    }
//
//
//
//    func calcNewGroup(piece: Piece) {
//
//        var piece1addToGroup = true
//        var piece2addToGroup = true
//
//        for pieceX in board.pieces {
//
//            //If they are next to eachother
//            if piece.indexes!.y == pieceX.indexes!.y && piece.indexes!.x == pieceX.indexes!.x! + 1 {
//
//                //And they have the same color
//                if piece.color == pieceX.color {
//
//                    //First run through the grouped pieces
//                    for group in board.pieceGroups {
//
//                        //If the original piece in question is already part of a goup, flag it
//                        if group.pieces.contains(where: { (pieceXX) in
//                            pieceXX.indexes == piece.indexes
//                        }) {
//
//                            piece1addToGroup = false
//                        }
//
//                        if group.pieces.contains(where: { (pieceXX) in
//                            pieceXX.indexes == pieceX.indexes
//                        }) {
//
//                            piece2addToGroup = false
//                        }
//
//
//                    }
//                }
//            }
//
//            if piece1addToGroup == true {
//
//                for group in board.pieceGroups {
//
//                }
//
//
//            } else {
//
//                piece1addToGroup = true
//            }
//
//            if piece2addToGroup == true {
//
//
//
//            } else {
//
//                piece2addToGroup = true
//            }
//
//
//        }
//    }
    
    
    
    func addPieceToBoard() {
        
        
        
        
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
 
    func resetGame() {
                
        for piece in board.pieces {
            delegate?.clearPiecesAnimation(view: piece.view)
        }
        
        board.pieces.removeAll()
        
    }
}
