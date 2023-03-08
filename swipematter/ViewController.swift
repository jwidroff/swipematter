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
//    var bannerView: GADBannerView!
    var instructionsShown = false
//    var nextView = NextView()
    
    var nextPiece = NextPiece()
    


    override func viewDidLoad() {
        
        super.viewDidLoad()
        addGradient()
        model = Model()
        model.delegate = self
        model.board.view.removeFromSuperview()
        model.setUpGame()
        model.setUpControlsAndInstructions()
        model.loadingMode = false
//        bannerView = GADBannerView(adSize: GADAdSizeBanner)
//        addBannerViewToView(bannerView)

    }
    
//    func addBannerViewToView(_ bannerView: GADBannerView) {
//        
//        
//
//        
//        view.addSubview(bannerView)
//
//        
//        view.addConstraints(
//            [NSLayoutConstraint(item: bannerView,
//                                attribute: .bottom,
//                                relatedBy: .equal,
//                                toItem: view.safeAreaLayoutGuide,
//                                attribute: .bottom,
//                                multiplier: 1,
//                                constant: 0),
//             NSLayoutConstraint(item: bannerView,
//                                attribute: .centerX,
//                                relatedBy: .equal,
//                                toItem: view,
//                                attribute: .centerX,
//                                multiplier: 1,
//                                constant: 0)
//            ])
//        
//        bannerView.rootViewController = self
////        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" //TEST ID
//        
//        
//        bannerView.adUnitID = "ca-app-pub-6501902393974573/9598962962"//REAL ID
//        
////        bannerView.backgroundColor = .red
//        bannerView.load(GADRequest())
//        
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//    }
    
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
        
//        let y = CGFloat()
//        let x = CGFloat()

        
//        if view.frame.height >= view.frame.width * 2 {
//            y = self.view.frame.midY - (boardHeight / 2) + (heightCushion / 4)
//        } else {
//            y = self.view.frame.midY - (boardHeight / 2)// + (heightCushion)
//        }
//
//        let x = self.view.frame.midX - (boardWidth / 2)
//        let frame = CGRect(x: x, y: y, width: boardWidth, height: boardHeight)
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
        
        print("POINTS!!!!! \(xArray), \(yArray)")
        
        
        boardView = BoardView(frame: CGRect(), xArray: xArray, yArray: yArray, iceLocations: model.board.iceLocations, holeLocations: model.board.holeLocations, colorTheme: board.colorTheme)
        self.model.board.view = boardView
        self.addSwipeGestureRecognizer(view: model.board.view)
        view.addSubview(self.model.board.view)
        
//        self.model.board.view.center = self.view.center
        
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
        
        
//        if view.frame.height >= view.frame.width * 2 {  //Narrow Phone
//
//            print("NARROW")
//
//            if board.heightSpaces >= board.widthSpaces * 2 {
//
//                heightCushion = self.view.frame.height / 3
//                boardHeight = self.view.frame.height - heightCushion
//
//                boardWidth = boardHeight / CGFloat(board.heightSpaces) * CGFloat(board.widthSpaces)
//
//                widthCushion = self.view.frame.width - boardWidth
//
//            } else {
//
//
////                widthCushion = self.view.frame.width / 10
//                boardWidth = self.view.frame.width - widthCushion
//                boardHeight = boardWidth / CGFloat(board.widthSpaces) * CGFloat(board.heightSpaces)
//
//                heightCushion = self.view.frame.height - boardHeight
//
//
//            }
//
//
//        } else { //Wide Phone
//
////            boardWidth = self.view.frame.width - widthCushion
////            boardHeight = boardWidth / CGFloat(board.widthSpaces) * CGFloat(board.heightSpaces)
//
//
//
//            if view.frame.height >= view.frame.width * 2 {
//
//                widthCushion = self.view.frame.width / 10
//                boardWidth = self.view.frame.width - widthCushion
//                boardHeight = boardWidth / CGFloat(board.widthSpaces) * CGFloat(board.heightSpaces)
//
//                heightCushion = self.view.frame.height - boardHeight
//
//
//            } else {
//
//                print("WIDE")
//
//
//                heightCushion = self.view.frame.height / 3
//                boardHeight = self.view.frame.height - heightCushion
//
//                boardWidth = boardHeight / CGFloat(board.heightSpaces) * CGFloat(board.widthSpaces)
//
//                widthCushion = self.view.frame.width - boardWidth
//
//            }
//
//
//
//        }
        
        pieceWidth = boardWidth / CGFloat(model.board.widthSpaces) / 10 * 9.5
        pieceHeight = boardHeight / CGFloat(model.board.heightSpaces) / 10 * 9.5
        distanceFromPieceCenter = (pieceWidth) / 2
    }
    
    func setupControls() {
        
        setupTopBar()
        setupRetryButton()
        setupMenuButton()
//        setupMovesLeftLabel()
//        setupLevelNameLabel()
//        self.setUpNextView()
    }
    
    func setupTopBar() {
        
//        let returnView = UIView()
//        topBarView.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.7, alpha: 1.0)
        topBarView.backgroundColor = ColorTheme.boardBackground
        
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBarView)
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(topBarView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(topBarView.topAnchor.constraint(equalTo: view.topAnchor))
        
        constraints.append(topBarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0))
//        constraints.append(topBarView.heightAnchor.constraint(equalToConstant: 300))
        
