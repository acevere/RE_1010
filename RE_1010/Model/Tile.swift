//
//  Tile.swift
//  RE_1010
//
//  Created by Alice Ye on 2020-09-14.
//  Copyright © 2020 Alice Ye. All rights reserved.
//

import UIKit

enum TileType {
    case i(UIColor)
    case j(UIColor)
    case l(UIColor)
    case t(UIColor)
    case z(UIColor)
    case s(UIColor)
    case o(UIColor)
}

class Tile: UIView {
    
    var points = [CGPoint]()
    var color = UIColor.clear
    var tileType = Tile.tiles[0]
    
    
    //define tile type colors at start up
    static var tiles = [
        TileType.i(UIColor(red:0.40, green:0.64, blue:0.93, alpha:1.0)),
        TileType.j(UIColor(red:0.31, green:0.42, blue:0.80, alpha:1.0)),
        TileType.l(UIColor(red:0.81, green:0.47, blue:0.19, alpha:1.0)),
        TileType.t(UIColor(red:0.67, green:0.45, blue:0.78, alpha:1.0)),
        TileType.z(UIColor(red:0.80, green:0.31, blue:0.38, alpha:1.0)),
        TileType.s(UIColor(red:0.61, green:0.75, blue:0.31, alpha:1.0)),
        TileType.o(UIColor(red:0.88, green:0.69, blue:0.25, alpha:1.0))
    ]

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear
        randomTile()
        self.setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Tile obj must be initialized with tile type(color)
    func randomTile() {
        let index = Int.random(in: 0 ..< Tile.tiles.count)
        self.tileType = Tile.tiles[index]
        
        //define shape of the tiles
        switch tileType {
        case TileType.i(let color):
            self.color = color
            self.points.append(CGPoint(x: 0, y: 0))
            self.points.append(CGPoint(x: 0, y: 1))
            self.points.append(CGPoint(x: 0, y: 2))
            self.points.append(CGPoint(x: 0, y: 3))
        case TileType.j(let color):
            self.color = color
            self.points.append(CGPoint(x: 1, y: 0))
            self.points.append(CGPoint(x: 1, y: 1))
            self.points.append(CGPoint(x: 1, y: 2))
            self.points.append(CGPoint(x: 0, y: 2))
        case TileType.l(let color):
            self.color = color
            self.points.append(CGPoint(x: 0, y: 0))
            self.points.append(CGPoint(x: 0, y: 1))
            self.points.append(CGPoint(x: 0, y: 2))
            self.points.append(CGPoint(x: 1, y: 2))
        case TileType.t(let color):
            self.color = color
            self.points.append(CGPoint(x: 0, y: 0))
            self.points.append(CGPoint(x: 1, y: 0))
            self.points.append(CGPoint(x: 2, y: 0))
            self.points.append(CGPoint(x: 1, y: 1))
        case TileType.z(let color):
            self.color = color
            self.points.append(CGPoint(x: 1, y: 0))
            self.points.append(CGPoint(x: 0, y: 1))
            self.points.append(CGPoint(x: 1, y: 1))
            self.points.append(CGPoint(x: 0, y: 2))
        case TileType.s(let color):
            self.color = color
            self.points.append(CGPoint(x: 0, y: 0))
            self.points.append(CGPoint(x: 0, y: 1))
            self.points.append(CGPoint(x: 1, y: 1))
            self.points.append(CGPoint(x: 1, y: 2))
        case TileType.o(let color):
            self.color = color
            self.points.append(CGPoint(x: 0, y: 0))
            self.points.append(CGPoint(x: 0, y: 1))
            self.points.append(CGPoint(x: 1, y: 0))
            self.points.append(CGPoint(x: 1, y: 1))
        }
    }
    
    
    
    override func draw(_ rect: CGRect) {
        //draw tile at center of view
        let tileWidth = (self.right().x+1) * CGFloat(Constants.tileSize)
        let tileHeight = (self.bottom().y+1) * CGFloat(Constants.tileSize)
        let left = (rect.size.width - tileWidth)/2
        let top = (rect.size.height - tileHeight)/2
        
        for p in self.points {
            let r = Int(p.y)
            let c = Int(p.x)
            self.drawAt(top: top, left:left, row:r, col: c, color: self.color)
        }
    }
    
    func drawAt(top: CGFloat, left: CGFloat, row: Int, col: Int, color: UIColor) {
        let context = UIGraphicsGetCurrentContext()!
        let block = CGRect(
            x: left + CGFloat((col * Constants.gap) + (col * Constants.tileSize)),
            y: top + CGFloat((row * Constants.gap) + (row * Constants.tileSize)),
            width: CGFloat(Constants.tileSize),
            height: CGFloat(Constants.tileSize)
        )
        
        if color == UIColor.clear {
            Constants.strokeColor.set()
            context.fill(block)
        } else {
            color.set()
            UIBezierPath(roundedRect: block, cornerRadius: 1).fill()
        }
    }
    
    //tile values
    func left() -> CGPoint {
        var left = self.points[0]
        for p in self.points {
            if left.x > p.x {
                left = p
            }
        }
        return left
    }
    func right() -> CGPoint {
        var right = self.points[0]
        for p in self.points {
            if right.x < p.x {
                right = p
            }
        }
        return right
    }
    func bottom() -> CGPoint {
        var bottom = self.points[0]
        for p in self.points {
            if bottom.y < p.y {
                bottom = p
            }
        }
        return bottom
    }
    func top() -> CGPoint {
        var top = self.points[0]
        for p in self.points {
            if top.y > p.y {
                top = p
            }
        }
        return top
    }

}
