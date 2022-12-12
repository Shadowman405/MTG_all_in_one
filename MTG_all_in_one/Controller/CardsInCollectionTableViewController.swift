//
//  CardsInCollectionTableViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 3.12.22.
//

import UIKit

class CardsInCollectionTableViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
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
        if section == 0 {
            if (cardCollection?.cards.count)! <= 59{
                return cardCollection?.cards.count ?? 0
            } else {
                return cardCollection?.cards[0...59].count ?? 0
            }
        } else {
            if (cardCollection?.cards.count)! > 59 {
                return cardCollection?.cards[59...cardCollection!.cards.count - 1].count ?? 0
            } else {
                return 0
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
        switch indexPath.section {
        case 0:
            let cards = cardCollection!.cards
            let card = cards[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = card.name
            cell.contentConfiguration = content
        case 1:
            let sideCards = cardCollection!.cards
            var mapedCards = sideCards.enumerated().filter { $0.offset >= 59 && $0.offset <= cardCollection!.cards.count - 1 }.map { $0.element }
            let card = mapedCards[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = card.name
            cell.contentConfiguration = content
        default:
            break
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //cardCollection?.cards.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        try! cardCollection?.realm!.write {
            cardCollection?.cards.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
        }
    }
    
    @IBAction func didTapSort() {
        if table.isEditing {
            table.isEditing = false
        } else {
            table.isEditing = true
        }
    }
    
    //MARK: - Segue Logic
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCard = cardCollection?.cards[indexPath.row]
        performSegue(withIdentifier: "toCardDetails", sender: self)
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
