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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func togglePickerViewVisibility() {
        pickerView.isHidden = !pickerView.isHidden
    }
    
    @IBAction func fromUnitsLabelTapped(_ sender: UILabel) {
        togglePickerViewVisibility()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
}
