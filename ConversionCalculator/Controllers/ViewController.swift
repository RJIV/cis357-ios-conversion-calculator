//
//  ViewController.swift
//  ConversionCalculator
//
//  Created by Hamilton, Robert on 9/16/19.
//  Copyright © 2019 Hamilton, Robert. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, SettingsViewControllerDelegate, HistoryTableViewControllerDelegate {
    
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
    
    var entries : [Conversion] = [
            Conversion(fromVal: 1, toVal: 1760, mode: .Length, fromUnits: LengthUnit.Miles.rawValue, toUnits:
    LengthUnit.Yards.rawValue, timestamp: Date.distantPast),
            Conversion(fromVal: 1, toVal: 4, mode: .Volume, fromUnits: VolumeUnit.Gallons.rawValue, toUnits:
    VolumeUnit.Quarts.rawValue, timestamp: Date.distantFuture)]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Length Conversion Calculator"
        self.view.backgroundColor = BACKGROUND_COLOR
        
        fromValueTextField.delegate = self
        toValueTextField.delegate = self
        
        refreshUnitLabels()
    }
    
    func selectEntry(entry: Conversion) {
        calculatorMode = entry.mode
        fromValueTextField.text = String(entry.fromVal)
        toValueTextField.text = String(entry.toVal)
        
        if calculatorMode == .Length {
            fromLengthUnits = LengthUnit(rawValue: entry.fromUnits)!
            toLengthUnits = LengthUnit(rawValue: entry.toUnits)!
            self.title = "Length Conversion Calculator"
        } else {
            fromVolumeUnits = VolumeUnit(rawValue: entry.fromUnits)!
            toVolumeUnits = VolumeUnit(rawValue: entry.toUnits)!
            self.title = "Volume Conversion Calculator"
        }
        
        refreshUnitLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem
        
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
        case "viewHistorySegue":
            if let dest = segue.destination as? HistoryTableViewController {
                dest.historyTableViewControllerDelegate = self
                dest.entries = entries
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
        var validEntry = false
        if fromValueTextField.text == "" && toValueTextField.text != "" {
            if let toValue = Double(toValueTextField.text!) {
                if calculatorMode == .Length {
                    fromValueTextField.text = String(lengthConversionTable[LengthConversionKey(toUnits: fromLengthUnits, fromUnits: toLengthUnits)]! * toValue)
                } else {
                    fromValueTextField.text = String(volumeConversionTable[VolumeConversionKey(toUnits: fromVolumeUnits, fromUnits: toVolumeUnits)]! * toValue)
                }
                validEntry = true
            }
        } else if fromValueTextField.text != "" {
            if let toValue = Double(fromValueTextField.text!) {
                if calculatorMode == .Length {
                    toValueTextField.text = String(lengthConversionTable[LengthConversionKey(toUnits: toLengthUnits, fromUnits: fromLengthUnits)]! * toValue)
                } else {
                    toValueTextField.text = String(volumeConversionTable[VolumeConversionKey(toUnits: toVolumeUnits, fromUnits: fromVolumeUnits)]! * toValue)
                }
                validEntry = true
            }
        }
        
        if validEntry {
            let entry = Conversion(
                fromVal: Double(fromValueTextField.text!)!,
                toVal: Double(toValueTextField.text!)!,
                mode: calculatorMode,
                fromUnits: fromUnitLabel.text!,
                toUnits: toUnitLabel.text!,
                timestamp: Date()
            )
            entries.append(entry)
            print(entries)
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
