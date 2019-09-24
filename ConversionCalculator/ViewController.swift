//
//  ViewController.swift
//  ConversionCalculator
//
//  Created by Hamilton, Robert on 9/16/19.
//  Copyright © 2019 Hamilton, Robert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private static let defaultLengthConversionKey = LengthConversionKey(toUnits: .Meters, fromUnits: .Yards)
    
    private static let defaultVolumeConversionKey = VolumeConversionKey(toUnits: .Liters, fromUnits: .Gallons)
    
    @IBOutlet weak var input2: UITextField!
    @IBOutlet weak var input1: UITextField!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var calculateBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var modeBtn: UIButton!
    @IBOutlet weak var uiNavBar: UINavigationBar!
    
    var calculatorMode: CalculatorMode = .Length
    var currentLengthConversionKey = defaultLengthConversionKey
    var currentVolumeConversionKey = defaultVolumeConversionKey
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        if input1.text != nil && input2.text == nil {
            if let input1Double = Double(input1.text!){
                self.input2.text = String(lengthConversionTable[LengthConversionKey(toUnits: .Meters, fromUnits: .Yards)]! * input1Double)
            }
        } else {
            if let input2Double = Double(input2.text!){
                self.input1.text = String(lengthConversionTable[LengthConversionKey(toUnits: .Meters, fromUnits: .Yards)]! * input2Double)
            }
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        input1.text = ""
        input2.text = ""
    }
    
    @IBAction func modeButtonTapped(_ sender: UIButton) {
        switch (calculatorMode) {
        case .Length:
            calculatorMode = .Volume
        case .Volume:
            calculatorMode = .Length
        }
    }
}