//        constraints.
        constraints.append(topBarView.bottomAnchor.constraint(equalTo: boardView.topAnchor, constant: -100.0))
        
//        constraints.append(topBarView.bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: boardView.topAnchor, multiplier: 0.0))
                           
        NSLayoutConstraint.activate(constraints)
        
//        topBarView.layer.cornerRadius = 20
        topBarView.layer.masksToBounds = false
        
//        topBarView.setNeedsLayout()
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
//        retryButton.layer.cornerRadius = retryButton.frame.height / 2
//        retryButton.backgroundColor = colorTheme.buttonColors
//        retryButton.setTitle("RETRY", for: .normal)
        retryButton.titleLabel?.adjustsFontSizeToFitWidth = true
        retryButton.setTitleColor(colorTheme.buttonTextColor, for: .normal)
        
        retryButton.setImage(UIImage(named: "restart"), for: .normal)
        
//        retryButton.backgroundColor = .yellow

        
        
        retryButton.addTarget(self, action: #selector(handleTap4Retry(sender:)), for: .touchUpInside)
        retryButton.showsTouchWhenHighlighted = true
        view.addSubview(retryButton)
        
//        retryButton.backgroundColor = .yellow
        
        retryButton.translatesAutoresizingMaskIntoConstraints = false
//        var constraints = [NSLayoutConstraint]()
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
        menuButton.showsTouchWhenHighlighted = true
        view.addSubview(menuButton)
        
        menuButton.translatesAutoresizingMaskIntoConstraints = false
//        var constraints = [NSLayoutConstraint]()
        var constraints = [NSLayoutConstraint]()

        constraints.append(menuButton.leadingAnchor.constraint(equalTo: topBarView.safeAreaLayoutGuide.leadingAnchor, constant: view.frame.width / 25))
        
        constraints.append(menuButton.bottomAnchor.constraint(equalTo: topBarView.safeAreaLayoutGuide.bottomAnchor))
        
        constraints.append(menuButton.widthAnchor.constraint(equalTo: topBarView.heightAnchor, multiplier: 0.5))
        constraints.append(menuButton.heightAnchor.constraint(equalTo: topBarView.heightAnchor, multiplier: 0.5))
        
        NSLayoutConstraint.activate(constraints)

    }
    
    func setupMovesLeftLabel() {

        
        
        
        
        
        movesLeftNumberLabel.backgroundColor = .clear
        movesLeftNumberLabel.textColor = .black

        movesLeftNumberLabel.textAlignment = .center
        movesLeftNumberLabel.font = UIFont.boldSystemFont(ofSize: 500)
        movesLeftNumberLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(movesLeftNumberLabel)
        
        var constraints = [NSLayoutConstraint]()


        movesLeftTextLabel.backgroundColor = .clear
        movesLeftTextLabel.textAlignment = .center
        movesLeftTextLabel.text = "MOVES LEFT"
//        movesLeftTextLabel.font = UIFont.boldSystemFont(ofSize: 500)
        movesLeftTextLabel.font = UIFont.systemFont(ofSize: 500)

        movesLeftTextLabel.textColor = .black

        
        movesLeftTextLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(movesLeftTextLabel)
        
        
        movesLeftNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(movesLeftNumberLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(movesLeftNumberLabel.bottomAnchor.constraint(equalTo: topBarView.bottomAnchor))
        constraints.append(movesLeftNumberLabel.heightAnchor.constraint(equalTo: topBarView.heightAnchor, multiplier: 0.3))
        constraints.append(movesLeftNumberLabel.widthAnchor.constraint(equalTo: topBarView.heightAnchor, multiplier: 0.3))
        
        
        
        movesLeftTextLabel.translatesAutoresizingMaskIntoConstraints = false
//        var constraints = [NSLayoutConstraint]()
        constraints.append(movesLeftTextLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        
        constraints.append(movesLeftTextLabel.bottomAnchor.constraint(equalTo: movesLeftNumberLabel.safeAreaLayoutGuide.topAnchor))
        
        constraints.append(movesLeftTextLabel.widthAnchor.constraint(equalTo: topBarView.widthAnchor, multiplier: 0.3))
        constraints.append(movesLeftTextLabel.heightAnchor.constraint(equalTo: topBarView.heightAnchor, multiplier: 0.2))
        
        
        NSLayoutConstraint.activate(constraints)

    }
    
    func setupLevelNameLabel() {
        
//        let controlHeight = pieceHeight / 2
//        let levelNameLabelHeight = controlHeight
//        let levelNameLabelWidth = boardWidth / 2
//        let levelNameYFloat = (model.board.view.frame.minY / 2)
//        let levelNameXFloat = model.board.view.frame.minX
//        let levelNameLabelFrame = CGRect(x: levelNameXFloat, y: levelNameYFloat, width: levelNameLabelWidth, height: levelNameLabelHeight)
//        levelNameLabel.frame = levelNameLabelFrame
//        levelNameLabel.backgroundColor = .clear
//        levelNameLabel.textAlignment = .left
//        levelNameLabel.baselineAdjustment = UIBaselineAdjustment.alignBaselines
//        levelNameLabel.numberOfLines = 0
//        levelNameLabel.font = UIFont.boldSystemFont(ofSize: 500)
////        levelNameLabel.sizeToFit()
//        levelNameLabel.adjustsFontSizeToFitWidth = true
//        levelNameLabel.text = "[LEVEL NAME]"
//        view.addSubview(levelNameLabel)
        
//        let controlHeight = pieceHeight / 2
//        let levelNameLabelHeight = controlHeight
//        let levelNameLabelWidth = boardWidth / 2
//        let levelNameYFloat = (model.board.view.frame.minY / 2)
//        let levelNameXFloat = model.board.view.frame.minX
//        let levelNameLabelFrame = CGRect(x: levelNameXFloat, y: levelNameYFloat, width: levelNameLabelWidth, height: levelNameLabelHeight)
//        levelNameLabel.frame = levelNameLabelFrame
        levelNameLabel.backgroundColor = .clear
        levelNameLabel.textAlignment = .left
        levelNameLabel.baselineAdjustment = UIBaselineAdjustment.alignBaselines
        levelNameLabel.numberOfLines = 0
        levelNameLabel.font = UIFont.boldSystemFont(ofSize: 500)
//        levelNameLabel.sizeToFit()
        levelNameLabel.adjustsFontSizeToFitWidth = true
        levelNameLabel.text = "[LEVEL NAME]"
        
        
        view.addSubview(levelNameLabel)
        
        levelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(levelNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
//        constraints.append(levelNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(levelNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5))
        constraints.append(levelNameLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.03))
        
//        constraints.append(levelNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(levelNameLabel.bottomAnchor.constraint(equalTo: boardView.topAnchor, constant: -10))
       
        
        
        NSLayoutConstraint.activate(constraints)
        
    }

    //MARK: Handle Functions
    
    
    
    
    @objc func handleSwipe(sender:UISwipeGestureRecognizer) {
        
//        let concurrentQueue = DispatchQueue.global()
//
//        concurrentQueue.async { [self] in
            
            if model.board.moves > 0 || model.infiniteMoves == true {
                
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
                
                let delayedTime = DispatchTime.now() + .milliseconds(Int(150))
                
                DispatchQueue.main.asyncAfter(deadline: delayedTime) {
                    
//                    self.model.check4AutoBallMove()
//                    self.model.check4GameOver()
                }
            }
//        }
    }
    
    @objc func handleTap(sender:UITapGestureRecognizer) {
        
        let pieceCenter = sender.view?.center
//        model.handleTap(center: pieceCenter!)
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
    
    //MARK: Ball functions
    
    func checkIfBallCanMove(direction: UISwipeGestureRecognizer.Direction, indexes: Indexes) -> Bool {
        
        var bool = Bool()

        switch direction {
            
        case .up:
            
            if model.board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
            }) {
                bool = true
            } else {
                bool = false
            }
            
        case .down:
            
            if model.board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
            }) {
                bool = true
            } else {
                bool = false
            }
            
        case .left:
            
            if model.board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
            }) {
                bool = true
            } else {
                bool = false
            }
            
        case .right:
            
            if model.board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
            }) {
                bool = true
            } else {
                bool = false
            }

        default:
            break
        }
        return bool
    }
    
