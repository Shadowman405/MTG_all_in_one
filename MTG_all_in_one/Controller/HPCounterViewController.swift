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
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        greenMinLbl.contentHorizontalAlignment = .left
        greenPlsLbl.contentHorizontalAlignment = .left
        
        redMinLbl.contentHorizontalAlignment = .right
        redPlsLbl.contentHorizontalAlignment = .right
    }
    
    //MARK: - Green
    
    @IBAction func greenMinHP(_ sender: Any) {
    }
    
    @IBAction func greenPlusHP(_ sender: Any) {
    }
    
    //MARK: - Red
    @IBAction func redMinHP(_ sender: Any) {
    }
    
    @IBAction func redPlusHP(_ sender: Any) {
    }
    

}
