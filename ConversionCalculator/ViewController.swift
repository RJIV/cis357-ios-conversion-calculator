//
//  ViewController.swift
//  ConversionCalculator
//
//  Created by Hamilton, Robert on 9/16/19.
//  Copyright © 2019 Hamilton, Robert. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, SettingsViewControllerDelegate {
    
    @IBOutlet weak var fromValueTextField: UITextField!
    @IBOutlet weak var toValueTextField: UITextField!
    @IBOutlet weak var fromUnitLabel: UILabel!
    @IBOutlet weak var toUnitLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var calculatorMode: CalculatorMode = .Length
    
    var fromLengthUnits: LengthUnit = LengthUnit.Meters
    var toLengthUnits: LengthUnit = LengthUnit.Yards
    
    var fromVolumeUnits: VolumeUnit = VolumeUnit.Liters
    var toVolumeUnits: VolumeUnit = VolumeUnit.Gallons
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Length Conversion Calculator"
        
        fromValueTextField.delegate = self
        toValueTextField.delegate = self
        
        refreshUnitLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "changeSettingsSegue":
            if let dest = segue.destination as? SettingsViewController {
                dest.settingsViewControllerDelegate = self
                dest.calculatorMode = calculatorMode
                dest.fromLengthUnits = fromLengthUnits
                dest.toLengthUnits = toLengthUnits
                dest.fromVolumeUnits = fromVolumeUnits
                dest.toVolumeUnits = toVolumeUnits
            }
        default:
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit) {
        fromLengthUnits = fromUnits
        toLengthUnits = toUnits
        refreshUnitLabels()
    }
    
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit) {
        fromVolumeUnits = fromUnits
        toVolumeUnits = toUnits
        refreshUnitLabels()
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        if fromValueTextField.text == "" && toValueTextField.text != "" {
            if let toValue = Double(toValueTextField.text!) {
                if calculatorMode == .Length {
                    fromValueTextField.text = String(lengthConversionTable[LengthConversionKey(toUnits: fromLengthUnits, fromUnits: toLengthUnits)]! * toValue)
                } else {
                    fromValueTextField.text = String(volumeConversionTable[VolumeConversionKey(toUnits: fromVolumeUnits, fromUnits: toVolumeUnits)]! * toValue)
                }
            }
        } else if fromValueTextField.text != "" {
            if let toValue = Double(fromValueTextField.text!) {
                if calculatorMode == .Length {
                    toValueTextField.text = String(lengthConversionTable[LengthConversionKey(toUnits: toLengthUnits, fromUnits: fromLengthUnits)]! * toValue)
                } else {
                    toValueTextField.text = String(volumeConversionTable[VolumeConversionKey(toUnits: toVolumeUnits, fromUnits: fromVolumeUnits)]! * toValue)
                }
            }
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        fromValueTextField.text = ""
        toValueTextField.text = ""
    }
    
    @IBAction func modeButtonTapped(_ sender: UIButton) {
        switch calculatorMode {
        case .Volume:
            calculatorMode = .Length
            fromValueTextField.placeholder = "Enter length in \(fromLengthUnits.rawValue)"
            toValueTextField.placeholder = "Enter length in \(toLengthUnits.rawValue)"
            self.title = "Length Conversion Calculator"
        case .Length:
            calculatorMode = .Volume
            fromValueTextField.placeholder = "Enter volume in \(fromVolumeUnits.rawValue)"
            toValueTextField.placeholder = "Enter volume in \(toVolumeUnits.rawValue)"
            self.title = "Volume Conversion Calculator"
        }
        refreshUnitLabels()
    }
    
    private func refreshUnitLabels() {
        switch calculatorMode {
        case .Length:
            fromUnitLabel.text = fromLengthUnits.rawValue
            toUnitLabel.text = toLengthUnits.rawValue
        case .Volume:
            fromUnitLabel.text = fromVolumeUnits.rawValue
            toUnitLabel.text = toVolumeUnits.rawValue
        }
    }
}
