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
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cardImg: CardImageView!
    @IBOutlet weak var setNameLbl: UILabel!
    @IBOutlet weak var rarityLbl: UILabel!
    @IBOutlet weak var manaCostLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = false

        guard let card = card else {return}
        configView(with: card)
        view.backgroundColor = .lightGray
    }
    
    @IBAction func addButton(_ sender: Any) {
        //showAlert()
        performSegue(withIdentifier: "toSaveCard", sender: self)
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

//extension CardDetailsViewController {
//    private func showAlert() {
//        let alert = UIAlertController.createAlert(withTitle: "New Card",
//                                                  andMessage: "Save this card to your collection")
//
//        alert.action { newValue in
//            self.saveCard(withCard: self.card!, inCollection: newValue)
//        }
//
//        present(alert, animated: true)
//    }
//
//    private func saveCard(withCard card: CardMTG,inCollection collection: String) {
//        let cardToSave = CardCollection(value: [card, collection])
//
//        StorageManager.shared.save(card: card, in: cardToSave)
//    }
//}
