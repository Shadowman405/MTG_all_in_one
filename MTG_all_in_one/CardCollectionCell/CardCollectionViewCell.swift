//
//  CardCollectionViewCell.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 14.11.22.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    var viewModel: CardCollectionCellViewModelProtocol! {
        didSet {
            cardImg.fetchImage(from: viewModel.cardImg)
        }
    }
    
    @IBOutlet weak var cardImg: CardImageView!
}
