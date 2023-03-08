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
    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String)
    func addPieceView(piece: Piece)
//    func resetPieceMakerView(piece: Piece)
    func removeView(view: UIView)
    func runPopUpView(title: String, message: String)
    func clearPiecesAnimation(view: UIView)
    func replacePieceView(piece: Piece)
//    func changeViewColor(piece: Piece, ball: Ball)
    func changeAnimationSpeed(slowerOrFaster: String)
    func crashBallViewIntoCross(piece: Piece, ball: Ball)
    func removeViews()
    func updateLevelInfo(name: String, moves: String)
    func updateMovesLeftLabel(moves: String)
    func addSwipeGestureRecognizer(view: UIView)
//    func removeHole(piece: Piece)
//    func rotateView(piece: Piece, rotationDegrees: CGFloat)
    func switchCrissCross(piece: Piece)
    func enlargePiece(view: UIView)
    func disableSwipes()
    func setupInstructionsView(instructions: Instructions)
    func setUpNextView(nextPiece: Piece)
}

class Model {
    
    var board = Board()
    var level = Level()
    var delegate: ModelDelegate?
    var gameOver = false
    var possibleLoopPieces = [Piece]()
    var loadingMode = true
    var levelModel = LevelModel()
    let defaults = UserDefaults.standard
    var moveStarted = false
    var infiniteMoves = Bool()
    var gameIsLoading = true
    var nextPiece = NextPiece()
    
    init(){
        
    }
    
    func setUpGame() {
        level.number = defaults.integer(forKey: "level")
        
        //MARK: Need to uncomment the line before and comment out the next line
//        self.level.number = 16
        getLevel()
        setBoard()
        
//        delegate?.setUpControlViews()
//        updateLevelInfo()
//        setupInstructions()
        
    }
    
    func setUpControlsAndInstructions() {
        
        delegate?.setUpControlViews()
        updateLevelInfo()
        setupInstructions()
        setupNextView()
        
    }
    
    func setNextPiece() {
        
//        let piece = Piece(indexes: <#T##Indexes#>, shape: <#T##Shape#>, colors: <#T##[UIColor]#>, version: <#T##Int#>, isLocked: <#T##Bool#>, doesPivot: <#T##Bool#>)
        
        
    }
    
    
    func updateLevelInfo() {
        
        let name = levelModel.levelNames[level.number]
        let moves = "\(board.moves)"
        delegate?.updateLevelInfo(name: name, moves: moves)
    }
    
//    func showLoadingAnimation() { //NOT CALLED
//
//        self.board = Board()
//        self.board.heightSpaces = 8
//        self.board.widthSpaces = 4
//
//        let ball = Ball()
//        board.balls.append(ball)
//
//        for piece in board.pieces {
//
//            if piece.shape == .entrance {
//
//                ball.indexes = piece.indexes
//                ball.onColor = piece.colors[0]
//            }
//        }
//
//        delegate?.setUpGameViews(board: self.board)
//        delegate?.setUpPiecesView()
//        moveBall(ball: ball, startSide: "unmoved")
//    }
    
    func getLevel() {
        
//        level.number = 20
        
        levelModel = LevelModel()
        self.board = levelModel.returnBoard(levelNumber: level.number)
        setUpLevelDefaults()
        
    }
    
    func setUpLevelDefaults() {
        setUpRandomPieces()
//        setupNextPieces()
//        setupBalls()
    }
    
    
//    private func setupBalls() {
//
//        for piece in board.pieces {
//
//            if piece.shape == .entrance {
//
//                let ball = Ball()
//                ball.indexes = piece.indexes
//                ball.onColor = piece.colors[0]
//                board.balls.append(ball)
//            }
//        }
//    }
    
    
    
    
    
