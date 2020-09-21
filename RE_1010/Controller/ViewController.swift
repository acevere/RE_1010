//
//  ViewController.swift
//  RE_1010
//
//  Created by Alice Ye on 2020-08-16.
//  Copyright © 2020 Alice Ye. All rights reserved.
//

import UIKit

class ViewController: UIViewController{


    @IBOutlet weak var gameScore: UIStackView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var block1: UIImageView!
    @IBOutlet weak var block2: UIImageView!
    @IBOutlet weak var block3: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var game: Game!
    var gameBoard = GameBoard(frame: CGRect.zero)
    
    var tiles = [Tile(), Tile(), Tile()]
    
    var numTilesLeft: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.sendSubviewToBack(contentView)

        
        gameBoard.translatesAutoresizingMaskIntoConstraints = false
        
        let panGesture1 = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
        let panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
        let panGesture3 = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
        
        block1.isUserInteractionEnabled = true
        block2.isUserInteractionEnabled = true
        block3.isUserInteractionEnabled = true
        block1.addGestureRecognizer(panGesture1)
        block2.addGestureRecognizer(panGesture2)
        block3.addGestureRecognizer(panGesture3)
        
        for tile in tiles{
            tile.translatesAutoresizingMaskIntoConstraints = false
            //tile.isUserInteractionEnabled = true
        }
    
        contentView.addSubview(gameBoard)
        block1.addSubview(tiles[0])
        block2.addSubview(tiles[1])
        block3.addSubview(tiles[2])
        
        let metrics = [
            "width":GameBoard.width,
            "height":GameBoard.height
        ]
        
        //layout gameBoard
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[gameBoard(width)]|", options: .alignAllCenterX, metrics: metrics, views: ["gameBoard": gameBoard]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[gameBoard(height)]|", options: .alignAllCenterX, metrics: metrics, views: ["gameBoard": gameBoard]))
        
        //layout tiles in blocks
        block1.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tile0(120)]|", options: .alignAllCenterX, metrics: nil, views: ["tile0": tiles[0]]))
        
        block1.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tile0(120)]|", options: .alignAllCenterX, metrics: nil, views: ["tile0": tiles[0]]))
        
        block2.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tile1(120)]|", options: .alignAllCenterX, metrics: nil, views: ["tile1": tiles[1]]))
        
        block2.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tile1(120)]|", options: .alignAllCenterX, metrics: nil, views: ["tile1": tiles[1]]))
        
        block3.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tile2(120)]|", options: .alignAllCenterX, metrics: nil, views: ["tile2": tiles[2]]))
        
        block3.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tile2(120)]|", options: .alignAllCenterX, metrics: nil, views: ["tile2": tiles[2]]))
    
        
        self.initializeGame(gameBoard)
        
    }

    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
       
        let translation = gesture.translation(in: view)

        guard let gestureView = gesture.view else {
          return
        }

        gestureView.center = CGPoint(
          x: gestureView.center.x + translation.x,
          y: gestureView.center.y + translation.y
        )

        gesture.setTranslation(.zero, in: view)
        
        tryPutTileOnGrid()
    }
    
    func initializeGame(_ gameBoard: GameBoard) {
        //initialize the game
        self.game = Game(self.gameBoard)
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(updateScore(_:)),
                                                         name: NSNotification.Name(rawValue: Game.ScoreChangeNotification),
                                                         object: nil)
    }
    
    @objc func updateScore(_ noti:Notification) {
        if let userInfo = noti.userInfo as? [String:String] {
            if let score = userInfo["score"] {
                //update game score
                self.scoreLabel.text = score
            }
        }
    }

    
    func tryPutTileOnGrid(){
        //check if tile on grid
        //if yes snap tile on grid
        
        if game.gameIsOver() {
            //generate pop up to restart game
            let alert = UIAlertController(title: "Game Over", message: "Your score was: \(self.game.gameScore).\n Restart Game?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Restart", style: .default){ (action) in
                self.game.restartGame()
            })


            self.present(alert, animated: true)
        }else{
            
        }
    }
    
}