//    func animateMove(ball: Ball, endSide: String) {
//
//        CATransaction.begin()
//
//        CATransaction.setCompletionBlock {
//
//            CATransaction.begin()
//
//            CATransaction.setCompletionBlock {
//
//                ball.path = UIBezierPath()
//
//                switch endSide {
//
//                case "top":
//
//                    self.model.moveBall(ball: ball, startSide: "bottom")
//
//                case "bottom":
//
//                    self.model.moveBall(ball: ball, startSide: "top")
//
//                case "left":
//
//                    self.model.moveBall(ball: ball, startSide: "right")
//
//                case "right":
//
//                    self.model.moveBall(ball: ball, startSide: "left")
//
//                default:
//
//                    break
//                }
//            }
//
//            ball.view.center = ball.center
//
//            CATransaction.commit()
//        }
//
//        setAnimation(ball: ball)
//
//        CATransaction.commit()
//    }
    
    func setAnimation(ball: Ball) {
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = ball.path.cgPath
        animation.repeatCount = 0
        animation.duration = duration4Animation
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        ball.view.layer.add(animation, forKey: "animate along path")
    }
}

extension ViewController: ModelDelegate {
    
    
    func setupInstructionsView(instructions: Instructions) {
        
        instructions.view.frame = CGRect(x: 0, y: 0, width: view.frame.width / 10 * 9, height: view.frame.height / 10 * 8)
        instructions.view.center = view.center
        view.addSubview(instructions.view)
        
        
        
        
        //MARK: Need to make this work by making sure that the sizes are correct.
        //model.setUpGame()
        
        
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
    
    func addTapGestureRecognizer(view: UIView) {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    
    func updateMovesLeftLabel(moves: String) {
        
        movesLeftNumberLabel.text = "\(moves)"
        
        if moves == "0" {
        
            movesLeftNumberLabel.font = UIFont.boldSystemFont(ofSize: movesLeftNumberLabel.font.pointSize)
            movesLeftNumberLabel.textColor = UIColor.red
            movesLeftNumberLabel.backgroundColor = .yellow.withAlphaComponent(0.5)
        
        } else if Int(moves) ?? 0 >= model.board.moves / 2 && Int(moves) ?? 0 <= 3 {
            
            if moves != "∞" {
                movesLeftNumberLabel.font = UIFont.boldSystemFont(ofSize: movesLeftNumberLabel.font.pointSize)
                movesLeftNumberLabel.textColor = UIColor.purple
                movesLeftNumberLabel.backgroundColor = .yellow.withAlphaComponent(0.2)
            }
        }
    }
    
    func updateLevelInfo(name: String, moves: String) {
        
        levelNameLabel.text = name.uppercased()
        
        var movesX = String()
        
        if moves == "0" {
            
            movesX = "∞"
            model.infiniteMoves = true
        } else {
            
            movesX = moves
            model.infiniteMoves = false
        }
        
        movesLeftNumberLabel.text = "\(movesX)"
    }
    
    func changeAnimationSpeed(slowerOrFaster: String) {
        
        switch slowerOrFaster {
        
        case "faster":
            
            if duration4Animation > 0.02 {
                
                duration4Animation -= 0.02
            }
                        
        case "slower":
            
            duration4Animation = 0.10
            
        default:
            break
        }
    }
    
//    func changeViewColor(piece: Piece, ball: Ball) {
//
//        var backgroundColor = UIColor.clear
//
//        if ball.loopedIndexes[piece.indexes] == 1 {
//
//            backgroundColor = UIColor.orange
//
//        } else if ball.loopedIndexes[piece.indexes] == 2 {
//
//            backgroundColor = UIColor.red
//
//        } else if ball.loopedIndexes[piece.indexes] == 3 {
//
//            backgroundColor = UIColor.purple
//
//        } else if ball.loopedIndexes[piece.indexes] == 4 {
//
//            backgroundColor = UIColor.systemIndigo
//        } else if ball.loopedIndexes[piece.indexes] == 5 {
//
//            backgroundColor = UIColor.orange
//        } else if ball.loopedIndexes[piece.indexes] == 6 {
//
//            backgroundColor = UIColor.red
//        } else if ball.loopedIndexes[piece.indexes] == 7 {
//
//            backgroundColor = UIColor.purple
//        } else if ball.loopedIndexes[piece.indexes] == 8 {
//
//            backgroundColor = UIColor.systemIndigo
//        } else if ball.loopedIndexes[piece.indexes] == 9 {
//
//            backgroundColor = UIColor.orange
//        } else if ball.loopedIndexes[piece.indexes] == 10 {
//
//            backgroundColor = UIColor.systemIndigo
//        }
//
//        piece.view.backgroundColor = backgroundColor
//
//        let delayedTime = DispatchTime.now() + .milliseconds(Int(250))
//
//        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//            piece.view.backgroundColor = .clear
//        }
//    }
    
    func replacePieceView(piece: Piece) {
        
        if self.model.board.pieces.contains(where: { (pieceX) -> Bool in
            pieceX.indexes == piece.indexes
        }) {
            
            var radianDegrees: CGFloat = 0
            
//            print("View rotations are \(piece.view.rotations)")
            
            switch piece.view.rotations {
                
            case 0:
                radianDegrees = 90
                piece.view.rotations += 1
            case 1:
                radianDegrees = 180
                piece.view.rotations += 1
            case 2:
                radianDegrees = 270
                piece.view.rotations += 1
            case 3:
                radianDegrees = 360
                piece.view.rotations = 0
                
            default:
                break
            }
            
//            rotateView(piece: piece, rotationDegrees: radianDegrees)
        }
    }
    
//    func rotateView(piece: Piece, rotationDegrees: CGFloat) {
//
//        let rotationAngle = CGFloat(rotationDegrees * Double.pi / 180.0)
//        let cornerRadius: CGFloat = piece.view.frame.width / 2
//        let shadowRadius: CGFloat = 1
//
//        UIView.animate(withDuration: 0.10, delay: 0.0, options: .curveEaseIn) {
//
//            piece.view.transform = CGAffineTransform.init(rotationAngle: rotationAngle)
//
//            if piece.shape == .pieceMaker {
//
//                self.view.bringSubviewToFront(piece.nextPiece!.view.subviews[0])
////
////                var t = CGAffineTransform.identity
////                t.rotated(by: -rotationDegrees * Double.pi / 180.0)
////                t.scaledBy(x: 0.5, y: 0.5)
////
////                piece.view.subviews[0].subviews[0].transform = t
//
////                piece.view.subviews[0].subviews[0].transform = CGAffineTransform(scaleX: 0.5, y: 0.5).rotated(by: -rotationDegrees * Double.pi / 180.0)
//
//
//
////                piece.view.subviews[0].subviews[0].transform = CGAffineTransform.init(rotationAngle: -rotationDegrees * Double.pi / 180.0)
//
//
//
//            }
//
//            switch rotationDegrees {
//
//            case 90:
//
//                if let sublayers = piece.view.layer.sublayers {
//
//                    sublayers[0].frame = piece.view.layer.bounds
//                    sublayers[0].backgroundColor = ColorTheme.boardBackground.cgColor
//                    sublayers[0].shadowColor = UIColor.black.cgColor
//                    sublayers[0].cornerRadius = cornerRadius
//                    sublayers[0].shadowOffset = CGSize(width: shadowRadius, height: -shadowRadius)
//                    sublayers[0].shadowOpacity = 1
//                    sublayers[0].shadowRadius = shadowRadius
//
//                    sublayers[1].frame = piece.view.layer.bounds
//                    sublayers[1].backgroundColor = ColorTheme.boardBackground.cgColor
//                    sublayers[1].shadowColor = UIColor.white.cgColor
//                    sublayers[1].cornerRadius = cornerRadius
//                    sublayers[1].shadowOffset = CGSize(width: -shadowRadius, height: shadowRadius)
//                    sublayers[1].shadowOpacity = 1
//                    sublayers[1].shadowRadius = shadowRadius
//                }
//
//            case 180:
//
//                if let sublayers = piece.view.layer.sublayers {
//
//                    sublayers[0].frame = piece.view.layer.bounds
//                    sublayers[0].backgroundColor = ColorTheme.boardBackground.cgColor
//                    sublayers[0].shadowColor = UIColor.black.cgColor
//                    sublayers[0].cornerRadius = cornerRadius
//                    sublayers[0].shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
//                    sublayers[0].shadowOpacity = 1
//                    sublayers[0].shadowRadius = shadowRadius
//
//                    sublayers[1].frame = piece.view.layer.bounds
//                    sublayers[1].backgroundColor = ColorTheme.boardBackground.cgColor
//                    sublayers[1].shadowColor = UIColor.white.cgColor
//                    sublayers[1].cornerRadius = cornerRadius
//                    sublayers[1].shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
//                    sublayers[1].shadowOpacity = 1
//                    sublayers[1].shadowRadius = shadowRadius
//                }
//
//            case 270:
//
//                if let sublayers = piece.view.layer.sublayers {
//
//                    sublayers[0].frame = piece.view.layer.bounds
//                    sublayers[0].backgroundColor = ColorTheme.boardBackground.cgColor
//                    sublayers[0].shadowColor = UIColor.black.cgColor
//                    sublayers[0].cornerRadius = cornerRadius
//                    sublayers[0].shadowOffset = CGSize(width: -shadowRadius, height: shadowRadius)
//                    sublayers[0].shadowOpacity = 1
//                    sublayers[0].shadowRadius = shadowRadius
//
//                    sublayers[1].frame = piece.view.layer.bounds
//                    sublayers[1].backgroundColor = ColorTheme.boardBackground.cgColor
//                    sublayers[1].shadowColor = UIColor.white.cgColor
//                    sublayers[1].cornerRadius = cornerRadius
//                    sublayers[1].shadowOffset = CGSize(width: shadowRadius, height: -shadowRadius)
//                    sublayers[1].shadowOpacity = 1
//                    sublayers[1].shadowRadius = shadowRadius
//                }
//
//            case 360:
//
//                if let sublayers = piece.view.layer.sublayers {
//
//                    sublayers[0].frame = piece.view.layer.bounds
//                    sublayers[0].backgroundColor = ColorTheme.boardBackground.cgColor
//                    sublayers[0].shadowColor = UIColor.black.cgColor
//                    sublayers[0].cornerRadius = cornerRadius
//                    sublayers[0].shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
//                    sublayers[0].shadowOpacity = 1
//                    sublayers[0].shadowRadius = shadowRadius
//
//                    sublayers[1].frame = piece.view.layer.bounds
//                    sublayers[1].backgroundColor = ColorTheme.boardBackground.cgColor
//                    sublayers[1].shadowColor = UIColor.white.cgColor
//                    sublayers[1].cornerRadius = cornerRadius
//                    sublayers[1].shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
//                    sublayers[1].shadowOpacity = 1
//                    sublayers[1].shadowRadius = shadowRadius
//                }
//
//            default:
//
//                break
//            }
//
//        } completion: { (true) in
//
//            if (piece.shape == .cross && (piece.version == 1 || piece.version == 3)) || (piece.shape == .doubleElbow && (piece.version == 1 || piece.version == 5))  {
//
//                self.switchCrissCross(piece: piece)
//            }
//        }
//    }
    
    func switchCrissCross(piece: Piece) {
        
        for view in piece.view.subviews{
            view.backgroundColor = .white
        }
        
        
//        let delayedTime = DispatchTime.now() + .milliseconds(Int(250))

//        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
            
        let newView = ShapeView(frame: piece.view.frame, piece: piece, groups: nil)
            self.addTapGestureRecognizer(view: newView)
            self.boardView.addSubview(newView)
            let oldView = piece.view
            piece.view = newView
            oldView.removeFromSuperview()
//        }
    }
    
    func crashBallViewIntoCross(piece: Piece, ball: Ball) {
        
        let yAxisIsAligned:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) == ball.center.y
        let xAxisIsAligned:Bool = piece.view.frame.minX + (piece.view.frame.width / 2) == ball.center.x
        let ballIsLowerTanPieceCenter:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) < ball.center.y
        let ballIsHigherThanPieceCenter:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) > ball.center.y
        let ballIsRightOfPieceCenter = piece.view.frame.minX + (piece.view.frame.width / 2) < ball.center.x
        let ballIsLeftOfPieceCenter = piece.view.frame.minX + (piece.view.frame.width / 2) > ball.center.x
        var startPoint = CGPoint()
        var endPoint = CGPoint()