    func setBoard() {
        
        delegate?.setUpGameViews(board: self.board)
        delegate?.setUpPiecesView()
        
        
        
        
//        delegate?.setUpControlViews()
//        updateLevelInfo()
//        setupInstructions()
    }
    
    
    func setupNextView() {
        
        
        print("setupNextView called")
        
//        var pieces = [Piece]()
        let piece1 = Piece(indexes: Indexes(x: 1, y: 2), color: UIColor.red)
        
        
        delegate?.setUpNextView(nextPiece: piece1)
        //DELEGATE - SETUPNEXTVIEW
        
        
        
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

//            piece.shape = setPieceShape(piece: piece)
//            piece.colors = setPieceColor(piece: piece)
            
//            setPieceSwitches(piece: piece)
//            piece.setPieceTotalVersions(shape: piece.shape)
//            piece.version = setPieceVersion(piece: piece)
//            piece.setPieceTotalVersions(shape: piece.shape)
//            piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
            
//            piece.doesPivot = setPivot(piece: piece)
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
    
//    func setPieceShape(piece: Piece) -> Shape {
//
//        var shape: Shape?
//
//        var randomShapes = [Shape]()
//
////        print(piece.pieceMakerPieces)
//
//        if piece.pieceMakerPieces == nil {
//            randomShapes = board.randomPieceShapes
//
//        } else {
//
//            for pieceX in piece.pieceMakerPieces! {
//                randomShapes.append(pieceX.shape)
//            }
//
//
//        }
//
//        shape = randomShapes[Int(arc4random_uniform(UInt32(randomShapes.count)))]
//
//
//
////        if board.randomPieceColors.count == 1 && piece.shape == .stick {
////
////            setPieceShape(piece: piece)
////
////        } else if board.randomPieceColors.count == 2 && piece.shape == .stick {
////
////            if piece.colors[0] == piece.colors[1] {
////                setPieceShape(piece: piece)
////            }
////        }
//        return shape!
//
//    }
    
//    func setPieceVersion(piece: Piece) -> Int{
//
////        var int = Int()
//
//        var maxVersions = 4
//
//
//        if piece.shape == .doubleElbow {
//            maxVersions = 8
//        }
//
//
//        let version = Int(arc4random_uniform(UInt32(maxVersions))) + 1
//
//        piece.version = version
//
//
//
//        return version
//    }
//    
//    func setPieceColor(piece: Piece) -> [UIColor] {
//        
//        //TODO: Make it that the pieceMakers can have the option to have specific pieces that come out
//        
//        var randomColors = [UIColor]()
//        var randomColor1 = UIColor()
//        var randomColor2 = UIColor()
//        
//        
//        if piece.pieceMakerPieces == nil {
//            randomColors = board.randomPieceColors
//            randomColor1 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count - 1)))]
//            randomColor2 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count)))]
//            
////            piece.colors = [randomColor1, randomColor2]
//            
//        } else {
//            
//            for pieceX in piece.pieceMakerPieces! {
//                for color in pieceX.colors {
//                    randomColors.append(color)
//                }
//            }
//            
//            randomColor1 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count - 1)))]
//            randomColor2 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count)))]
//
////            piece.colors = randomColors
//            
//        }
//        
//        
//        
//        
//        
//        return [randomColor1, randomColor2]
//    }
    
//    func fallsOffBoard(piece: Piece, direction: Direction) -> Bool {
//        
//        var bool = false
//        
//        if piece.shape != .entrance {
//            return false
//        }
//        
//        switch direction {
//            
//        case .up:
//            
//            if piece.indexes.y == 0 {
//                bool = true
//            }
//            
//        case .down:
//            
//            if piece.indexes.y == board.heightSpaces - 1 {
//                bool = true
//            }
//            
//        case .left:
//            
//            if piece.indexes.x == 0 {
//                bool = true
//            }
//            
//        case .right:
//            
//            if piece.indexes.x == board.heightSpaces - 1 {
//                bool = true
//            }
//            
//        default:
//            
//            break
//            
//            
//        }
//        
//   
////        print("BOOOL IS \(bool)")
//        
//        
//        return bool
//    }
    
    
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
    
//    func getPieceInfoOptional(index: Indexes, pieces: [Piece]) -> Piece? {
//
//        var piece = Piece()
//
//        for pieceX in pieces {
//
//            if pieceX.indexes == index {
//
//                piece = pieceX
//            }
//        }
//        return piece
//    }
    
    
    func checkForIce(piece: Piece) -> Bool {

        var bool = false

        if board.iceLocations.contains(where: { (index) -> Bool in
            index == piece.indexes
        }) {
            bool = true
        }
        return bool
    }
    
//    func checkForHole(piece: Piece, direction: Direction) -> Bool {
//        
//        var bool = false
//        
//        if board.holeLocations.contains(where: { (index) -> Bool in
//            index == piece.indexes
//        }) {
//            
//            if piece.shape == .blank {
//                
//                let indexOfHole = piece.indexes
//                bool = false
//                delegate?.removeHole(piece: piece)
//                
//                var int = 0
//                for holeLocation in board.holeLocations {
//                    
//                    if holeLocation == indexOfHole {
//                        board.holeLocations.remove(at: int)
//                        
//                    }
//                    int += 1
//                }
//                
//                board.pieces.removeAll { (pieceX) in
//                    pieceX.indexes == piece.indexes
//                }
//                
//            } else {
//                bool = true
//            }
//        }
//        return bool
//    }
    
//    func setupNextPieces() {
//
//        for piece in board.pieces {
//
//            if piece.shape == .pieceMaker {
//
////                print("PIECEMAKER FOUND")
//
//                resetPieceMaker(piece: piece)
//
//
////                createNextPiece(piece: piece, direction: nil)
//            }
//        }
//
//    }
    
//    func resetPieceMaker(piece: Piece) {
//
//        let nextPiece = Piece()
//        nextPiece.indexes = piece.indexes
//
//        nextPiece.colors = setPieceColor(piece: piece)
//        nextPiece.shape = setPieceShape(piece: piece)
//        nextPiece.setPieceTotalVersions(shape: nextPiece.shape)
//        nextPiece.version = setPieceVersion(piece: nextPiece)
//
//        nextPiece.setPieceSides(shape: nextPiece.shape, version: nextPiece.version, colors: nextPiece.colors)
//
//        nextPiece.doesPivot = setPivot(piece: piece)
//        nextPiece.isLocked = false
//        piece.nextPiece = nextPiece
//
//        //Add the view here
//
//
//
//
////        board.pieces.append(piece.nextPiece!)
//
////        print("NEXT PIECE VERSION = \(nextPiece.version)")
//
//
////        delegate?.resetPieceMakerView(piece: piece)
//    }
    
//    func setPivot(piece: Piece) -> Bool {
//        
//        var bool = Bool()
//        
//        var randomBools = [Bool]()
//        
//        if piece.pieceMakerPieces != nil {
//            for pieceX in piece.pieceMakerPieces! {
//                
//                
//                randomBools.append(pieceX.doesPivot)
//            }
//            bool = randomBools[Int(arc4random_uniform(UInt32(randomBools.count)))]
//        } else {
//            bool = true
//        }
//        
//        
//        
//        return bool
//        
//    }
    
    
    var counterX = 0
    
    func updateMovesLeft() {
        
        counterX += 1
        
//        print("count = \(counterX)")
        
        var movesX = String()
        
        if moveStarted == true {
            
            if board.moves != 0 {
                
                board.moves -= 1
                movesX = "\(board.moves)"
                
                if board.moves == 0 {
                    
                    delegate?.disableSwipes()
                    
                }
                
            } else {
                
                movesX = "∞"
            }
            delegate?.updateMovesLeftLabel(moves: movesX)
            moveStarted = false
        }
    }
    
    func movePiecesHelper(piece: Piece, direction: Direction) {
        
        if let indexes = piece.indexes {
        
        
        switch direction {
            
        case .up:
            
            
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .up, indexes: indexes, pieces: board.pieces)
            
            if spaceIsntBlocked {
                
//                if piece.shape != .pieceMaker {
                    
                    updateMovesLeft()
                    
                    if indexes.y != 0 {
                        piece.indexes?.y = (indexes.y)! - 1
                    }
                    
//                }
                
                
            } else {
                return
            }
            
        case .down:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .down, indexes: indexes, pieces: board.pieces)
            
            if spaceIsntBlocked {
                
                    updateMovesLeft()
                    
                    if indexes.y != board.heightSpaces - 1 {
                        piece.indexes?.y = indexes.y! + 1
                    }
                    
                    
                
                
            } else {
                return
            }
            
        case .left:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .left, indexes: indexes, pieces: board.pieces)
            
            if spaceIsntBlocked {
                
                    updateMovesLeft()
                    
                    if indexes.x != 0 {
                        piece.indexes?.x = indexes.x! - 1
                    }
                    
                    
                
            } else {
                return
            }
            
        case .right:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .right, indexes: indexes, pieces: board.pieces)
            
            if spaceIsntBlocked {
                
//                if piece.shape != .pieceMaker {
                    
                    updateMovesLeft()
                    
                    if indexes.x != board.widthSpaces - 1 {
                        piece.indexes?.x = indexes.x! + 1
                    }
                    
                    
//                }
                
            } else {
                return
            }
            
        default:
            break
        }
        
    }
    }
    
