//
//  MenuView.swift
//  swipematter
//
//  Created by Jeffery Widroff on 1/16/23.
//

import UIKit

class MenuView: UIView, UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate {
  
    var tableView = UITableView()
    var model = Model()
    var levelNames = [String]()
    var levelNumber = Int()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, model: Model) {
        
        super.init(frame: frame)

        self.model = model
        backgroundColor = .cyan

        for name in model.levelModel.levelNames {
            
            levelNames.append(name)
        }
        
        tableView.frame = CGRect(x: 0, y: 40, width: self.frame.width, height: self.frame.height - 40)
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        addToolBar()
    }
    
    func addToolBar() {
        
        let toolBar = UIToolbar()
        toolBar.frame.size = CGSize(width: frame.width, height: 40.0)
        toolBar.clipsToBounds = true
        let doneButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(MenuView.dismissView))
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.barStyle = UIBarStyle.black
        toolBar.backgroundColor = UIColor.darkGray
        self.addSubview(toolBar)
    }
    
    @objc func dismissView() {
        removeFromSuperview()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levelNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = levelNames[indexPath.row]

        let rect = CGRect(x: 0, y: 0, width: cell.frame.height, height: cell.frame.height)

        if model.defaults.integer(forKey: "highestLevel") < indexPath.row {

            let lockView = LockView(frame: rect)
//            lockView.backgroundColor = .yellow
            cell.accessoryView = lockView
            cell.backgroundColor = UIColor.gray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if model.gameOver == true {
            model.gameOver = false
            return
        }
        
        if self.model.defaults.integer(forKey: "highestLevel") >= indexPath.row {
            
            self.model.level.number = indexPath.row
            self.model.resetGame()
            self.model.delegate?.removeViews()
            self.model.setUpGame()
            self.model.setUpControlsAndInstructions()
            self.model.updateLevelInfo()
            self.removeFromSuperview()
        }
    }
}


class LockView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let color1 = UIColor.black.cgColor
        let w = frame.width / 10 * 5
        let h = frame.height / 10 * 5
        let x = (frame.width - w) / 2
        let y = (frame.height - h) / 4 * 3
        let rect1 = CGRect(x: x, y: y, width: w, height: h)
        context.setFillColor(color1)
        context.addEllipse(in: rect1)
        context.fillEllipse(in: rect1)
        
        let color2 = UIColor.white.cgColor
        let w2 = frame.width / 10
        let h2 = frame.height / 10
        let x2 = (frame.width - w2) / 2
        let y2 = (frame.height - h2) / 4 * 3
        let rect2 = CGRect(x: x2, y: y2, width: w2, height: h2)
        context.setFillColor(color2)
        context.addEllipse(in: rect2)
        context.fillEllipse(in: rect2)
        
        
        
        
        
        let path = UIBezierPath()
        let topCenterPoint = CGPoint(x: frame.width / 2, y: 0)
        let leftCenterPoint = CGPoint(x: (frame.width - w) / 1.5, y: frame.height / 2)
        let rightCenterPoint = CGPoint(x: frame.width - ((frame.width - w) / 1.5), y: frame.height / 2)
        path.move(to: leftCenterPoint)
        path.addQuadCurve(to: rightCenterPoint, controlPoint: topCenterPoint)
        
        
        context.addPath(path.cgPath)
        context.setStrokeColor(color1)
        context.setLineWidth(frame.height / 15)
        context.strokePath()
    }
}






