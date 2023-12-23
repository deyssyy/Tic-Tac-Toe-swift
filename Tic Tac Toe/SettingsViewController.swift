//
//  SettingsViewController.swift
//  Tic Tac Toe
//
//  Created by nikita on 21.12.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var settingsbg: UIView!
    @IBOutlet weak var difficult: UIPickerView!
    @IBOutlet weak var headerLabel: UILabel!
    
    var defaults = UserDefaults.standard
    var diffarr = ["Лёгкий","Нормальный","Сложный","Непобедимый"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        difficult.delegate = self
        difficult.dataSource = self
        let temp = defaults.integer(forKey: "DifLevel")
        difficult.selectRow(temp, inComponent: 0, animated: true)
        headerLabel.layer.shadowColor = UIColor.black.cgColor
        headerLabel.layer.shadowRadius = 3.0
        headerLabel.layer.shadowOpacity = 1.0
        headerLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        settingsbg.layer.shadowColor = UIColor.black.cgColor
        settingsbg.layer.shadowRadius = 3.0
        settingsbg.layer.shadowOpacity = 1.0
        settingsbg.layer.shadowOffset = CGSize(width: 4, height: 4)
        }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return diffarr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return diffarr[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        defaults.set(row, forKey: "DifLevel")
    }
    }