        if xAxisIsAligned && ballIsLowerTanPieceCenter {
            
            //Moves the piece up
             startPoint = CGPoint(x: ball.center.x, y: ball.center.y - (self.pieceWidth / 2))
             endPoint = CGPoint(x: ball.center.x, y: ball.center.y - (self.pieceHeight / 3))
            
        } else if xAxisIsAligned && ballIsHigherThanPieceCenter {
            
            //Moves the piece down
             startPoint = CGPoint(x: ball.center.x, y: ball.center.y + (self.pieceWidth / 2))
             endPoint = CGPoint(x: ball.center.x, y: ball.center.y + (self.pieceHeight / 3))
            
        } else if yAxisIsAligned && ballIsRightOfPieceCenter {
            
            //Moves the piece left
             startPoint = CGPoint(x: ball.center.x - (self.pieceWidth / 2), y: ball.center.y)
             endPoint = CGPoint(x: ball.center.x - (self.pieceWidth / 3), y: ball.center.y)
            
        } else if yAxisIsAligned && ballIsLeftOfPieceCenter {
            
            //Moves the ball right
             startPoint = CGPoint(x: ball.center.x + (self.pieceWidth / 2), y: ball.center.y)
             endPoint = CGPoint(x: ball.center.x + (self.pieceWidth / 3), y: ball.center.y)
        }
        
