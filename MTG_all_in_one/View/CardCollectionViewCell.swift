//
//  CardCollectionViewCell.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 14.11.22.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImg: CardImageView!
    
    
    func configureCell(with card: CardMTG) {
        cardImg.fetchImage(from: card.imageURL)
    }
}
