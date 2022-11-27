//
//  HPCounterViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 27.11.22.
//

import UIKit

class HPCounterViewController: UIViewController {
    
    @IBOutlet weak var greenMinLbl: UIButton!
    @IBOutlet weak var greenPlsLbl: UIButton!
    
    @IBOutlet weak var redMinLbl: UIButton!
    @IBOutlet weak var redPlsLbl: UIButton!
    
    @IBOutlet weak var greenHPLbl: UILabel!
    @IBOutlet weak var redHPLbl: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        greenMinLbl.contentHorizontalAlignment = .left
        greenPlsLbl.contentHorizontalAlignment = .left
        
        redMinLbl.contentHorizontalAlignment = .right
        redPlsLbl.contentHorizontalAlignment = .right
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
