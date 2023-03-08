//
//  ViewController.swift
//  swipematter
//
//  Created by Jeffery Widroff on 1/16/23.
//

import UIKit


class ViewController: UIViewController {

    var model = Model()
    var pieceWidth = CGFloat()
    var pieceHeight = CGFloat()
    var boardWidth = CGFloat()
    var boardHeight = CGFloat()
    var piecesWereEnlarged = false
    var distanceFromPieceCenter = CGFloat()
    var deviceIsNarrow = Bool()
    var retryButton = UIButton()
    var menuButton = UIButton()
    var heightCushion = CGFloat()
    var widthCushion = CGFloat()
    var colorTheme = ColorTheme()
    var boardView = UIView()
    var duration4Animation = 0.10
    var movesLeftNumberLabel = UILabel()
    var movesLeftTextLabel = UILabel()
    var levelNameLabel = UILabel()
    var levelObjectiveLabel = UILabel()
    var topBarView = UIView()
    var instructionsShown = false
    var nextPiece = NextPiece()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addGradient()
        model = Model()
        model.delegate = self
        model.board.view.removeFromSuperview()
        model.setUpGame()
        model.setUpControlsAndInstructions()
    }
    
    func addGradient() {
        
        let gradient = CAGradientLayer()
        
        //These angle the gradient on the X & Y axis (negative numbers can be used too)
        gradient.startPoint = .init(x: 0.0, y: 0.0)
        gradient.endPoint = .init(x: 0.0, y: 2.0)
        
        //This is the location of where in the middle the colors are together. (the closer they are together, the less they mesh. If its too far, you cant even notice that its 2 colors so it'll just look like one color that the two colors make)
        gradient.locations = [-0.1, 0.5, 1.1]
        
        //This keeps the gradient within the bounds of the view
        gradient.frame = self.view.bounds
        gradient.opacity = 0.5
        //These are the colors of the gradient(that are being passed in)
        gradient.colors = [UIColor.cyan.cgColor, UIColor.white.cgColor, UIColor.blue.cgColor]
        
        //This determines the layer of the view you're setting the gradient (the higher up the number is, the more outer of a layer it is - which is why "gradientColors2" wont show up if gradientColors is higher and vise versa)
        self.view.layer.insertSublayer(gradient, at: 1)
        
        let gradient2 = CAGradientLayer()
        
        //These angle the gradient on the X & Y axis (negative numbers can be used too)
        gradient2.startPoint = .init(x: 0.0, y: 0.0)
        gradient2.endPoint = .init(x: 2.0, y: 0.0)
        
        //This is the location of where in the middle the colors are together. (the closer they are together, the less they mesh. If its too far, you cant even notice that its 2 colors so it'll just look like one color that the two colors make)
        gradient2.locations = [-0.1, 0.5, 1.1]
        
        //This keeps the gradient within the bounds of the view
        gradient2.frame = self.view.bounds
        gradient2.opacity = 0.5
        //These are the colors of the gradient(that are being passed in)
        gradient2.colors = [UIColor.blue.cgColor, UIColor.white.cgColor, UIColor.cyan.cgColor]
        

        //This determines the layer of the view you're setting the gradient (the higher up the number is, the more outer of a layer it is - which is why "gradientColors2" wont show up if gradientColors is higher and vise versa)
        self.view.layer.insertSublayer(gradient2, at: 2)
        
    }
    
    //MARK: Initial Setup
    func setupGrid() { //MARK: This should be in the Model

        let x = 0.0 // (self.model.board.view.frame.width - boardWidth) / 2
        let y = 0.0 //(self.model.board.view.frame.height - boardHeight) / 2
        let frame = CGRect(x: x, y: y, width: boardWidth, height: boardHeight)
        self.model.board.grid = GridPoints(frame: frame, height: self.model.board.heightSpaces, width: self.model.board.widthSpaces).getGrid()
    }
    
    func setupBoard(board: Board) {
        
        var xArray = [CGFloat]()
        var yArray = [CGFloat]()
        
        for point in self.model.board.grid.values {
                        
            if !xArray.contains(point.x) {
                
                xArray.append(point.x)
            }
            
            if !yArray.contains(point.y) {
                
                yArray.append(point.y)
            }
        }
        
        boardView = BoardView(frame: CGRect(), xArray: xArray, yArray: yArray, iceLocations: model.board.iceLocations, holeLocations: model.board.holeLocations, colorTheme: board.colorTheme)
        self.model.board.view = boardView
        self.addSwipeGestureRecognizer(view: model.board.view)
        view.addSubview(self.model.board.view)
                
        model.board.view.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(model.board.view.widthAnchor.constraint(equalToConstant: view.frame.width / 10 * 9))
        constraints.append(model.board.view.heightAnchor.constraint(equalToConstant: view.frame.width / 10 * 9))
        constraints.append(model.board.view.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(model.board.view.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setSizes(board: Board) {

        boardWidth = view.frame.width / 10 * 9
        boardHeight = boardWidth
        widthCushion = 0
        heightCushion = 0
        pieceWidth = boardWidth / CGFloat(model.board.widthSpaces) / 10 * 9.5
        pieceHeight = boardHeight / CGFloat(model.board.heightSpaces) / 10 * 9.5
        distanceFromPieceCenter = (pieceWidth) / 2
    }
    
    func setupControls() {
        
        setupTopBar()
        setupRetryButton()
        setupMenuButton()
    }
    
    func setupTopBar() {
        
        topBarView.backgroundColor = ColorTheme.boardBackground
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBarView)
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(topBarView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(topBarView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(topBarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0))
        constraints.append(topBarView.bottomAnchor.constraint(equalTo: boardView.topAnchor, constant: -100.0))
        NSLayoutConstraint.activate(constraints)
        topBarView.layer.masksToBounds = false
        topBarView.layoutIfNeeded()
    }
    
    func setupRetryButton() {
        
        let controlHeight = pieceHeight / 2
        let buttonWidth = (boardWidth / 2) - 10
        let buttonHeight = controlHeight
        
        let retryButtonYFloat = model.board.view.frame.maxY + (controlHeight / 2)
        let retryButtonXFloat = model.board.view.frame.minX + (boardWidth / 2) + 10
        let retryButtonFrame = CGRect(x: retryButtonXFloat, y: retryButtonYFloat, width: buttonWidth, height: buttonHeight)
        retryButton = UIButton(frame: retryButtonFrame)
        retryButton.titleLabel?.adjustsFontSizeToFitWidth = true
        retryButton.setTitleColor(colorTheme.buttonTextColor, for: .normal)
        retryButton.setImage(UIImage(named: "restart"), for: .normal)
        retryButton.addTarget(self, action: #selector(handleTap4Retry(sender:)), for: .touchUpInside)
        view.addSubview(retryButton)
        
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(retryButton.trailingAnchor.constraint(equalTo: topBarView.safeAreaLayoutGuide.trailingAnchor, constant: -view.frame.width / 25))
        constraints.append(retryButton.bottomAnchor.constraint(equalTo: topBarView.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(retryButton.widthAnchor.constraint(equalTo: topBarView.heightAnchor, multiplier: 0.5))
        constraints.append(retryButton.heightAnchor.constraint(equalTo: topBarView.heightAnchor, multiplier: 0.5))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupMenuButton() {
        
        let controlHeight = pieceHeight / 2
        let buttonWidth = (boardWidth / 2) - 10
        let buttonHeight = controlHeight
        let menuButtonYFloat = model.board.view.frame.maxY + (controlHeight / 2)
        let menuButtonXFloat = model.board.view.frame.minX
        let menuButtonFrame = CGRect(x: menuButtonXFloat, y: menuButtonYFloat, width: buttonWidth, height: buttonHeight)
        
        menuButton = UIButton(frame: menuButtonFrame)
        menuButton.layer.cornerRadius = menuButton.frame.height / 2
        menuButton.backgroundColor = UIColor.clear
        menuButton.setImage(UIImage(named: "menu"), for: .normal)
        menuButton.addTarget(self, action: #selector(handleTap4Menu(sender:)), for: .touchUpInside)
        view.addSubview(menuButton)
        
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(menuButton.leadingAnchor.constraint(equalTo: topBarView.safeAreaLayoutGuide.leadingAnchor, constant: view.frame.width / 25))
        constraints.append(menuButton.bottomAnchor.constraint(equalTo: topBarView.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(menuButton.widthAnchor.constraint(equalTo: topBarView.heightAnchor, multiplier: 0.5))
        constraints.append(menuButton.heightAnchor.constraint(equalTo: topBarView.heightAnchor, multiplier: 0.5))
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func handleSwipe(sender:UISwipeGestureRecognizer) {
        
        switch sender.direction {
            
        case .up:
            model.movePiece(direction: .up, pieces: model.board.pieces)
            
        case .down:
            model.movePiece(direction: .down, pieces: model.board.pieces)
            
        case .right:
            model.movePiece(direction: .right, pieces: model.board.pieces)
            
        case .left:
            model.movePiece(direction: .left, pieces: model.board.pieces)
            
        default:
            break
        }
    }
    
    @objc func handleTap4Retry(sender: UITapGestureRecognizer) {
                        
        runPopUpView(title: "Restart", message: "Are you sure you want to restart?")
    }
    
    @objc func handleTap4Menu(sender: UITapGestureRecognizer) {
        
        runMenuView()
    }
    
    func runMenuView() {
        
        let width = self.view.frame.width / 10 * 9.5
        let height = self.view.frame.height / 10 * 9.5
        let x = (self.view.frame.width - width) / 2
        let y = (self.view.frame.height - height) / 2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let menuView = MenuView(frame: frame, model: model)
        menuView.clipsToBounds = true
        menuView.layer.cornerRadius = 25
        view.addSubview(menuView)
    }

    func radians(degrees: Double) ->  CGFloat {
        
        return CGFloat(degrees * .pi / degrees)
    }
}

extension ViewController: ModelDelegate {
    
    func setupInstructionsView(instructions: Instructions) {
        
        instructions.view.frame = CGRect(x: 0, y: 0, width: view.frame.width / 10 * 9, height: view.frame.height / 10 * 8)
        instructions.view.center = view.center
        view.addSubview(instructions.view)
    }
    
    func enlargePiece(view: UIView) {
        
        let transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        view.transform = transform
    }
    
    func addSwipeGestureRecognizer(view: UIView) {
        
        var upSwipe = UISwipeGestureRecognizer()
        var downSwipe = UISwipeGestureRecognizer()
        var rightSwipe = UISwipeGestureRecognizer()
        var leftSwipe = UISwipeGestureRecognizer()
        
        upSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        downSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    func removeView(view: UIView) {
        
        UIView.animate(withDuration: 0.5) {
            
            self.model.board.view.layer.mask?.shadowOpacity = 0.2
            self.model.board.view.bringSubviewToFront(view)
            let scale = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.model.board.view.layer.mask?.shadowOpacity = 0.1
            self.model.board.view.bringSubviewToFront(view)
            view.transform = scale
            
        } completion: { (true) in
            print()
        }
    }
    
    func addPieceView(piece: Piece) {
        
        if let indexes = piece.indexes {
            
            piece.center = self.model.board.grid[indexes]!
            piece.view.center = piece.center
            
            UIView.animate(withDuration: 0.25) {

                self.model.board.view.addSubview(piece.view)
            }
        }
    }
    
    func movePieceView(piece: Piece) {

        if let indexes = piece.indexes {
            
            if indexes.x! < 0 {
                
                UIView.animate(withDuration: 0.25) {
                    piece.center = CGPoint(x: piece.center.x - (self.distanceFromPieceCenter * 2), y: piece.center.y)
                    piece.view.center = piece.center
                }
                
            } else if indexes.x! > self.model.board.widthSpaces - 1 {
                
                UIView.animate(withDuration: 0.25) {
                    piece.center = CGPoint(x: piece.center.x + (self.distanceFromPieceCenter * 2), y: piece.center.y)
                    piece.view.center = piece.center

                }
                
            } else if indexes.y! < 0 {
                
                UIView.animate(withDuration: 0.25) {
                    piece.center = CGPoint(x: piece.center.x, y: piece.center.y - (self.distanceFromPieceCenter * 2))
                    piece.view.center = piece.center

                }
                
            } else if indexes.y! > self.model.board.heightSpaces - 1 {
                
                UIView.animate(withDuration: 0.25) {
                    piece.center = CGPoint(x: piece.center.x, y: piece.center.y + (self.distanceFromPieceCenter * 2))
                    piece.view.center = piece.center

                }
                
            } else {
                
                //Piece is on the board and therefore execute move regularly
                UIView.animate(withDuration: 0.25) {
                    piece.center = self.model.board.grid[indexes]!
                    piece.view.center = piece.center
                    
                }
            }
        }
    }
    
    func setUpPiecesView() {
        
        let center = CGPoint(x: (self.boardWidth / 2) - (pieceWidth / 2), y: -500)
        
        var counter = 0.0
        
        for piece in model.board.pieces {
            
            counter += 0.03
            
            UIView.animate(withDuration: 1.0, delay: counter, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: .curveEaseInOut) {
                
                var frame = CGRect(x: center.x, y: center.y, width: self.pieceWidth, height: self.pieceHeight)
                
                if !self.model.board.pieceGroups.isEmpty {
                    
                    for group in self.model.board.pieceGroups {
                        
                        if group.pieces.contains(where: { (pieceXX) in
                            pieceXX.indexes == piece.indexes
                        }) {
                            frame = CGRect(x: center.x, y: center.y, width: self.pieceWidth / 9 * 9, height: self.pieceHeight / 9 * 9)
                        }
                    }
                }
                
                if let indexes = piece.indexes {
                    
                    piece.view = ShapeView(frame: frame, piece: piece, groups: self.model.board.pieceGroups)
                    piece.center = CGPoint(x: self.model.board.grid[indexes]?.x ?? piece.center.x, y: self.model.board.grid[indexes]?.y ?? piece.center.y)
                    piece.view.center = piece.center
                    self.model.board.view.addSubview(piece.view)
                }
                
            } completion: { (true) in
                
            }
        }
    }
    
    func runPopUpView(title: String, message: String) {
          
        let delayedTime = DispatchTime.now() + .milliseconds(Int(250))
        
        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
        
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (action) in
                alert.dismiss(animated: true) {
                    
                    if title == "YOU WIN" {
                        self.model.level.number += 1
                        self.model.updateUserDefaults()
                    }
                    
                    self.movesLeftNumberLabel.textColor = UIColor.black
                    
                    self.model.resetGame()
                    
                    let delayedTime = DispatchTime.now() + .milliseconds(Int(25))
                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {

                        self.removeViews()
                        self.model.setUpGame()
                        self.model.setUpControlsAndInstructions()
                        
                        DispatchQueue.main.asyncAfter(deadline: delayedTime + 0.25) {
                            //Add code here if you want something to happen after the first wait
                        }
                    }
                }
            }
            
            alert.addAction(action)
            
            if title == "Restart" {
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (cancelAction) in
                    alert.dismiss(animated: true) {
                        //Add code
                    }
                }
                alert.addAction(cancelAction)
            }
            
            self.present(alert, animated: true) {
                //completion here
            }
        }
    }
    
    func removeViews() {
        
        self.boardView.removeFromSuperview()
        self.retryButton.removeFromSuperview()
        self.menuButton.removeFromSuperview()
    }
    
    func setUpGameViews(board: Board) {
                
        self.setSizes(board: board)
        self.setupGrid()
        self.setupBoard(board: board)
    }
    
    func setUpNextView(nextPiece: Piece) {

        let nextViewHeight = pieceHeight
        let nextViewWidth = pieceWidth
        let nextViewYFloat = topBarView.frame.height / 2
        let nextViewXFloat = view.center.x - (nextViewWidth / 2)
        let frame = CGRect(x: nextViewXFloat, y: nextViewYFloat, width: nextViewWidth, height: nextViewHeight)
        let nextView = ShapeView(frame: frame, piece: nextPiece, groups: nil)
        view.addSubview(nextView)
        makeSoft(view: nextView)
    }
    
    private func makeSoft(view: UIView) {
        
        let shadowRadius: CGFloat = 1
        let darkShadow = CALayer()
        let lightShadow = CALayer()
        
        lightShadow.frame = view.layer.bounds
        lightShadow.backgroundColor = view.backgroundColor?.cgColor
        lightShadow.shadowColor = UIColor.white.cgColor
        lightShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
        lightShadow.shadowOpacity = 1
        view.layer.insertSublayer(lightShadow, at: 0)

        darkShadow.frame = view.layer.bounds
        darkShadow.backgroundColor = view.backgroundColor?.cgColor
        darkShadow.shadowColor = UIColor.black.cgColor
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 1
        view.layer.insertSublayer(darkShadow, at: 1)
    }
    
    func setUpControlViews() {
        self.setupControls()
    }
    
    func clearPiecesAnimation(view: UIView) {
        
        UIView.animate(withDuration: 0.25) {
            
            let center = CGPoint(x: self.boardWidth / 2, y: self.boardHeight / 2)
            let translationX = center.x - view.center.x
            let translationY = center.y - view.center.y
            let transform = CGAffineTransform(translationX: translationX, y: translationY)
            
            view.transform = transform
            
        } completion: { (true) in
            print()
        }
    }
}




