//
//  Level.swift
//  swipematter
//
//  Created by Jeffery Widroff on 1/16/23.
//


import Foundation
import UIKit

//class Level {
//
//    var number = 1
//    var board = Board()
//}
//
//protocol LevelDelegate {
//
//    func resetPieceMaker(piece: Piece)
//}

//class LevelModel {
//    
//    let board = Board()
////    var delegate: LevelDelegate?
//    let levelNames = ["rush hour",]
//        
//    func returnBoard(levelNumber: Int) -> Board {
//        
//        let levelName = levelNames[levelNumber]
//        
//        switch levelName {
//
//        case "rush hour":
//
//            board.heightSpaces = 9
//            board.widthSpaces = 9
//
//            let piece1 = Piece(indexes: Indexes(x: 6, y: 1), color: UIColor.red)
//            board.pieces.append(piece1)
//
//            let piece2 = Piece(indexes: Indexes(x: 7, y: 1), color: UIColor.red)
//            board.pieces.append(piece2)
//
//            let piece3 = Piece(indexes: Indexes(x: 7, y: 2), color: UIColor.red)
//            board.pieces.append(piece3)
//
//
//            let group = Group(pieces: [piece1, piece2, piece3])//, piece4])
//
//
//            let piece4 = Piece(indexes: Indexes(x: 5, y: 2), color: UIColor.red)
//            board.pieces.append(piece4)
//
//
//
//            let piece5 = Piece(indexes: Indexes(x: 5, y: 3), color: UIColor.cyan)
//            board.pieces.append(piece5)
//
//            let piece6 = Piece(indexes: Indexes(x: 6, y: 3), color: UIColor.red)
//            board.pieces.append(piece6)
//
//            let piece7 = Piece(indexes: Indexes(x: 6, y: 4), color: UIColor.red)
//            board.pieces.append(piece7)
//
//
//            let group2 = Group(pieces: [piece4, piece5, piece6, piece7])
//
//
//            let piece8 = Piece(indexes: Indexes(x: 3, y: 3), color: UIColor.cyan)
//            board.pieces.append(piece8)
//
//            let piece9 = Piece(indexes: Indexes(x: 3, y: 2), color: UIColor.red)
//            board.pieces.append(piece9)
//
//            let piece10 = Piece(indexes: Indexes(x: 2, y: 3), color: UIColor.red)
//            board.pieces.append(piece10)
//
//            let piece11 = Piece(indexes: Indexes(x: 2, y: 2), color: UIColor.red)
//            board.pieces.append(piece11)
//
//
//            let group3 = Group(pieces: [piece8, piece9, piece10, piece11])
//
//
//            let piece12 = Piece(indexes: Indexes(x: 8, y: 0), color: UIColor.cyan)
//            board.pieces.append(piece12)
//
//            let piece13 = Piece(indexes: Indexes(x: 8, y: 1), color: UIColor.red)
//            board.pieces.append(piece13)
//
//            let piece14 = Piece(indexes: Indexes(x: 8, y: 2), color: UIColor.red)
//            board.pieces.append(piece14)
//
//            let piece15 = Piece(indexes: Indexes(x: 8, y: 3), color: UIColor.red)
//            board.pieces.append(piece15)
//
//
//            let group4 = Group(pieces: [piece12, piece13, piece14, piece15])
//
//
//            let piece16 = Piece(indexes: Indexes(x: 6, y: 8), color: UIColor.cyan)
//            board.pieces.append(piece16)
//
//            let piece17 = Piece(indexes: Indexes(x: 7, y: 8), color: UIColor.red)
//            board.pieces.append(piece17)
//
//            let piece18 = Piece(indexes: Indexes(x: 8, y: 8), color: UIColor.red)
//            board.pieces.append(piece18)
//
//            let piece19 = Piece(indexes: Indexes(x: 7, y: 7), color: UIColor.red)
//            board.pieces.append(piece19)
//
//
//            let group5 = Group(pieces: [piece16, piece17, piece18, piece19])
//
//
//            let piece20 = Piece(indexes: Indexes(x: 6, y: 6), color: UIColor.red)
//            board.pieces.append(piece20)
//
//            let piece21 = Piece(indexes: Indexes(x: 6, y: 5), color: UIColor.red)
//            board.pieces.append(piece21)
//
//
//            let group6 = Group(pieces: [piece20, piece21])
//
//
//            let piece22 = Piece(indexes: Indexes(x: 1, y: 6), color: UIColor.red)
//            board.pieces.append(piece22)
//
//            let piece23 = Piece(indexes: Indexes(x: 2, y: 6), color: UIColor.red)
//            board.pieces.append(piece23)
//
//
//            let piece24 = Piece(indexes: Indexes(x: 2, y: 7), color: UIColor.red)
//            board.pieces.append(piece24)
//
//            let piece25 = Piece(indexes: Indexes(x: 3, y: 7), color: UIColor.red)
//            board.pieces.append(piece25)
//
//            let piece26 = Piece(indexes: Indexes(x: 3, y: 8), color: UIColor.red)
//            board.pieces.append(piece26)
//
//            let group7 = Group(pieces: [piece22, piece23, piece24, piece25, piece26])
//
//            let piece27 = Piece(indexes: Indexes(x: 4, y: 6), color: UIColor.red)
//            board.pieces.append(piece27)
//
//            let group8 = Group(pieces: [piece27])
//
//
//            let piece28 = Piece(indexes: Indexes(x: 0, y: 0), color: UIColor.red)
//            board.pieces.append(piece28)
//
//            let piece29 = Piece(indexes: Indexes(x: 0, y: 1), color: UIColor.red)
//            board.pieces.append(piece29)
//
//            let group9 = Group(pieces: [piece28 ,piece29])
//            board.pieceGroups = [group, group2, group3, group4, group5, group6, group7, group8, group9]
//
//        default:
//            break
//
//        }
//        return board
//    }
//    
////    private func setPieceIndex(piece: Piece) {
////
////        let index = Indexes(x: Int(arc4random_uniform(UInt32(board.widthSpaces))), y: Int(arc4random_uniform(UInt32(board.heightSpaces))))
////
////        // This is to make sure that the pieces dont start on another piece
////        if board.pieces.contains(where: { (pieceX) -> Bool in
////            pieceX.indexes == index
////        }){
////            setPieceIndex(piece: piece)
////        } else {
////
////            piece.indexes = index
////        }
////    }
//}

