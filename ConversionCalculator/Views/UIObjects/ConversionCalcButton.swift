//
//  ConversionCalcButton.swift
//  ConversionCalculator
//
//  Created by Hamilton, Robert on 10/2/19.
//  Copyright © 2019 Hamilton, Robert. All rights reserved.
//

import UIKit

class ConversionCalcButton: UIButton {
    
    override func awakeFromNib() {
        self.backgroundColor = FOREGROUND_COLOR
        self.tintColor = BACKGROUND_COLOR
        self.layer.cornerRadius = 5
    }
    
}
