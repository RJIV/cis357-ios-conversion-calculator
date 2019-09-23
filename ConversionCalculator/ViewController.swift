//
//  ViewController.swift
//  ConversionCalculator
//
//  Created by Hamilton, Robert on 9/16/19.
//  Copyright © 2019 Hamilton, Robert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var input2: UITextField!
    @IBOutlet weak var input1: UITextField!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var calculateBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var modeBtn: UIButton!
    @IBOutlet weak var uiNavBar: UINavigationBar!
    
    var calculatorMode: CalculatorMode! = .Length
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculateBtn(_ sender: UIButton) {
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
    
    @IBAction func clearInputs(_ sender: UIButton) {
        input1.text = ""
        input2.text = ""
    }

    @IBAction func settingsBtnTapped(_ sender: UIButton) {

    }



}

