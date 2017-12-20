//
//  RoundButton.swift
//  SimpleTable
//
//  Created by Fang Liu Frank on 5/3/17.
//  Copyright © 2017 Fang Liu Frank. All rights reserved.
//

import UIKit
@IB

class RoundButton: UIButton {
    var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
   }
    var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
}
