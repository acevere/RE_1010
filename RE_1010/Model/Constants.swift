//
//  Constants.swift
//  RE_1010
//
//  Created by Alice Ye on 2020-08-16.
//  Copyright © 2020 Alice Ye. All rights reserved.
//

import UIKit

struct Constants {
    
    static let row = 12
    static let column = 12
    static let tileSize = 30
    static let gap = 1
    
    static let emptyColor = UIColor.black
    static let strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    static let boardBackgroundColor = UIColor(red:0.21, green:0.21, blue:0.21, alpha:1.0)
    static func GameFont(_ fontSize: CGFloat) -> UIFont! {
        return UIFont(name: "ChalkboardSE-Regular", size: fontSize)
    }
}
