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
    private var manager = NetworkManager.shared
    
    var viewModel: CardsInCollectionViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = false


    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if viewModel.editable {
            if section == 0 {
                return "Main Deck"
            } else {
                return "Side Deck"
            }
        } else {
            if section == 0 {
                return "\(viewModel.collection.collectionName)"
            } else {
                return "Deck"
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.editable {
            if section == 0 {
                if (viewModel.collection.cards.count) <= 59{
                    return viewModel.collection.cards.count
                } else {
                    return viewModel.collection.cards[0...59].count
                }
            } else {
                if (viewModel.collection.cards.count) > 59 {
                    return viewModel.collection.cards[59...viewModel.collection.cards.count - 1].count
                } else {
                    return 0
                }
            }
        } else {
            return viewModel.collection.cards.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
        //let cards = cardCollection!.cards
        let cards = viewModel.collection.cards
        
        switch indexPath.section {
        case 0:
//            let mapedCards = cards.enumerated().filter { $0.offset <= 59 && $0.offset <= cardCollection!.cards.count - 1 }.map { $0.element }
            let card = cards[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.attributedText = manager.addManaImages(someString: card.name)
            content.secondaryAttributedText = manager.addManaImages(someString: card.manaCost)
            cell.contentConfiguration = content
        case 1:
            let mapedCards = cards.enumerated().filter { $0.offset >= 59 && $0.offset <= viewModel.collection.cards.count - 1 }.map { $0.element }
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
            viewModel.editable = true
            tableView.reloadData()
        } else {
            table.isEditing = true
            viewModel.editable = false
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
