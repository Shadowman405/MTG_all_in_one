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
    private var editTable = true
    private var manager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = false


    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if editTable {
            return 2
        } else {
            return 1
        }
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
        let cards = cardCollection!.cards
        
        switch indexPath.section {
        case 0:
//            let mapedCards = cards.enumerated().filter { $0.offset <= 59 && $0.offset <= cardCollection!.cards.count - 1 }.map { $0.element }
            let card = cards[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.attributedText = manager.addManaImages(someString: card.name)
            content.secondaryAttributedText = manager.addManaImages(someString: card.manaCost)
            cell.contentConfiguration = content
        case 1:
            let mapedCards = cards.enumerated().filter { $0.offset >= 59 && $0.offset <= cardCollection!.cards.count - 1 }.map { $0.element }
            let card = mapedCards[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.attributedText = manager.addManaImages(someString: card.name)
            content.secondaryAttributedText = manager.addManaImages(someString: card.manaCost)
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] _, _, _ in
            try! cardCollection?.realm!.write {
                cardCollection?.cards.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    @IBAction func didTapSort() {
        if table.isEditing {
            table.isEditing = false
            editTable = true
            tableView.reloadData()
        } else {
            table.isEditing = true
            editTable = false
            tableView.reloadData()
        }
    }
    
    //MARK: - Segue Logic
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapedCards = cardCollection!.cards.enumerated().filter { $0.offset >= 59 && $0.offset <= cardCollection!.cards.count - 1 }.map { $0.element }
//        selectedCard = cardCollection?.cards[indexPath.row]
//        performSegue(withIdentifier: "toCardDetails", sender: self)
        switch indexPath.section {
        case 0:
            selectedCard = cardCollection?.cards[indexPath.row]
            performSegue(withIdentifier: "toCardDetails", sender: self)
        case 1:
            selectedCard = mapedCards[indexPath.row]
            performSegue(withIdentifier: "toCardDetails", sender: self)
        default:
            print("Error")
        }
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
