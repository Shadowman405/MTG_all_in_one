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
    @IBOutlet weak var manaCostTextLbl: UILabel!
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
        var manaCostImageString = addManaImages(someString: card.manaCost)
        var descTextWithImage = addManaImages(someString: card.text)
        
        nameLbl.text = card.name
        cardImg.fetchImage(from: card.imageURL)
        setNameLbl.text = "Set name: " + card.setName
        rarityLbl.text = "Card rarity: " + card.rarity
        manaCostLbl.attributedText = manaCostImageString
        descriptionLbl.attributedText = descTextWithImage
        
        if card.manaCost.isEmpty {
            manaCostTextLbl.isHidden = true
        }
        
        print(card.name)
    }
    
    func hideButton() {
        addButton.isHidden = true
    }
    
    func addManaImages(someString: String?) -> NSMutableAttributedString {
        guard let manaCost = someString else {return NSMutableAttributedString()}
        let imagesDict: [String:String] = ["{W}":"W", "{R}":"R","{B}":"B","{G}":"G","{U}":"U", "{1}":"One", "{2}":"Two", "{3}":"Three", "{4}":"Four", "{5}":"Five", "{6}":"Six", "{7}":"Seven", "{8}":"Eight", "{9}":"Nine", "{0}":"Zero", "{T}":"T_2nd"]
        let fullString = NSMutableAttributedString(string: manaCost)
        
        for (imageTag, imageName) in imagesDict {
            let pattern = NSRegularExpression.escapedPattern(for: imageTag)
            let regex = try? NSRegularExpression(pattern: pattern,
                                                 options: [])
            if let matches = regex?.matches(in: fullString.string, range: NSRange(location: 0, length: fullString.string.utf16.count)) {
                for aMtach in matches.reversed() {
                    let attachment = NSTextAttachment()
                    attachment.image = UIImage(named: imageName)
                    attachment.bounds = CGRectMake(0, 0, 24, 24)
                    let replacement = NSAttributedString(attachment: attachment)
                    fullString.replaceCharacters(in: aMtach.range, with: replacement)
                }
            }
        }
        
        return fullString
        
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
