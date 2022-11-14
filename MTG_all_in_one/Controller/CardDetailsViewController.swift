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
    @IBOutlet weak var cardImg: CardImageView!
    @IBOutlet weak var setNameLbl: UILabel!
    @IBOutlet weak var rarityLbl: UILabel!
    @IBOutlet weak var manaCostLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let card = card else {return}
        configView(with: card)
    }
    
    func configView(with card: CardMTG) {
        nameLbl.text = card.name
        cardImg.fetchImage(from: card.imageURL)
        setNameLbl.text = card.setName
        rarityLbl.text = card.rarity
        manaCostLbl.text = card.manaCost
        descriptionLbl.text = card.text
    }

}
