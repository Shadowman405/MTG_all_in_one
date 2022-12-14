//
//  HPCounterViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 27.11.22.
//

import UIKit

class HPCounterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var greenMinLbl: UIButton!
    @IBOutlet weak var greenPlsLbl: UIButton!
    
    @IBOutlet weak var redMinLbl: UIButton!
    @IBOutlet weak var redPlsLbl: UIButton!
    
    @IBOutlet weak var greenHPLbl: UILabel!
    @IBOutlet weak var redHPLbl: UILabel!
    
    private var magicSchools = ["Red","Green","Blue","White","Black"]
    var pickerView = UIPickerView()
    var selectedValue = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        greenMinLbl.contentHorizontalAlignment = .left
        greenPlsLbl.contentHorizontalAlignment = .left
        
        redMinLbl.contentHorizontalAlignment = .right
        redPlsLbl.contentHorizontalAlignment = .right
        
        greenHPLbl.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    
    @IBAction func editViewStyle(_ sender: Any) {
        let alert = UIAlertController(title: "Choose School", message: "", preferredStyle: .alert)
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 55, y: 20, width: 250, height: 300))
        //pickerFrame.frame = CGRectMake(0, 15, 250, 300)
        alert.view.addSubview(pickerFrame)
        pickerView.dataSource = self
        pickerFrame.delegate = self
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
            case 0: return magicSchools.count
            default : return magicSchools.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0 : return magicSchools[row]
        default: return magicSchools[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            if row == 0{
                selectedValue = "Red"
                greenMinLbl.backgroundColor = .red
                greenPlsLbl.backgroundColor = .red
            } else if row == 1 {
                selectedValue = "Green"
                greenMinLbl.backgroundColor = .green
                greenPlsLbl.backgroundColor = .green
            } else if row == 2 {
                selectedValue = "Blue"
                greenMinLbl.backgroundColor = .blue
                greenPlsLbl.backgroundColor = .blue
            } else if row == 3 {
                selectedValue = "White"
                greenMinLbl.backgroundColor = .cyan
                greenPlsLbl.backgroundColor = .cyan
            } else if row == 4 {
                selectedValue = "Black"
                greenMinLbl.backgroundColor = .purple
                greenPlsLbl.backgroundColor = .purple
            }
        default :
            if row == 0{
                selectedValue = "Red"
            } else if row == 1 {
                selectedValue = "Green"
            } else if row == 2 {
                selectedValue = "Blue"
            } else if row == 3 {
                selectedValue = "White"
            } else if row == 4 {
                selectedValue = "Black"
            }
        }
    }
    
    
    //MARK: - GreenHP
    
    @IBAction func greenMinHP(_ sender: Any) {
        guard var greenHP = greenHPLbl.text else {return}
        if Int(greenHP) != 0 {
            greenHP = String((Int(greenHP) ?? 0) - 1)
            greenHPLbl.text = greenHP
        } else {
            alertMessage()
        }
    }
    
    @IBAction func greenPlusHP(_ sender: Any) {
        guard var greenHP = greenHPLbl.text else {return}
        if Int(greenHP) != 0 {
            greenHP = String((Int(greenHP) ?? 0) + 1)
            greenHPLbl.text = greenHP
        }
    }
    
    //MARK: - RedHP
    @IBAction func redMinHP(_ sender: Any) {
        guard var redHP = redHPLbl.text else {return}
        if Int(redHP) != 0 {
            redHP = String((Int(redHP) ?? 0) - 1)
            redHPLbl.text = redHP
        } else {
            alertMessage()
        }
    }
    
    @IBAction func redPlusHP(_ sender: Any) {
        guard var redHP = redHPLbl.text else {return}
        if Int(redHP) != 0 {
            redHP = String((Int(redHP) ?? 0) + 1)
            redHPLbl.text = redHP
        }
    }
    
    //MARK: - AlertController
    
    private func alertMessage() {
        let alert = UIAlertController(title: "Defeated", message: "You lost all HP", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Accept Defeat", style: .destructive, handler: { _ in
            self.redHPLbl.text = "20"
            self.greenHPLbl.text = "20"
        }))
        self.present(alert, animated: true)
        
    }
}