        UIView.animate(withDuration: 0.125) {
            
            let transform = CGAffineTransform(translationX: (startPoint.x - endPoint.x) * 2, y: (startPoint.y - endPoint.y) * 2)
            ball.view.transform = transform
            
        } completion: { (true) in
            print()
        }
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
    
    
//    func removeHole(piece: Piece) {
//        
// 
//        
//        let x = (self.model.board.grid[piece.indexes]?.x)! //- self.pieceWidth / 2
//        
//        let y = (self.model.board.grid[piece.indexes]?.y)! //- self.pieceHeight / 2
//                    
//        let newView = UIView(frame: CGRect(x: x - ((self.pieceWidth / 9 * 10) / 2), y: y - ((self.pieceHeight / 9 * 10) / 2), width: pieceWidth / 9 * 10, height: pieceHeight / 9 * 10))
//                    
//        newView.backgroundColor = ColorTheme.boardBackground
//        
//        
//        let shadowRadius: CGFloat = 1
//        let darkShadow = CALayer()
//
//
//        darkShadow.frame = newView.bounds
//        darkShadow.backgroundColor = ColorTheme.boardBackground.cgColor
//        darkShadow.shadowColor = UIColor.black.cgColor
//        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
//        darkShadow.shadowOpacity = 1
////        darkShadow.cornerRadius = 5
//        newView.layer.insertSublayer(darkShadow, at: 1)
//        
//        
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) {
//            self.removeView(view: piece.view)
//            
//            self.model.board.view.addSubview(newView)
//            
//            let scale = CGAffineTransform(scaleX: 0.01, y: 0.01)
//            
//
//            newView.transform = scale
//            
//        } completion: { (true) in
//            
//            UIView.animate(withDuration: 0.25) {
//                
//                
//                let scale2 = CGAffineTransform(scaleX: 1, y: 1)
//                
//
//                newView.transform = scale2
//                
//               
//                
//                self.model.board.view.sendSubviewToBack(newView)
//            }
//            
//            
//            
//        }
//
//        
//        
//        
//    }
    
    
    
//    func removeHole(indexes: Indexes) { //MARK: UP TO HERE. NEED TO FIX THIS
//
//        for subview in model.board.view.subviews {
//
//            let centerX = self.model.board.grid[indexes]
//            let pieceCenter = CGPoint(x: centerX!.x.rounded(), y: centerX!.y.rounded())
//
//            let subviewCenter = CGPoint(x: subview.center.x.rounded(), y: subview.center.y.rounded())
//
//            if subviewCenter  == pieceCenter {
//                let piece = self.model.getPieceInfo(index: indexes, pieces: model.board.pieces)
//                self.removeView(view: subview)
//                self.removeView(view: piece!.view)
//                self.model.deletePiece(piece: piece!)
//
//                return
//            }
//        }
//    }
    
    func resetPieceMakerView(piece: Piece) {
 
        let w = piece.view.frame.width// / 2
        let h = piece.view.frame.height// / 2
        let x = piece.view.center.x
        let y = piece.view.center.y
        let frame = CGRect(x: x, y: y, width: w, height: h)
        let nextPieceView = ShapeView(frame: frame, piece: piece.nextPiece!, groups: nil)
        
        nextPieceView.center = CGPoint(x: x, y: y)
        addTapGestureRecognizer(view: nextPieceView)
        
        self.boardView.addSubview(nextPieceView)
        
        
        piece.nextPiece?.view = nextPieceView
        
        
        
        let scale2 = CGAffineTransform(scaleX: 0.5, y: 0.5)
        piece.nextPiece!.view.transform = scale2

        
        
    }
    
    func addPieceView(piece: Piece) {
        
        if let indexes = piece.indexes {
            
            
            piece.center = self.model.board.grid[indexes]!
            piece.view.center = piece.center
            
//            if piece.shape != .pieceMaker {
                
                addTapGestureRecognizer(view: piece.view)
//            }
            
            UIView.animate(withDuration: 0.25) {
    //            let rect = CGRect(x: piece.view.frame.minX, y: piece.view.frame.minY, width: self.pieceWidth, height: self.pieceHeight)
    //            piece.view.frame = rect
                self.model.board.view.addSubview(piece.view)
            }
            
        }
        
        
        
    }

    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String) {
                
        model.board.view.gestureRecognizers?.removeAll()
        
        var beginPoint = CGPoint()
        var endPoint = CGPoint()
        var controlPoint = CGPoint()
        self.model.board.view.bringSubviewToFront(ball.view)
        
        switch startSide {
        
        case "center":
            
            if endSide == "left" {
                
                endPoint = CGPoint(x: piece.center.x - self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
                
            } else if endSide == "right" {
                
                endPoint = CGPoint(x: piece.center.x + self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
                
            } else if endSide == "top"{
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
                
            } else if endSide == "bottom" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            }
            
            beginPoint = ball.center
            
        case "top":
            
            if endSide == "left" {
                
                endPoint = CGPoint(x: piece.center.x - self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
                
            } else if endSide == "right" {
                
                endPoint = CGPoint(x: piece.center.x + self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
                
            } else if endSide == "bottom" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
                
            } else if endSide == "center" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = ball.center
            
        case "bottom":
            
            if endSide == "left" {
                
                endPoint = CGPoint(x: piece.center.x - self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
                
            } else if endSide == "right" {
                
                endPoint = CGPoint(x: piece.center.x + self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
                
            } else if endSide == "top" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
                
            } else if endSide == "center" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = ball.center
            
        case "left":
            
            if endSide == "bottom" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
                
            } else if endSide == "top" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
                
            } else if endSide == "right" {
                
                endPoint = CGPoint(x: piece.center.x + self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
                
            } else if endSide == "center" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = ball.center
            
        case "right":
                        
            if endSide == "bottom" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
                
            } else if endSide == "top" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
                
            } else if endSide == "left" {
                
                endPoint = CGPoint(x: piece.center.x - self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
                
            } else if endSide == "center" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = ball.center
            
        default:
            break
        }
        
        controlPoint = piece.center
        ball.path.move(to: CGPoint(x: beginPoint.x, y: beginPoint.y))
        ball.path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        ball.center = endPoint
//        animateMove(ball: ball, endSide: endSide)
    }
    
    func movePieceView(piece: Piece) {

        
        if let indexes = piece.indexes {
            
            
            
            if indexes.x! < 0 {
                
                UIView.animate(withDuration: 0.25) {
                    piece.center = CGPoint(x: piece.center.x - (self.distanceFromPieceCenter * 2), y: piece.center.y)
                    piece.view.center = piece.center
                }
                
//                self.model.deletePiece(piece: piece)
                
            } else if indexes.x! > self.model.board.widthSpaces - 1 {
                
                UIView.animate(withDuration: 0.25) {
                    piece.center = CGPoint(x: piece.center.x + (self.distanceFromPieceCenter * 2), y: piece.center.y)
                    piece.view.center = piece.center

                }
                
//                self.model.deletePiece(piece: piece)
                
            } else if indexes.y! < 0 {
                
                UIView.animate(withDuration: 0.25) {
                    piece.center = CGPoint(x: piece.center.x, y: piece.center.y - (self.distanceFromPieceCenter * 2))
                    piece.view.center = piece.center

                }
                
//                self.model.deletePiece(piece: piece)
                
            } else if indexes.y! > self.model.board.heightSpaces - 1 {
                
                UIView.animate(withDuration: 0.25) {
                    piece.center = CGPoint(x: piece.center.x, y: piece.center.y + (self.distanceFromPieceCenter * 2))
                    piece.view.center = piece.center

                }
                
//                self.model.deletePiece(piece: piece)
                
            } else {
                
                //Piece is on the board and therefore execute move regularly
                UIView.animate(withDuration: 0.25) {
                    piece.center = self.model.board.grid[indexes]!
                    piece.view.center = piece.center
                    
                    for ball in self.model.board.balls {
                        if ball.indexes == piece.indexes {
                            
                            ball.view.center = self.model.board.grid[ball.indexes]!
                        }
                    }
                }
            }
            
//            if piece.shape == .entrance {
//
//                for ball in model.board.balls {
//
//                    if ball.indexes == piece.indexes {
//
//                        UIView.animate(withDuration: 0.25) {
//
//                            ball.center = piece.center
//                            ball.view.center = ball.center
//
//                            self.model.deleteBall(ball: ball)
//
//                        } completion: { (true) in
//                            print()
//                        }
//                    }
//                }
//            }
            
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
                        
//                        print(group.pieces.map({$0.indexes}))
                        
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
                    self.addTapGestureRecognizer(view: piece.view)
                    self.model.board.view.addSubview(piece.view)
                }
                
                
            } completion: { (true) in
                
//                if piece.shape == .entrance {
//                    self.setUpBallView(piece: piece)
//
//                }
//                if piece.shape == .pieceMaker {
//                    self.resetPieceMakerView(piece: piece)
//                }
            }
        }
    }
    
    
    
    func setUpBallView(piece: Piece) {
        
        for ball in self.model.board.balls {
            
            if ball.indexes == piece.indexes {
                
                
                let frame = CGRect(x: piece.view.center.x, y: piece.view.center.y, width: pieceWidth, height: pieceHeight)
                ball.view = BallView(frame: frame)
                ball.center = CGPoint(x: model.board.grid[ball.indexes]?.x ?? ball.view.center.x, y: model.board.grid[ball.indexes]?.y ?? ball.view.center.y)
                ball.view.center = ball.center
                addTapGestureRecognizer(view: ball.view)
                self.model.board.view.addSubview(ball.view)
                view.bringSubviewToFront(ball.view)
            }
        }
    }
    
    func disableGestureRecognizers() {
        
        disableSwipes()
        disableTaps()
    }
    
    func disableSwipes() {
        model.board.view.gestureRecognizers?.removeAll()
    }
    
    func disableTaps() {
        
        for piece in model.board.pieces {
            
            piece.view.gestureRecognizers?.removeAll()
            
        }
    }
    
    
    func runPopUpView(title: String, message: String) {
                
        //MARK: Need to remove gesture Recognizers here
        
        if title == "YOU LOSE" {
            
            
            disableGestureRecognizers()
        }
        
        if model.gameOver == true {
            
            model.gameOver = false
            return
        }
        
        
        
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
                        
                        self.model.gameOver = false
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
        self.movesLeftNumberLabel.removeFromSuperview()
        self.movesLeftTextLabel.removeFromSuperview()
//        self.model.setUpGame()
    }
    
    func setUpGameViews(board: Board) {
                
        self.setSizes(board: board)
        self.setupGrid()
        self.setupBoard(board: board)
        
    }
    
    
    
    
    
    
    func setUpNextView(nextPiece: Piece) {
        
        
        
        
        
        
        
        
        
//        self.nextPiece = nextPiece
//        let controlHeight = retryButton.frame.height
        
        let nextViewHeight = pieceHeight
        let nextViewWidth = pieceWidth
        let nextViewYFloat = topBarView.frame.height / 2
        let nextViewXFloat = view.center.x - (nextViewWidth / 2)
        
//        let nextViewHeight = topBarView.frame.height / 2
//        let nextViewWidth = nextViewHeight
//        let nextViewYFloat = topBarView.frame.height / 2
//        let nextViewXFloat = view.center.x - (nextViewWidth / 2)
        
        
        
//        let width = 150.0
//        let height = width
//        let y = 0.0
//        let x = view.frame.midX - (width / 2)
        
        let frame = CGRect(x: nextViewXFloat, y: nextViewYFloat, width: nextViewWidth, height: nextViewHeight)
        
        
        
//        let nextView = NextView(frame: frame)
        
        let nextView = ShapeView(frame: frame, piece: nextPiece, groups: nil)
        
        print("FRAME \(nextView.frame)")
        
        //MARK: CHANGE THIS
        
        
        
//        nextView.center = CGPoint(x: view.center.x, y: y)
        view.addSubview(nextView)
        
        makeSoft(view: nextView)
        
        
        
        
//        for piece in self.nextPiece.pieces {
            
            
//            setNextPieceView(nextView: nextView, nextPiece: piece)
//        }
        
        
        
//
//        var constraints = [NSLayoutConstraint]()
//
//        constraints.append(nextView.trailingAnchor.constraint(equalTo: topBarView.safeAreaLayoutGuide.trailingAnchor, constant: -view.frame.width / 25))
//
//        constraints.append(nextView.bottomAnchor.constraint(equalTo: topBarView.safeAreaLayoutGuide.bottomAnchor))
//
//        constraints.append(nextView.widthAnchor.constraint(equalTo: topBarView.heightAnchor, multiplier: 0.5))
//        constraints.append(nextView.heightAnchor.constraint(equalTo: topBarView.heightAnchor, multiplier: 0.5))
//
//        NSLayoutConstraint.activate(constraints)
        
        
        
    }
    
    private func makeSoft(view: UIView) {
        
//        view.backgroundColor = view.backgroundColor
        let shadowRadius: CGFloat = 1
        let darkShadow = CALayer()
        let lightShadow = CALayer()
        
        lightShadow.frame = view.layer.bounds
        lightShadow.backgroundColor = view.backgroundColor?.cgColor
        lightShadow.shadowColor = UIColor.white.cgColor
        lightShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
        lightShadow.shadowOpacity = 1
//        lightShadow.cornerRadius = 5
        view.layer.insertSublayer(lightShadow, at: 0)

        darkShadow.frame = view.layer.bounds
        darkShadow.backgroundColor = view.backgroundColor?.cgColor
        darkShadow.shadowColor = UIColor.black.cgColor
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 1
//        darkShadow.cornerRadius = 5
        view.layer.insertSublayer(darkShadow, at: 1)
    }
    
    func setNextPieceView(nextView: NextView, nextPiece: Piece) {
        
        if let indexes = nextPiece.indexes {
            
            let grid = nextView.grid.dictionary
            let x = (grid[indexes]!.x) - (nextView.frame.width / 8)
            let y = (grid[indexes]!.y) - (nextView.frame.height / 8)
            let width = nextView.frame.width / 4
            let height = width
            
            let frame = CGRect(x: x, y: y, width: width, height: height)
            
            
            
            
            
            let viewX = ShapeView(frame: frame, piece: nextPiece, groups: nil)
                    
            nextView.addSubview(viewX)
           
            
            
    //        viewX.subviews[0].layer.backgroundColor = UIColor.white.cgColor
            viewX.subviews[0].backgroundColor = UIColor.blue
            
            
            
            
            
    //        viewX.layer.sublayers![1].backgroundColor = UIColor.white.cgColor
    //        viewX.layer.sublayers![0].backgroundColor = UIColor.white.cgColor
            
            
            
        }
        

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




