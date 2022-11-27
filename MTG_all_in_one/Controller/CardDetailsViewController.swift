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
        view.backgroundColor = .systemMint
    }
    
    func configView(with card: CardMTG) {
        nameLbl.text = card.name
        cardImg.fetchImage(from: card.imageURL)
        setNameLbl.text = "Set name: " + card.setName
        rarityLbl.text = "Card rarity: " + card.rarity
        manaCostLbl.text = "Mana cost: " + card.manaCost
        descriptionLbl.text = card.text
        
        print(card.name)
    }

}
