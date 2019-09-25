//
//  SettingsViewController.swift
//  ConversionCalculator
//
//  Created by Josh Chua on 9/24/19.
//  Copyright © 2019 Hamilton, Robert. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    

    @IBOutlet weak var fromUnitsLabel: UILabel!
    @IBOutlet weak var toUnitsLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var currentLabel: UILabel?
    
    var pickerData = [String]()
    
    var fromLengthUnits: LengthUnit = .Meters
    var toLengthUnits: LengthUnit = .Yards
    
    var fromVolumeUnits: VolumeUnit = .Liters
    var toVolumeUnits: VolumeUnit = .Gallons
    
    var editingState: EditingState = .None
    
    var calculatorMode: CalculatorMode = .Length
    
    var settingsViewControllerDelegate: SettingsViewControllerDelegate?
    
    enum EditingState {
        case None
        case From
        case To
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.viewTapped(_:)))
        let fromTap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.fromUnitsLabelTapped(_:)))
        let toTap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.toUnitsLabelTapped(_:)))
        fromUnitsLabel.addGestureRecognizer(fromTap)
        toUnitsLabel.addGestureRecognizer(toTap)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(viewTap)
        
        switch calculatorMode {
        case .Length:
            pickerData = LengthUnit.allCases.map{ $0.rawValue }
            fromUnitsLabel.text = fromLengthUnits.rawValue
            toUnitsLabel.text = toLengthUnits.rawValue
        case .Volume:
            pickerData = VolumeUnit.allCases.map{ $0.rawValue }
            fromUnitsLabel.text = fromVolumeUnits.rawValue
            toUnitsLabel.text = toVolumeUnits.rawValue
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        pickerView.isHidden = true
    }
    
    @objc func fromUnitsLabelTapped(_ sender: UITapGestureRecognizer) {
        pickerView.isHidden = false
        editingState = .From
    }
    
    @objc func toUnitsLabelTapped(_ sender: UITapGestureRecognizer) {
        pickerView.isHidden = false
        editingState = .To
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if let delegate = settingsViewControllerDelegate {
            switch calculatorMode {
            case .Length:
                delegate.settingsChanged(fromUnits: fromLengthUnits, toUnits: toLengthUnits)
            case .Volume:
                delegate.settingsChanged(fromUnits: fromVolumeUnits, toUnits: toVolumeUnits)
            }
            
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selection: String = pickerData[row]
        switch (calculatorMode, editingState) {
        case (.Length, .From):
            fromLengthUnits = LengthUnit(rawValue: selection)!
            fromUnitsLabel.text = selection
        case (.Length, .To):
            toLengthUnits = LengthUnit(rawValue: selection)!
            toUnitsLabel.text = selection
        case (.Volume, .From):
            fromVolumeUnits = VolumeUnit(rawValue: selection)!
            fromUnitsLabel.text = selection
        case (.Volume, .To):
            toVolumeUnits = VolumeUnit(rawValue: selection)!
            toUnitsLabel.text = selection
        default:
            return
        }
    }
}
