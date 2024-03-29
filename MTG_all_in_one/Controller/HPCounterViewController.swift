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
    let manager = HapticManager.shared
    var selectedValue = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraintsAndUI()
    }
    
    
    @IBAction func editViewStyle(_ sender: Any) {
        let alert = UIAlertController(title: "Choose School", message: "", preferredStyle: .alert)

        let pickeViewFrame: CGRect = CGRect(x: 0, y: 0, width: 250, height: 220)
        let pickerViewRadius: UIPickerView = UIPickerView(frame: pickeViewFrame)
        pickerViewRadius.delegate = self
        pickerViewRadius.dataSource = self
        
        alert.view.addSubview(pickerViewRadius)
        pickerView.dataSource = self
        alert.view.addConstraint(NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.3))

        
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        alert.addAction(UIAlertAction(title: "Refresh HP", style: .destructive, handler: { _ in
            self.redHPLbl.text = "20"
            self.greenHPLbl.text = "20"
        }))
        self.present(alert, animated: true)
    }
    
    
    //MARK: - GreenHP
    
    @IBAction func greenMinHP(_ sender: Any) {
        guard var greenHP = greenHPLbl.text else {return}
        if Int(greenHP) != 0 {
            greenHP = String((Int(greenHP) ?? 0) - 1)
            greenHPLbl.text = greenHP
            manager.vibrate(for: .success)
            print((view.frame.height - view.safeAreaInsets.top) * 0.25)
        } else {
            alertMessage()
        }
    }
    
    @IBAction func greenPlusHP(_ sender: Any) {
        guard var greenHP = greenHPLbl.text else {return}
        if Int(greenHP) != 0 {
            greenHP = String((Int(greenHP) ?? 0) + 1)
            greenHPLbl.text = greenHP
            manager.vibrate(for: .success)
        }
    }
    
    //MARK: - RedHP
    @IBAction func redMinHP(_ sender: Any) {
        guard var redHP = redHPLbl.text else {return}
        if Int(redHP) != 0 {
            redHP = String((Int(redHP) ?? 0) - 1)
            redHPLbl.text = redHP
            manager.vibrate(for: .success)
        } else {
            alertMessage()
        }
    }
    
    @IBAction func redPlusHP(_ sender: Any) {
        guard var redHP = redHPLbl.text else {return}
        if Int(redHP) != 0 {
            redHP = String((Int(redHP) ?? 0) + 1)
            redHPLbl.text = redHP
            manager.vibrate(for: .success)
        }
    }
}

// MARK: - Extension


extension HPCounterViewController {
    //MARK: - UIPickerView
    
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
                greenMinLbl.backgroundColor = #colorLiteral(red: 1, green: 0.8168858886, blue: 0.6812224388, alpha: 1)
                greenPlsLbl.backgroundColor = #colorLiteral(red: 1, green: 0.8168858886, blue: 0.6812224388, alpha: 1)
            } else if row == 4 {
                selectedValue = "Black"
                greenMinLbl.backgroundColor = .purple
                greenPlsLbl.backgroundColor = .purple
            }
        default :
            if row == 0{
                selectedValue = "Red"
                redMinLbl.backgroundColor = .red
                redPlsLbl.backgroundColor = .red
            } else if row == 1 {
                selectedValue = "Green"
                redMinLbl.backgroundColor = .green
                redPlsLbl.backgroundColor = .green
            } else if row == 2 {
                selectedValue = "Blue"
                redMinLbl.backgroundColor = .blue
                redPlsLbl.backgroundColor = .blue
            } else if row == 3 {
                selectedValue = "White"
                redMinLbl.backgroundColor = #colorLiteral(red: 1, green: 0.8168858886, blue: 0.6812224388, alpha: 1)
                redPlsLbl.backgroundColor = #colorLiteral(red: 1, green: 0.8168858886, blue: 0.6812224388, alpha: 1)
            } else if row == 4 {
                selectedValue = "Black"
                redMinLbl.backgroundColor = .purple
                redPlsLbl.backgroundColor = .purple
            }
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
    
    func setupConstraintsAndUI() {
        let mainHeight = view.frame.height - view.safeAreaInsets.top
        let labelHeight = mainHeight * 0.25
        
        UIApplication.shared.isIdleTimerDisabled = true
        greenMinLbl.contentHorizontalAlignment = .left
        greenPlsLbl.contentHorizontalAlignment = .left
        
        redMinLbl.contentHorizontalAlignment = .right
        redPlsLbl.contentHorizontalAlignment = .right
        
        greenHPLbl.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        greenMinLbl.translatesAutoresizingMaskIntoConstraints = false
        greenPlsLbl.translatesAutoresizingMaskIntoConstraints = false
        greenHPLbl.translatesAutoresizingMaskIntoConstraints = false
        
        
        redMinLbl.translatesAutoresizingMaskIntoConstraints = false
        redPlsLbl.translatesAutoresizingMaskIntoConstraints = false
        redHPLbl.translatesAutoresizingMaskIntoConstraints = false
        
        greenMinLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        greenMinLbl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        greenMinLbl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        greenMinLbl.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        
        greenPlsLbl.topAnchor.constraint(equalTo: greenMinLbl.bottomAnchor).isActive = true
        greenPlsLbl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        greenPlsLbl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        greenPlsLbl.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        
        redMinLbl.topAnchor.constraint(equalTo: greenPlsLbl.bottomAnchor).isActive = true
        redMinLbl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        redMinLbl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        redMinLbl.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        
        redPlsLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        redPlsLbl.topAnchor.constraint(equalTo: redMinLbl.bottomAnchor).isActive = true
        redPlsLbl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        redPlsLbl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        redPlsLbl.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        
        //HP label
        greenHPLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        greenHPLbl.topAnchor.constraint(equalTo: greenMinLbl.bottomAnchor, constant: -40).isActive = true
        
        redHPLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        redHPLbl.topAnchor.constraint(equalTo: redMinLbl.bottomAnchor, constant: -20).isActive = true
    }
}
