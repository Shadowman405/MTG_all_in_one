//
//  CardDetailsViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 14.11.22.
//

import UIKit

class CardDetailsViewController: UIViewController {
    
    var card: CardMTG?
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var setNameLbl: UILabel!
    @IBOutlet weak var rarityLbl: UILabel!
    @IBOutlet weak var manaCostLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
