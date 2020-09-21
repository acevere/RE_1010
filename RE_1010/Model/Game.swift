//
//  GameModel.swift
//  RE_1010
//
//  Created by Alice Ye on 2020-09-15.
//  Copyright © 2020 Alice Ye. All rights reserved.
//


import UIKit

class Game: NSObject {
    // Notification
    static var LineClearNotification = "LineClearNotification"
    static var GameOverNotification = "GameOverNotification"
    static var ScoreChangeNotification = "ScoreChangeNotification"
 
    var gameBoard: GameBoard!
    var gameOver: Bool = false
    var gameScore: Int = 0
    fileprivate var scores = [0, 10, 30, 60, 100]
    
    required init(_ gameBoard: GameBoard) {
        super.init()
        self.gameBoard = gameBoard
        self.initGame()
        
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(Game.lineClear(_:)),
                                                         name: NSNotification.Name(rawValue: Game.LineClearNotification),
                                                         object: nil)
    }
    
    deinit {
        debugPrint("deinit game")
    }
    
    func initGame() {
        //self.addGameStateChangeNotificationAction(#selector(Game.gameStateChange(_:)))
        self.gameBoard.setNeedsDisplay()
    }
    
    func deinitGame() {
        NotificationCenter.default.removeObserver(self)
        self.gameBoard = nil
    }

    func restartGame() {
        self.gameScore = 0
        self.gameOver = false
        self.gameBoard.clear()
    }
    
    
    @objc func lineClear(_ noti:Notification) {
        if let userInfo = noti.userInfo as? [String:NSNumber] {
            if let lineCount = userInfo["lineCount"] {
                //update game score
                self.gameScore += self.scores[lineCount.intValue]
                
                //post the updated score to view controller
                NotificationCenter.default.post(
                    name: Notification.Name(rawValue: Game.ScoreChangeNotification),
                    object: nil,
                    userInfo: ["score":String(self.gameScore)]
                )
            }
        }
    }
    
    func gameIsOver() -> Bool{
        
        var gameOver: Bool = false
        
        //check if any current tile can fit on board
        
        
        
        
        return gameOver
    }
    
}

