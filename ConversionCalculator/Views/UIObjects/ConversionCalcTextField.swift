//
//  ConversionCalcTextField.swift
//  ConversionCalculator
//
//  Created by Hamilton, Robert on 10/2/19.
//  Copyright © 2019 Hamilton, Robert. All rights reserved.
//

import UIKit

class ConversionCalcTextField: DecimalMinusTextField {
    
    override func awakeFromNib() {
        self.textColor = FOREGROUND_COLOR
        self.tintColor = FOREGROUND_COLOR
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        self.layer.cornerRadius = 5.0
        self.borderStyle = .roundedRect
        
        guard let ph = self.placeholder else {
            return
        }
        
        self.attributedPlaceholder = NSAttributedString(string: ph, attributes: [NSAttributedString.Key.foregroundColor : FOREGROUND_COLOR])
    }
}
