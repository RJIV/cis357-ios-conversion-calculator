//
//  ViewController.swift
//  ConversionCalculator
//
//  Created by Hamilton, Robert on 9/16/19.
//  Copyright © 2019 Hamilton, Robert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fromValueTextField: UITextField!
    @IBOutlet weak var toValueTextField: UITextField!
    @IBOutlet weak var fromUnitLabel: UILabel!
    @IBOutlet weak var toUnitLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var calculatorMode: CalculatorMode = .Length
    
    var fromLengthUnit: LengthUnit = LengthUnit.Meters
    var toLengthUnit: LengthUnit = LengthUnit.Yards
    
    var fromVolumeUnit: VolumeUnit = VolumeUnit.Liters
    var toVolumeUnit: VolumeUnit = VolumeUnit.Gallons
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Length Conversion Calculator"
        
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        if fromValueTextField.text == "" && toValueTextField.text != "" {
            if let toValue = Double(toValueTextField.text!) {
                if calculatorMode == .Length {
                    fromValueTextField.text = String(lengthConversionTable[LengthConversionKey(toUnits: fromLengthUnit, fromUnits: toLengthUnit)]! * toValue)
                } else {
                    fromValueTextField.text = String(volumeConversionTable[VolumeConversionKey(toUnits: fromVolumeUnit, fromUnits: toVolumeUnit)]! * toValue)
                }
            }
        } else if fromValueTextField.text != "" {
            if let toValue = Double(fromValueTextField.text!) {
                if calculatorMode == .Length {
                    toValueTextField.text = String(lengthConversionTable[LengthConversionKey(toUnits: toLengthUnit, fromUnits: fromLengthUnit)]! * toValue)
                } else {
                    toValueTextField.text = String(volumeConversionTable[VolumeConversionKey(toUnits: toVolumeUnit, fromUnits: fromVolumeUnit)]! * toValue)
                }
            }
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        fromValueTextField.text = ""
        toValueTextField.text = ""
    }
    
    @IBAction func modeButtonTapped(_ sender: UIButton) {
        switch (calculatorMode) {
        case .Volume:
            calculatorMode = .Length
            fromUnitLabel.text = fromLengthUnit.rawValue
            toUnitLabel.text = toLengthUnit.rawValue
            fromValueTextField.placeholder = "Enter length in \(fromLengthUnit.rawValue)"
            toValueTextField.placeholder = "Enter length in \(toLengthUnit.rawValue)"
            self.title = "Length Conversion Calculator"
        case .Length:
            calculatorMode = .Volume
            fromUnitLabel.text = fromVolumeUnit.rawValue
            toUnitLabel.text = toVolumeUnit.rawValue
            fromValueTextField.placeholder = "Enter volume in \(fromVolumeUnit.rawValue)"
            toValueTextField.placeholder = "Enter volume in \(toVolumeUnit.rawValue)"
            self.title = "Volume Conversion Calculator"
        }
    }
}