//    func deletePiece(piece: Piece) {
//                
//        board.pieces.removeAll { (piece) -> Bool in
//            
//            if piece.indexes.x! < 0 || piece.indexes.x! > board.widthSpaces - 1 || piece.indexes.y! < 0 || piece.indexes.y! > board.heightSpaces - 1 {
//                
//                delegate?.removeView(view: piece.view)
//                
//                return true
//            }
//            return false
//        }
//        
//        board.pieces.removeAll { (piece) -> Bool in
//
//            for holeLocation in board.holeLocations {
//
//                if holeLocation == piece.indexes {
//
//                    delegate?.removeView(view: piece.view)
//                    return true
//                }
//            }
//            return false
//        }
//    }
    
    func deleteBall(ball: Ball) {
        
        board.balls.removeAll { (ball) -> Bool in
            
            if ball.indexes.x! < 0 || ball.indexes.x! > board.widthSpaces - 1 || ball.indexes.y! < 0 || ball.indexes.y! > board.heightSpaces - 1 {
                
                delegate?.removeView(view: ball.view)
                return true
            }
            return false
        }
        
        board.balls.removeAll { (ball) -> Bool in

            for holeLocation in board.holeLocations {

                if holeLocation == ball.indexes {

                    delegate?.removeView(view: ball.view)

                    return true
                }
            }
            return false
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
//        var groupsToNotRetry = [Group]()
        var pieceDidMove = false
        
        moveStarted = true
        
        sortPieces(direction: direction)
                
        for piece in pieces {
            
//            if piece.isLocked == false {

                if pieceIsPartOfAGroup(piece: piece, groups: board.pieceGroups) == false {
                    
                    print("PIECE START INDEXES \(piece.indexes)")
                    
                    let startIndexes = piece.indexes
                    
                    movePiecesHelper(piece: piece, direction: direction)
                    self.delegate?.movePieceView(piece: piece)
                    
                    print("PIECE END INDEXES \(piece.indexes)")
                    
                    let endIndexes = piece.indexes
                    
                    
                    if startIndexes == endIndexes {
                        
                        piecesToRetry.append(piece)
                    } else {
                        pieceDidMove = true
                    }
                    
                }
//            }
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
                        
                        
                        
                        print("PIECE INDEXES \(piece.indexes)")
                        
                        if board.pieces.contains(where: { pieceX -> Bool in
                            pieceX.indexes == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! - 1)
                        }) {
                            if !group.pieces.contains(where: { pieceXX -> Bool in
                                pieceXX.indexes == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! - 1)
                            }) {
                                groupCanMove = false
//                                piecesToRetry.append(piece)
                                
                            }
                            
                            
                        } else {
                            
                            if piecesIndexes.contains(where: { indexX -> Bool in
                                indexX == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! - 1)
                            }) {
                                
                                groupCanMove = false
//                                piecesToRetry.append(piece)
                                
//                                return
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
                        
                        print("PIECE INDEXES \(piece.indexes)")
                        
                        if board.pieces.contains(where: { pieceX -> Bool in
                            pieceX.indexes == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! + 1)
                        }) {
                            if !group.pieces.contains(where: { pieceXX -> Bool in
                                pieceXX.indexes == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! + 1)
                            }) {
                                groupCanMove = false
//                                piecesToRetry.append(piece)
                            }
                            
                            
                        } else {
                            
                            if piecesIndexes.contains(where: { indexX -> Bool in
                                indexX == Indexes(x: piece.indexes?.x, y: (piece.indexes?.y!)! + 1)
                            }) {
                                
                                groupCanMove = false
//                                piecesToRetry.append(piece)
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
                        
                        print("PIECE INDEXES \(piece.indexes)")
                        
                        if board.pieces.contains(where: { pieceX -> Bool in
                            pieceX.indexes == Indexes(x: (piece.indexes?.x!)! - 1, y: piece.indexes?.y)
                        }) {
                            if !group.pieces.contains(where: { pieceXX -> Bool in
                                pieceXX.indexes == Indexes(x: (piece.indexes?.x!)! - 1, y: piece.indexes?.y)
                            }) {
                                groupCanMove = false
//                                piecesToRetry.append(piece)
                            }
                            
                            
                        } else {
                            
                            if piecesIndexes.contains(where: { indexX -> Bool in
                                indexX == Indexes(x: (piece.indexes?.x!)! - 1, y: piece.indexes?.y)
                            }) {
                                
                                groupCanMove = false
//                                piecesToRetry.append(piece)
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
                        
                        print("PIECE INDEXES \(piece.indexes)")
                        
                        if board.pieces.contains(where: { pieceX -> Bool in
                            pieceX.indexes == Indexes(x: (piece.indexes?.x!)! + 1, y: piece.indexes?.y)
                        }) {
                            if !group.pieces.contains(where: { pieceXX -> Bool in
                                pieceXX.indexes == Indexes(x: (piece.indexes?.x!)! + 1, y: piece.indexes?.y)
                            }) {
                                groupCanMove = false
//                                piecesToRetry.append(piece)
                            }
                            
                            
                        } else {
                            
                            if piecesIndexes.contains(where: { indexX -> Bool in
                                indexX == Indexes(x: (piece.indexes?.x!)! + 1, y: piece.indexes?.y)
                            }) {
                                
                                groupCanMove = false
//                                piecesToRetry.append(piece)
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

        for ball in board.balls {
            
            board.view.bringSubviewToFront(ball.view)
        }
        
        
        if pieceDidMove {
            
            print("pieceDidMove Called")

            
            movePiece2(direction: direction, pieces: piecesToRetry)



        }
        
        
        
        
        
    }
    
    func movePiece(direction: Direction, pieces: [Piece]) {
        
        movePiece2(direction: direction, pieces: pieces)
        //Adding the next pieces last in order to make sure that there are no pieces blocking the pieceMaker
        
        for group in board.pieceGroups {
            group.didMove = false
        }
        
        
        addNextPieces()
//        changeNextPiece()
    }

    
//    func createNextPiece(piece: Piece, direction: Direction?) {
//
//        self.board.pieces.append(piece.nextPiece!)
//    
//        self.delegate?.addPieceView(piece: piece.nextPiece!)
//
//        if let direction = direction {
//
//            UIView.animate(withDuration: 0.25) {
//
//                let scale2 = CGAffineTransform(scaleX: 1, y: 1)
//                piece.nextPiece!.view.transform = scale2
//                
//                self.movePiecesHelper(piece: piece.nextPiece!, direction: direction)
//                self.delegate?.movePieceView(piece: piece.nextPiece!)
//                
//                
//            } completion: { (true) in
//
//                
////                self.resetPieceMaker(piece: piece)
//                self.delegate?.resetPieceMakerView(piece: piece)
//                
//                
//            }
//        }
//    }
    
    func changeNextPiece() {
        
        
    }
    
//    func calculateRandomPieceLocation() -> [Indexes] {
//
//        var indexesX = [Indexes]()
//
//        var tempIndex = [Indexes]()
//
//        for piece in nextPiece.pieces.sorted(by: { (piece1, piece2) -> Bool in
//            piece1.indexes.y! < piece2.indexes.y!
//        }).sorted(by: { (piece1, piece2) -> Bool in
//            piece1.indexes.x! < piece2.indexes.x!
//        })   {
//
//            print("PIECE INDEXES ARE \(piece.indexes) XXXXXX")
//
//            let randomBoardLocationX = arc4random_uniform(UInt32(board.widthSpaces))
//
//            let randomBoardLocationY = arc4random_uniform(UInt32(board.heightSpaces))
//
//
//            print(randomBoardLocationX)
//            print(randomBoardLocationY)
//
//
//            for pieceX in nextPiece.pieces {
//
//                if pieceX.indexes != piece.indexes {
//
//
//
//
//
//                }
//
//
//            }
//
//
//
//
//
//
//        }
//
//
//
//
//
//        return indexesX
//    }
    
    func addNextPieces() {
        
        //Calculate where the piece should go
//        calculateRandomPieceLocation()
        
        
        //Use delegate to move piece from NextView to the actual game board
        
        
        
        
        
//        for piece in board.pieces {
//
//            if piece.shape == .pieceMaker {
//
//                switch piece.version {
//
//                case 1:
//
//                    if direction == .down {
//
//                        let spaceIsntBlocked = isNextSpaceBlocked(direction: direction, indexes: piece.indexes, pieces: board.pieces)
//
//                        if spaceIsntBlocked {
//                            if piece.nextPiece != nil {
//
//                                updateMovesLeft()
//                                createNextPiece(piece: piece, direction: direction)
//                            }
//                        }
//                    }
//
//                case 2:
//                    if direction == .left {
//
//                        let spaceIsntBlocked = isNextSpaceBlocked(direction: direction, indexes: piece.indexes, pieces: board.pieces)
//
//                        if spaceIsntBlocked {
//                            if piece.nextPiece != nil {
//
//                                updateMovesLeft()
//                                createNextPiece(piece: piece, direction: direction)                            }
//                        }
//                    }
//                case 3:
//                    if direction == .up {
//
//                        let spaceIsntBlocked = isNextSpaceBlocked(direction: direction, indexes: piece.indexes, pieces: board.pieces)
//
//                        if spaceIsntBlocked {
//                            if piece.nextPiece != nil {
//
//                                updateMovesLeft()
//                                createNextPiece(piece: piece, direction: direction)
//                            }
//                        }
//                    }
//
//                case 4:
//                    if direction == .right {
//
//                        let spaceIsntBlocked = isNextSpaceBlocked(direction: direction, indexes: piece.indexes, pieces: board.pieces)
//
//                        if spaceIsntBlocked {
//                            if piece.nextPiece != nil {
//
//                                updateMovesLeft()
//                                createNextPiece(piece: piece, direction: direction)
//                            }
//                        }
//                    }
//
//                default:
//
//                    break
//                }
//            }
//        }
    }
    
//    func check4AutoBallMove() {
//
//        var fakePieces = [Piece]()
//
//        for piece in board.pieces {
//
//            let newPiece = Piece(indexes: piece.indexes, shape: piece.shape, colors: piece.colors, version: piece.version, isLocked: piece.isLocked, doesPivot: piece.doesPivot)
//            newPiece.setPieceTotalVersions(shape: newPiece.shape)
//            newPiece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//            fakePieces.append(newPiece)
//        }
//
//        for piece in fakePieces {
//
//            if piece.shape == .entrance {
//
//                let ball = Ball()
//                ball.piecesPassed.append(piece)
//
//                switch piece.version {
//
//                case 1:
//                    checkNextPiece4Exit(ball: ball, pieces: fakePieces, piece: piece, side2Check: "top")
//                case 2:
//                    checkNextPiece4Exit(ball: ball, pieces: fakePieces, piece: piece, side2Check: "right")
//                case 3:
//                    checkNextPiece4Exit(ball: ball, pieces: fakePieces, piece: piece, side2Check: "bottom")
//                case 4:
//                    checkNextPiece4Exit(ball: ball, pieces: fakePieces, piece: piece, side2Check: "left")
//
//                default:
//
//                    break
//                }
//            }
//        }
//    }
    
    func enlargeHelper(ball: Ball) {
        
        for piece in board.pieces {
            
            if ball.piecesPassed.contains(where: { (pieceX) in
                piece.indexes == pieceX.indexes
            }) {
                
                delegate?.enlargePiece(view: piece.view)
            }
        }
    }
    
//    func checkNextPiece4Exit(ball: Ball, pieces: [Piece], piece:Piece, side2Check: String) {
//
//        let delayedTime = DispatchTime.now() + .milliseconds(Int(100))
//
//        if check4FakeEndlessLoop(ball: ball, piece: piece) == true {
//
//            for ballX in board.balls {
//
//                if ballX.indexes == ball.piecesPassed[0].indexes {
//
//                    moveBall(ball: ballX, startSide: "unmoved")
//                }
//            }
//            return
//        }
//
////        print()
////        print("SIDE TO CHECK = \(side2Check)")
////        print("piece shape = \(piece.shape)")
////        print("piece version = \(piece.version)")
//
//        switch side2Check {
//            //side to check is the side of the new piece
//        case "top":
//
//            if let pieceX = getPieceInfo(index: Indexes(x: piece.indexes.x, y: piece.indexes.y! - 1), pieces: pieces) {
//
//                if pieceX.side.bottom.opening.isOpen == true {
//                    if piece.side.top.color == pieceX.side.bottom.color {
//
////
////                        if piece.shape == .entrance {
////
////                            if ball.piecesPassed.contains(where: { (pieceXX) -> Bool in
////                                pieceXX.indexes == piece.indexes
////                            }){
////                                DispatchQueue.main.asyncAfter(deadline: delayedTime) {
////
////                                    self.moveBall(ball: ball, startSide: "unmoved")
////                                }
////                            }
////
////                        }
////
////
//
//                        if pieceX.shape == .exit {
//
//                            for ballX in board.balls {
//
//                                if ballX.indexes == ball.piecesPassed[0].indexes {
//
//                                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//                                        self.moveBall(ball: ballX, startSide: "unmoved")
//                                    }
//                                }
//                            }
//                            return
//                        }
//
//                        if pieceX.side.bottom.closing.isOpen == false {
//
//
////                            print("cross version \(piece.version)")
////                            print("bottom closing is closed")
//                            return
//                        }
//
//                        if piece.shape == .cross {
//
////                            print("piece is a cross")
//
//                            if piece.colors[0] == piece.colors[1] {
//
//                                switch piece.version{
//
//                                case 1:
//                                    piece.version = 2
//                                case 2:
//                                    piece.version = 1
//                                case 3:
//                                    piece.version = 4
//                                case 4:
//                                    piece.version = 3
//                                default:
//                                    break
//                                }
//                            } else {
//                                switch piece.version{
//
//                                case 1:
//                                    piece.version = 3
//                                case 2:
//                                    piece.version = 4
//                                case 3:
//                                    piece.version = 1
//                                case 4:
//                                    piece.version = 2
//                                default:
//                                    break
//                                }
//                            }
//                            piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//                        }
//
//                        if piece.shape == .doubleElbow {
//
//                            switch piece.version {
//
//                            case 1:
//                                piece.version = 5
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 2:
//                                piece.version = 6
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 3:
//                                piece.version = 7
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 4:
//                                piece.version = 8
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 5:
//                                piece.version = 1
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 6:
//                                piece.version = 2
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 7:
//                                piece.version = 3
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 8:
//                                piece.version = 4
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            default:
//
//                                break
//
//                            }
//                        }
//                        addToFakePiecesPassed(ball: ball, piece: pieceX)
//                        checkNextPiece4Exit(ball: ball, pieces: pieces, piece: pieceX, side2Check: pieceX.side.bottom.exitSide!)
//                    }
//                }
//            }
//
//        case "right":
//
//            if let pieceX = getPieceInfo(index: Indexes(x: piece.indexes.x! + 1, y: piece.indexes.y), pieces: pieces) {
//
//                if pieceX.side.left.opening.isOpen == true {
//                    if piece.side.right.color == pieceX.side.left.color {
//
////
////                        if piece.shape == .entrance {
////
////                            if ball.piecesPassed.contains(where: { (pieceXX) -> Bool in
////                                pieceXX.indexes == piece.indexes
////                            }){
////                                DispatchQueue.main.asyncAfter(deadline: delayedTime) {
////
////                                    self.moveBall(ball: ball, startSide: "unmoved")
////                                }
////                            }
////
////                        }
////
//
//                        if pieceX.shape == .exit {
//
//                            for ballX in board.balls {
//
//                                if ballX.indexes == ball.piecesPassed[0].indexes {
//
//                                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//                                        self.moveBall(ball: ballX, startSide: "unmoved")
//                                    }
//                                }
//                            }
//                            return
//                        }
//
//                        if pieceX.side.left.closing.isOpen == false {
////                            print("left closing is closed")
//                            return
//                        }
//
//                        if piece.shape == .cross {
//
////                            print("piece is a cross")
//
//
//                            if piece.colors[0] == piece.colors[1] {
//
//                                switch piece.version{
//
//                                case 1:
//                                    piece.version = 2
//                                case 2:
//                                    piece.version = 1
//                                case 3:
//                                    piece.version = 4
//                                case 4:
//                                    piece.version = 3
//                                default:
//                                    break
//                                }
//                            } else {
//
//                                switch piece.version{
//
//                                case 1:
//                                    piece.version = 3
//                                case 2:
//                                    piece.version = 4
//                                case 3:
//                                    piece.version = 1
//                                case 4:
//                                    piece.version = 2
//                                default:
//                                    break
//                                }
//
//
////                                if piece.version != piece.totalVersions {
////                                    piece.version += 1
////                                } else {
////                                    piece.version = 1
////                                }
//                            }
//                            piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//                        }
//
//                        if piece.shape == .doubleElbow {
//
//                            switch piece.version {
//
//                            case 1:
//                                piece.version = 5
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 2:
//                                piece.version = 6
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 3:
//                                piece.version = 7
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 4:
//                                piece.version = 8
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 5:
//                                piece.version = 1
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 6:
//                                piece.version = 2
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 7:
//                                piece.version = 3
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 8:
//                                piece.version = 4
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            default:
//
//                                break
//
//                            }
//                        }
//                        addToFakePiecesPassed(ball: ball, piece: pieceX)
//                        checkNextPiece4Exit(ball: ball, pieces: pieces, piece: pieceX, side2Check: pieceX.side.left.exitSide!)
//                    }
//                }
//            }
//
//        case "bottom":
//
////            print("checking bottom")
//
//            if let pieceX = getPieceInfo(index: Indexes(x: piece.indexes.x, y: piece.indexes.y! + 1), pieces: pieces) {
//
//
////                print("piece version = \(piece.version)")
////                print("piece top closing = \(piece.side.top.closing.isOpen)")
//
//                if pieceX.side.top.opening.isOpen == true {
//
////                    print("piece color = \(piece.side.bottom.color)")
////                    print("pieceX color = \(pieceX.side.top.color)")
//
//                    if piece.side.bottom.color == pieceX.side.top.color {
//
////                        if piece.shape == .entrance {
////
////                            if ball.piecesPassed.contains(where: { (pieceXX) -> Bool in
////                                pieceXX.indexes == piece.indexes
////                            }){
////                                DispatchQueue.main.asyncAfter(deadline: delayedTime) {
////
////                                    self.moveBall(ball: ball, startSide: "unmoved")
////                                }
////                            }
////
////                        }
////
////
//                        if pieceX.shape == .exit {
//
//                            for ballX in board.balls {
//
//                                if ballX.indexes == ball.piecesPassed[0].indexes {
//
//                                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//                                        self.moveBall(ball: ballX, startSide: "unmoved")
//                                    }
//                                }
//                            }
//                            return
//                        }
//
//                        if pieceX.side.top.closing.isOpen == false {
////                            print("top closing is closed")
//                            return
//                        }
//
//                        if piece.shape == .cross {
//
//
////                            print("piece is a cross")
//
//                            if piece.colors[0] == piece.colors[1] {
//
//                                switch piece.version{
//
//                                case 1:
//                                    piece.version = 2
//                                case 2:
//                                    piece.version = 1
//                                case 3:
//                                    piece.version = 4
//                                case 4:
//                                    piece.version = 3
//                                default:
//                                    break
//                                }
//                            } else {
//
//                                switch piece.version{
//
//                                case 1:
//                                    piece.version = 3
//                                case 2:
//                                    piece.version = 4
//                                case 3:
//                                    piece.version = 1
//                                case 4:
//                                    piece.version = 2
//                                default:
//                                    break
//                                }
//
//
////                                if piece.version != piece.totalVersions {
////                                    piece.version += 1
////                                } else {
////                                    piece.version = 1
////                                }
//                            }
//                            piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//                        }
////
//                        if piece.shape == .doubleElbow {
//
//                            switch piece.version {
//
//                            case 1:
//                                piece.version = 5
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 2:
//                                piece.version = 6
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 3:
//                                piece.version = 7
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 4:
//                                piece.version = 8
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 5:
//                                piece.version = 1
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 6:
//                                piece.version = 2
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 7:
//                                piece.version = 3
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 8:
//                                piece.version = 4
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            default:
//
//                                break
//
//                            }
//                        }
//                        addToFakePiecesPassed(ball: ball, piece: pieceX)
//                        checkNextPiece4Exit(ball: ball, pieces: pieces, piece: pieceX, side2Check: pieceX.side.top.exitSide!)
//                    }
//                }
//            }
//
//        case "left":
//
//            if let pieceX = getPieceInfo(index: Indexes(x: piece.indexes.x! - 1, y: piece.indexes.y), pieces: pieces) {
//
//                if pieceX.side.right.opening.isOpen == true {
//                    if piece.side.left.color == pieceX.side.right.color {
//
////                        if piece.shape == .entrance {
////
////                            if ball.piecesPassed.contains(where: { (pieceXX) -> Bool in
////                                pieceXX.indexes == piece.indexes
////                            }){
////                                DispatchQueue.main.asyncAfter(deadline: delayedTime) {
////
////                                    self.moveBall(ball: ball, startSide: "unmoved")
////                                }
////                            }
////
////                        }
//
//
//                        if pieceX.shape == .exit {
//
//                            for ballX in board.balls {
//
//                                if ballX.indexes == ball.piecesPassed[0].indexes {
//
//                                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//                                        self.moveBall(ball: ballX, startSide: "unmoved")
//                                    }
//                                }
//                            }
//                            return
//                        }
//
//                        if pieceX.side.right.closing.isOpen == false {
//
////                            print("piece version is \(piece.version)")
////
////                            print("right closing is closed")
//                            return
//                        }
//
//                        if piece.shape == .cross {
//
////                            print("piece is a cross")
//
//                            if piece.colors[0] == piece.colors[1] {
//
//                                switch piece.version{
//
//                                case 1:
//                                    piece.version = 2
//                                case 2:
//                                    piece.version = 1
//                                case 3:
//                                    piece.version = 4
//                                case 4:
//                                    piece.version = 3
//                                default:
//                                    break
//                                }
//                            } else {
//
//                                switch piece.version{
//
//                                case 1:
//                                    piece.version = 3
//                                case 2:
//                                    piece.version = 4
//                                case 3:
//                                    piece.version = 1
//                                case 4:
//                                    piece.version = 2
//                                default:
//                                    break
//                                }
//
//
////                                if piece.version != piece.totalVersions {
////                                    piece.version += 1
////                                } else {
////                                    piece.version = 1
////                                }
//                            }
//                            piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//                        }
//
//                        if piece.shape == .doubleElbow {
//
//                            switch piece.version {
//
//                            case 1:
//                                piece.version = 5
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 2:
//                                piece.version = 6
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 3:
//                                piece.version = 7
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 4:
//                                piece.version = 8
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 5:
//                                piece.version = 1
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 6:
//                                piece.version = 2
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 7:
//                                piece.version = 3
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            case 8:
//                                piece.version = 4
//                                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//
//                            default:
//
//                                break
//
//                            }
//                        }
//                        addToFakePiecesPassed(ball: ball, piece: pieceX)
//                        checkNextPiece4Exit(ball: ball, pieces: pieces, piece: pieceX, side2Check: pieceX.side.right.exitSide!)
//                    }
//                }
//            }
//
//        default:
//
//            break
//        }
//    }
    
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
    
//    func check4GameOver() {
//
////        guard !board.pieces.contains(where: { (piece) in
////            piece.shape == .pieceMaker
////        }) else {
////            return
////        }
//
//        var message = ""
//        var bool = false
//        var moveablePieceCount = 0
//
//
////        var originalEntrancePieces = 0
////
////        for piece in level.board.pieces {
////            if piece.shape == .entrance{
////                originalEntrancePieces += 1
////            }
////        }
//
//
//        for piece in board.pieces {
//            if piece.isLocked == false {
//                moveablePieceCount += 1
//            }
//        }
//
//        if moveablePieceCount == 0 {
//
//            if !board.pieces.contains(where: { (piece) in
//                piece.shape == .pieceMaker
//            }) {
//                bool = true
//                message = "No more pieces to move!"
//            }
//        }
//
//        if bool == true {
//            delegate?.runPopUpView(title: message, message: "TRY AGAIN?")
//            gameOver = false
//            return
//        }
//    }
    
//    func addToFakePiecesPassed(ball: Ball, piece: Piece) {
//
//        if !ball.piecesPassed.contains(where: { (pieceX) -> Bool in
//            piece.indexes == pieceX.indexes
//        }) {
//
//            ball.piecesPassed.append(piece)
//        }
//        else {
//
//            if ball.loopedIndexes[piece.indexes] != nil {
//
//                ball.loopedIndexes[piece.indexes]! += 1
//
//            } else {
//
//                ball.loopedIndexes[piece.indexes] = 1
//            }
//        }
//    }
    
//    func addToPiecesPassed(ball: Ball, piece: Piece) {
//        
//        if !ball.piecesPassed.contains(where: { (pieceX) -> Bool in
//            piece.indexes == pieceX.indexes
//        }) {
//            
//            ball.piecesPassed.append(piece)
//        }
//        else {
//            
//            delegate?.changeViewColor(piece: piece, ball: ball)
//            delegate?.changeAnimationSpeed(slowerOrFaster: "faster")
//            
//            if ball.loopedIndexes[piece.indexes] != nil {
//                
//                ball.loopedIndexes[piece.indexes]! += 1
//                
//            } else {
//                
//                ball.loopedIndexes[piece.indexes] = 1
//                delegate?.changeAnimationSpeed(slowerOrFaster: "slower")
//            }
//        }
//    }
    
    func check4FakeEndlessLoop(ball: Ball, piece: Piece) -> Bool {
        
        var bool = false
        
        for index in ball.loopedIndexes {
            
            if index.value >= 5 {
                
                ball.loopedPieces.append(piece)
            }
        }
        if ball.loopedPieces.count >= 5 {

            if !ball.loopedIndexes.contains(where: { (key, value) -> Bool in
                value == 4
            }) {
                bool = true
            }
        }
        return bool
    }
    
    func check4EndlessLoop(ball: Ball) -> Bool {
        
        var bool = false
        
        for index in ball.loopedIndexes {
            
            if index.value >= 5 {
                
                if let piece = getPieceInfo(index: index.key, pieces: board.pieces) {
                    ball.loopedPieces.append(piece)

                }
               
            }
        }
        if ball.loopedPieces.count >= 5 {

            if !ball.loopedIndexes.contains(where: { (key, value) -> Bool in
                value == 4
            }) {
                bool = true
            }
        }
        return bool
    }
    
    func removePiecesInPath(ball: Ball) {
        
        for piece in ball.piecesPassed {
            
            delegate?.removeView(view: piece.view)
            
            board.pieces.removeAll { (pieceX) -> Bool in
                pieceX.indexes == piece.indexes
            }
        }
        
        board.balls.removeAll { (ballX) -> Bool in
            ball.indexes == ballX.indexes
        }
        delegate?.removeView(view: ball.view)
        delegate?.changeAnimationSpeed(slowerOrFaster: "slower")
    }
    
//    func moveBall(ball: Ball, startSide: String) {
//        
////        let concurrentQueue = DispatchQueue.global()
////
////        concurrentQueue.async { [self] in
//            
//            let piece = getPieceInfo(index: ball.indexes, pieces: board.pieces)!
//            
//            switch startSide {
//            
//            case "unmoved":
//                
//                let startSide = "center"
//
//                var endSide = ""
//                
//                switch piece.version {
//                
//                case 1:
//                    endSide = "top"
//                    ball.onColor = piece.side.top.color!
//                case 2:
//                    endSide = "right"
//                    ball.onColor = piece.side.right.color!
//                case 3:
//                    endSide = "bottom"
//                    ball.onColor = piece.side.bottom.color!
//                case 4:
//                    endSide = "left"
//                    ball.onColor = piece.side.left.color!
//                    
//                default:
//                    break
//                }
//                
//                addToPiecesPassed(ball: ball, piece: piece)
//                
////                let serialQueue = DispatchQueue.main
////                serialQueue.async {
//                    self.delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
////                }
//                
//                
//                
//            case "top":
//                
//                let startSide = "top"
//                
//                if let endSide = piece.side.top.exitSide {
//                    
//                    if piece.side.top.color != ball.onColor {
//                        
//                        delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
//                        break
//                    }
//                    
//                    
//                    if piece.shape == .cross {
//                        
//                        if check4CrossCrash(piece: piece, ball: ball, startSide: startSide) == true {
//                            delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
//                            break
//                            
//                        } else {
//                            switchPieceAfterBall(piece: piece, ball: ball)
//                        }
//                    }
//                    
//                    if piece.shape == .doubleElbow {
//
//                        switchPieceAfterBall(piece: piece, ball: ball)
//                    }
//                    
//                    if piece.shape == .stick {
//                        
//                        ball.onColor = piece.side.bottom.color!
//                    }
//                    
//                    
//                    if piece.shape == .elbow {
//                        
//                        if endSide == "left" {
//                            ball.onColor = piece.side.left.color!
//                        }
//                        if endSide == "right" {
//                            ball.onColor = piece.side.right.color!
//                        }
//                        
//                    }
//                    
//                    addToPiecesPassed(ball: ball, piece: piece)
//                    checkIfBallExited(ball: ball, endSide: endSide)
//                    
//                    if check4EndlessLoop(ball: ball) == true {
//                        
//                        removePiecesInPath(ball: ball)
//                        check4Winner()
//                        
//                        delegate?.addSwipeGestureRecognizer(view: self.board.view)
//                        break
//                        
//                    } else {
//                        
////                        let serialQueue = DispatchQueue.main
////                        serialQueue.async {
//                            self.delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
////                        }
//                    }
//                    
//                } else {
//                    
//                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
//                    break
//                }
//                
//            case "bottom":
//                
//                let startSide = "bottom"
//                
//                if let endSide = piece.side.bottom.exitSide {
//                    
//                    if piece.side.bottom.color != ball.onColor {
//                        
//                        delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
//                        
//                        break
//                    }
//                    
//                    if piece.shape == .cross {
//                        
//                        if check4CrossCrash(piece: piece, ball: ball, startSide: startSide) == true {
//                            
//                            delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
//                            
//                            break
//                            
//                        } else {
//                            
//                            switchPieceAfterBall(piece: piece, ball: ball)
//                        }
//                    }
//                    
//                    if piece.shape == .doubleElbow {
//                        
//                        switchPieceAfterBall(piece: piece, ball: ball)
//                    }
//                    
//                    if piece.shape == .stick {
//                        
//                        ball.onColor = piece.side.top.color!
//                    }
//                    
//                    if piece.shape == .elbow {
//                        
//                        if endSide == "left" {
//                            ball.onColor = piece.side.left.color!
//                        }
//                        if endSide == "right" {
//                            ball.onColor = piece.side.right.color!
//                        }
//                        
//                    }
//                    
//                    addToPiecesPassed(ball: ball, piece: piece)
//                    checkIfBallExited(ball: ball, endSide: endSide)
//                    
//                    if check4EndlessLoop(ball: ball) == true {
//                        
//                        removePiecesInPath(ball: ball)
//                        check4Winner()
//
//                        delegate?.addSwipeGestureRecognizer(view: self.board.view)
//                        
//                        break
//                        
//                    } else {
//                        
////                        let serialQueue = DispatchQueue.main
////                        serialQueue.async {
//                            self.delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
////                        }
//                    }
//
//                } else {
//                    
//                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
//                    
//                    print("crashed into a wall, or no track in place")
//                    
//                    break
//                }
//                
//            case "left":
//                
//                let startSide = "left"
//                
//                if let endSide = piece.side.left.exitSide {
//                    
//                    if piece.side.left.color != ball.onColor {
//                        
//                        delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
//                        
//                        break
//                    }
//                    
//                    if piece.shape == .cross {
//                        
//                        if check4CrossCrash(piece: piece, ball: ball, startSide: startSide) == true {
//                            
//                            delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
//                            
//                            break
//                            
//                        } else {
//                            
//                            switchPieceAfterBall(piece: piece, ball: ball)
//                        }
//                    }
//                    
//                    if piece.shape == .doubleElbow {
//
//                        switchPieceAfterBall(piece: piece, ball: ball)
//                    }
//                    
//                    if piece.shape == .stick {
//                        
//                        ball.onColor = piece.side.right.color!
//                    }
//                    
//                    if piece.shape == .elbow {
//                        
//                        if endSide == "top" {
//                            ball.onColor = piece.side.top.color!
//                        }
//                        if endSide == "bottom" {
//                            ball.onColor = piece.side.bottom.color!
//                        }
//                        
//                    }
//                    
//                    addToPiecesPassed(ball: ball, piece: piece)
//                    checkIfBallExited(ball: ball, endSide: endSide)
//                    
//                    if check4EndlessLoop(ball: ball) == true {
//                        
//                        removePiecesInPath(ball: ball)
//                        check4Winner()
//                        
//                        delegate?.addSwipeGestureRecognizer(view: self.board.view)
//                        
//                        break
//                        
//                    } else {
//                        
////                        let serialQueue = DispatchQueue.main
////                        serialQueue.async {
//                            self.delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
////                        }
//                    }
//                    
//                } else {
//                    
//                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
//                    
//                    print("crashed into a wall, or no track in place")
//                    
//                    break
//                }
//                
//            case "right":
//                
//                let startSide = "right"
//                
//                if let endSide = piece.side.right.exitSide {
//                    
//                    if piece.side.right.color != ball.onColor {
//                        
//                        delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
//                        
//                        break
//                    }
//                    
//                    if piece.shape == .cross {
//                        
//                        if check4CrossCrash(piece: piece, ball: ball, startSide: startSide) == true {
//                            
//                            delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
//                            
//                            break
//                            
//                        } else {
//
//                            switchPieceAfterBall(piece: piece, ball: ball)
//                        }
//                    }
//                    
//                    if piece.shape == .doubleElbow {
//
//                        switchPieceAfterBall(piece: piece, ball: ball)
//                    }
//                    
//                    if piece.shape == .stick {
//                        
//                        ball.onColor = piece.side.left.color!
//                    }
//                    
//                    if piece.shape == .elbow {
//                        
//                        if endSide == "top" {
//                            ball.onColor = piece.side.top.color!
//                        }
//                        if endSide == "bottom" {
//                            ball.onColor = piece.side.bottom.color!
//                        }
//                        
//                    }
//                    
//                    addToPiecesPassed(ball: ball, piece: piece)
//                    checkIfBallExited(ball: ball, endSide: endSide)
//                    
//                    if check4EndlessLoop(ball: ball) == true {
//                        
//                        removePiecesInPath(ball: ball)
//                        check4Winner()
//                        
//                        self.delegate?.addSwipeGestureRecognizer(view: self.board.view)
//                        
//                        break
//                        
//                    } else {
//                        
////                        let serialQueue = DispatchQueue.main
////                        serialQueue.async {
//                            self.delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
////                        }
//                    }
//                    
//                } else {
//                                    
//                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
//                    
//                    print("crashed into a wall, or no track in place")
//                    
//                    break
//                }
//            default:
//                break
//            }
//            return
//            
//            
//            
////        }
//        
//        
//    }
    
    func checkIfBallExited(ball: Ball, endSide: String) {
               
//        print("Check called")
//        print(ball.piecesPassed.count)
        
        if endSide == "center" {
            
            CATransaction.begin()
            
            CATransaction.setCompletionBlock {
                
                self.delegate?.addSwipeGestureRecognizer(view: self.board.view)
                self.check4Winner()
                
                let delayedTime = DispatchTime.now() + .milliseconds(Int(250))
                DispatchQueue.main.asyncAfter(deadline: delayedTime) {

                    self.delegate?.removeView(view: ball.view)
                }
                
                return
            }
            
            for piece in ball.piecesPassed {
                
                let delayedTime = DispatchTime.now() + .milliseconds(Int(250))

                DispatchQueue.main.asyncAfter(deadline: delayedTime) {

                    self.delegate?.removeView(view: piece.view)
                    self.board.pieces.removeAll { (pieceX) -> Bool in
                        pieceX.indexes == piece.indexes
                    }
                }
            }
            
            self.board.balls.removeAll { (ballX) -> Bool in
                
                ballX.indexes == ball.indexes
            }
            
            CATransaction.commit()
        }
    }
    
    func check4Winner(){
        
        if board.balls.isEmpty {
            
            self.delegate?.runPopUpView(title: "YOU WIN", message: "Great Job - Next Level?")
            self.gameOver = true
            return
            
        } else {
            return
        }
    }
    
//    func handleTap(center: CGPoint) {
//        
//        moveStarted = true
//        
//        let x2 = Int(center.x)
//        let y2 = Int(center.y)
//        
//        for piece in board.pieces {
//            
//            let x1 = Int(board.grid[piece.indexes]!.x)
//            let y1 = Int(board.grid[piece.indexes]!.y)
//            
//            if CGPoint(x: x1, y: y1) == CGPoint(x: x2, y: y2) {
//                
//                if piece.doesPivot == true {
//                                        
//                    switchVersions(piece: piece)
//                    piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//                    
//                    delegate?.replacePieceView(piece: piece)
//                }
//                
////                print("PIECE SHAPE = \(piece.shape)")
////                print("PIECE VERSION = \(piece.version)")
////                print(">")
////
////                print("PIECE TOP COLOR = \(piece.side.top.color)")
////                print("PIECE TOP OPEN? = \(piece.side.top.opening.isOpen)")
////                print("PIECE TOP EXITSIDE = \(piece.side.top.exitSide)")
////
////                print(">")
////
////                print("PIECE RIGHT COLOR = \(piece.side.right.color)")
////                print("PIECE RIGHT OPEN? = \(piece.side.right.opening.isOpen)")
////                print("PIECE RIGHT EXITSIDE = \(piece.side.right.exitSide)")
////                print(">")
////
////
////                print("PIECE BOTTOM COLOR = \(piece.side.bottom.color)")
////                print("PIECE BOTTOM OPEN? = \(piece.side.bottom.opening.isOpen)")
////                print("PIECE BOTTOM EXITSIDE = \(piece.side.bottom.exitSide)")
////                print(">")
////
////
////
////                print("PIECE LEFT COLOR = \(piece.side.left.color)")
////                print("PIECE LEFT OPEN? = \(piece.side.left.opening.isOpen)")
////                print("PIECE LEFT EXITSIDE = \(piece.side.left.exitSide)")
//
//                
//                
//                
//                
//                
//            }
//        }
//        check4AutoBallMove()
//    }

    func check4CrossCrash(piece: Piece, ball: Ball, startSide: String) -> Bool {
                
        var bool = false
        
        switch startSide {
        
        case "top":
            if piece.side.top.closing.isOpen == false {

                delegate?.crashBallViewIntoCross(piece: piece, ball: ball)
                bool = true
            }
        case "bottom":
            if piece.side.bottom.closing.isOpen == false {

                delegate?.crashBallViewIntoCross(piece: piece, ball: ball)
                bool = true
            }
        case "left":
            if piece.side.left.closing.isOpen == false {

                delegate?.crashBallViewIntoCross(piece: piece, ball: ball)
                bool = true
            }
        case "right":
            if piece.side.right.closing.isOpen == false {

                delegate?.crashBallViewIntoCross(piece: piece, ball: ball)
                bool = true
            }
        default:
            break
            
        }
        return bool
    }
    
//    func switchPieceAfterBall(piece: Piece, ball: Ball) {
//
//
//        piece.view.subviews[0].backgroundColor = .white
//
//        let delayedTime = DispatchTime.now() + .milliseconds(Int(250))
//
//        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//
//
//
//
//            switch piece.shape {
//
//            case .cross:
//
//                switch piece.version {
//
//                case 1:
//                    piece.version = 3
//                case 2:
//                    piece.version = 4
//                case 3:
//                    piece.version = 1
//                case 4:
//                    piece.version = 2
//                default:
//                    break
//                }
//
//                piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//                self.delegate?.switchCrissCross(piece: piece)
//
//            case .doubleElbow:
//
//                    switch piece.version {
//
//                    case 1:
//                        piece.version = 5
//                    case 2:
//                        piece.version = 6
//                    case 3:
//                        piece.version = 7
//                    case 4:
//                        piece.version = 8
//                    case 5:
//                        piece.version = 1
//                    case 6:
//                        piece.version = 2
//                    case 7:
//                        piece.version = 3
//                    case 8:
//                        piece.version = 4
//
//                    default:
//                        break
//                    }
//
//                    piece.setPieceSides(shape: piece.shape, version: piece.version, colors: piece.colors)
//                self.delegate?.switchCrissCross(piece: piece)
//
//            case .stick:
//                break
//            case .diagElbow:
//                break
//            case .elbow:
//                break
//            default:
//                break
//            }
//
//
//
//        }
//
//
//    }
    
//    func switchVersions(piece: Piece) {
//        
//        if piece.shape == .blank && piece.version == 2 { //MARK: CHANGED THIS TO VERSION FROM CURRENT SWITCH
//            return
//        }
//        
//        switch piece.shape {
//            
////        case .pieceMaker:
////
////
////
////
////            if piece.nextPiece?.version != piece.nextPiece?.totalVersions {
////                piece.nextPiece?.version += 1
////            } else {
////                piece.nextPiece?.version = 1
////            }
////
////
////
////            if piece.version != piece.totalVersions {
////                piece.version += 1
////            } else {
////                piece.version = 1
////            }
//            
////        case .doubleElbow:
//            
////            switch piece.version{
////
////            case 1:
////                piece.version = 5
////            case 2:
////                piece.version = 6
////            case 3:
////                piece.version = 7
////            case 4:
////                piece.version = 8
////            case 5:
////                piece.version = 1
////            case 6:
////                piece.version = 2
////            case 7:
////                piece.version = 3
////            case 8:
////                piece.version = 4
////            default:
////                break
////            }
//            
//            
////        case .elbow:
////
////            let originalLeft = piece.side.left
////            let originalRight = piece.side.right
////            let originalTop = piece.side.top
////            let originalBottom = piece.side.bottom
////
////            piece.side.top.color = originalLeft.color
//////            piece.side.top.opening = originalLeft.opening
//////            piece.side.top.exitSide = originalLeft.exitSide
//////            piece.side.top.closing = originalLeft.closing
////
////            piece.side.right.color = originalTop.color
//////            piece.side.right.opening = originalTop.opening
//////            piece.side.right.exitSide = originalTop.exitSide
//////            piece.side.right.closing = originalTop.closing
////
////            piece.side.bottom.color = originalRight.color
//////            piece.side.bottom.opening = originalRight.opening
//////            piece.side.bottom.exitSide = originalRight.exitSide
//////            piece.side.bottom.closing = originalRight.closing
////
////            piece.side.left.color = originalBottom.color
//////            piece.side.left.opening = originalBottom.opening
//////            piece.side.left.exitSide = originalBottom.exitSide
//////            piece.side.left.closing = originalBottom.closing
////
//            
//        case .cross:
//            
//            if piece.colors[0] == piece.colors[1] {
//                
//                print("Colors are the same")
//                
//                switch piece.version{
//                    
//                case 1:
//                    piece.version = 2
//                case 2:
//                    piece.version = 1
//                case 3:
//                    piece.version = 4
//                case 4:
//                    piece.version = 3
//                default:
//                    break
//                }
//            } else {
//                
//                //MARK: WHY DOESNT THIS HAVE TO BE LIKE THE OTHERS? (SEE LINE 1134)
//                //MARK: SOMETHING DEFINITELY STILL WRONG WITH CROSS
//                
////                print("Colors are diff")
////
////
////
////                switch piece.version{
////
////                case 1:
////                    piece.version = 3
////                case 2:
////                    piece.version = 4
////                case 3:
////                    piece.version = 1
////                case 4:
////                    piece.version = 2
////                default:
////                    break
////                }
//                
//                
//                
//                
//                
////                print("colors are diff")
//
//                if piece.version != piece.totalVersions {
//                    piece.version += 1
//                } else {
//                    piece.version = 1
//                }
//            }
//            
//        default:
//            
//            if piece.version != piece.totalVersions {
//                
//                piece.version += 1
//                
//            } else {
//                
//                piece.version = 1
//            }
//        }
//    }
 
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
        gameOver = false
    }
}
