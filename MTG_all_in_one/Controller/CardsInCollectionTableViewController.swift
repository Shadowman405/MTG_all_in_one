//
//  CardsInCollectionTableViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 3.12.22.
//

import UIKit

class CardsInCollectionTableViewController: UITableViewController {
    
    var cardCollection: CardCollection?
    var selectedCard: CardMTG?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Main Deck"
        } else {
            return "Side Deck"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return cardCollection?.cards.count ?? 0
        if section == 0 {
            if (cardCollection?.cards.count)! <= 59{
                return cardCollection?.cards.count ?? 0
            } else {
                return cardCollection?.cards[0...59].count ?? 0
            }
        } else {
            if (cardCollection?.cards.count)! > 59 {
                return cardCollection?.cards[59...].count ?? 0
            } else {
                return 0
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCard = cardCollection?.cards[indexPath.row]
        performSegue(withIdentifier: "toCardDetails", sender: self)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
//        let card = cardCollection!.cards[indexPath.row]
//        var content = cell.defaultContentConfiguration()
//        content.text = card.name
//        cell.contentConfiguration = content
        switch indexPath.section {
        case 0:
            let cards = cardCollection!.cards[...59]
            let card = cards[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = card.name
            cell.contentConfiguration = content
        case 1:
            let sideCards = cardCollection!.cards[59...66]
            let card = sideCards[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = card.name
            cell.contentConfiguration = content
        default:
            break
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCardDetails" {
            if let detailsVC = segue.destination as? CardDetailsViewController {
                detailsVC.card = selectedCard
                detailsVC.hideButton()
            }
        }
    }

}
