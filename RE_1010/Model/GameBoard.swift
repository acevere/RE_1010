//
//  GameBoard.swift
//  RE_1010
//
//  Created by Alice Ye on 2020-09-14.
//  Copyright © 2020 Alice Ye. All rights reserved.
//


import UIKit

class GameBoard: UIView {
    
    let rows = Constants.row
    let cols = Constants.column
    let gap = Constants.gap
    // let tileSize = Int(UIScreen.main.bounds.size.width*(28/375.0))
    let tileSize = Constants.tileSize
    static let width  = (Constants.tileSize * Constants.column) + (Constants.gap * (Constants.column + 1))
    static let height = (Constants.tileSize * Constants.row) + (Constants.gap * (Constants.row + 1))
    
    var board = [[UIColor]]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.boardBackgroundColor
        self.clear()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func generateRow() -> [UIColor]! {
        var row = [UIColor]()
        for _ in 0 ..< cols {
            row.append(Constants.emptyColor)
        }
        return row
    }
    
    //check if line cleared
    //check if game over
    func update(){
        self.lineClear()
        //self.setNeedsDisplay()
    }
    
    func lineClear() {
        var lineCount = 0
        var linesToRemove = [Int]()
        
        //check if a line in board is full/colored
        for i in 0 ..< self.board.count {
            let row = self.board[i]
            let rows = row.filter { c -> Bool in
                return c != Constants.emptyColor
            }
            if rows.count == cols {
                linesToRemove.append(i)
                lineCount += 1
            }
        }
        
        //clear the line(s)
        for i in linesToRemove {
            for j in 0 ..< cols{
                self.board[i][j] = Constants.emptyColor
            }
        }
        
        //notify the system a line has been cleared
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Game.LineClearNotification),
            object: nil,
            userInfo: ["lineCount":NSNumber(value: lineCount as Int)]
        )
        
        self.setNeedsDisplay()
    }
    
    //called through setNeedsDisplay()
    override func draw(_ rect: CGRect) {
        // draw game board
        for r in  0 ..< rows {
            for c in 0 ..< cols {
                let color = self.board[r][c]
                self.drawAtRow(row: r, col: c, color: color)
            }
        }
    }

    
    func drawAtRow(row r: Int, col c: Int, color: UIColor!) {
        let context = UIGraphicsGetCurrentContext()
        let blk_x = CGFloat((c+1) * gap) + CGFloat(c * tileSize)
        let blk_y = CGFloat(((r+1) * gap) + (r * tileSize))
        let block = CGRect(x: blk_x,
                           y: blk_y,
                           width: CGFloat(tileSize),
                           height: CGFloat(tileSize))
        
        if color == Constants.emptyColor {
            Constants.strokeColor.set()
            context?.fill(block)
        } else {
            color.set()
            UIBezierPath(roundedRect: block, cornerRadius: 1).fill()
        }
    }
    
    func clear() {
        self.board = [[UIColor]]()
        for _ in 0 ..< rows {
            self.board.append(self.generateRow())
        }
        self.setNeedsDisplay()
    }

}
