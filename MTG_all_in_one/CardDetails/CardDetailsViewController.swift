//
//  CardDetailsViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 14.11.22.
//

import UIKit

class CardDetailsViewController: UIViewController {
    
    var card: CardMTG?
    var activateButon: Bool?
    private var manager = NetworkManager.shared
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cardImg: CardImageView!
    @IBOutlet weak var setNameLbl: UILabel!
    @IBOutlet weak var rarityLbl: UILabel!
    @IBOutlet weak var manaCostLbl: UILabel!
    @IBOutlet weak var manaCostTextLbl: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    var viewModel: CardDetailsViewModelProtocol! 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewModel = CardDetailsViewModel(card: card)
        UIApplication.shared.isIdleTimerDisabled = false

        configView()
    }
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "toSaveCard", sender: self)
    }
    
    func configView() {
        nameLbl.text = viewModel.cardName
        setNameLbl.text = viewModel.setName
        rarityLbl.text = viewModel.cardRarity
        manaCostLbl.attributedText = manager.addManaImages(someString: viewModel.manaCost)
        descriptionTextView.attributedText = manager.addManaImages(someString: viewModel.descriptionText)
        cardImg.fetchImage(from: viewModel.cardImage)
        
        view.backgroundColor = .lightGray
        descriptionTextView.backgroundColor = .lightGray
        descriptionTextView.font = UIFont(name: "Futura", size: 15)
        descriptionTextView.textColor = .white
        
        if viewModel.manaCost.isEmpty {
            manaCostTextLbl.isHidden = true
        }
    }
    
    func hideButton() {
        addButton.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSaveCard" {
            if let saveVC = segue.destination as? SaveCardInCollectioVC {
                saveVC.card = card
            }
        }
    }
}

