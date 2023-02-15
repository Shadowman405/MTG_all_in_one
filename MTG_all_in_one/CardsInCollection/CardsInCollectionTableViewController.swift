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
        let sectionTitles = viewModel.uniqueCards()
        print(sectionTitles.count)
        UIApplication.shared.isIdleTimerDisabled = false
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        //viewModel.numberOfSections()
        
        let sectionTitles = viewModel.uniqueCards()
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //viewModel.titleForHeader(section: section)
        
        let sectionTitles = viewModel.uniqueCards()
        
        guard sectionTitles.indices ~= section else {
            return nil
        }
        
        return sectionTitles[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
        let cards = viewModel.collection.cards
        let sectionTitles = viewModel.uniqueCards()
        
        let card = cards[indexPath.row]
        
//        switch indexPath.section {
//        case 0:
//            let card = cards[indexPath.row]
//            var content = cell.defaultContentConfiguration()
//            content.attributedText = manager.addManaImages(someString: card.name)
//            content.secondaryAttributedText = manager.addManaImages(someString: card.manaCost)
//            cell.contentConfiguration = content
//        case 1:
//            let mapedCards = cards.enumerated().filter { $0.offset >= 59 && $0.offset <= viewModel.collection.cards.count - 1 }.map { $0.element }
//            let card = mapedCards[indexPath.row]
//            var content = cell.defaultContentConfiguration()
//            content.attributedText = manager.addManaImages(someString: card.name)
//            content.secondaryAttributedText = manager.addManaImages(someString: card.manaCost)
//            cell.contentConfiguration = content
//        default:
//            break
//        }
        
        for _ in 0...cards.count - 1 {
                for indexSection in 0...sectionTitles.count - 1 {
                    if card.name == sectionTitles[indexSection] {
                        if indexPath.section == indexSection {
                            var content = cell.defaultContentConfiguration()
                            content.attributedText = manager.addManaImages(someString: card.name)
                            content.secondaryAttributedText = manager.addManaImages(someString: card.manaCost)
                            cell.contentConfiguration = content
                        }
                    }
                }
       }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        try! viewModel.collection.realm!.write {
            viewModel.collection.cards.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] _, _, _ in
            try! viewModel.collection.realm!.write {
                viewModel.collection.cards.remove(at: indexPath.row)
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
        let detailsCardViewModel = viewModel.detailsViewModel(at: indexPath)
        performSegue(withIdentifier: "toCardDetails", sender: detailsCardViewModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCardDetails" {
            if let detailsVC = segue.destination as? CardDetailsViewController {
                detailsVC.viewModel = sender as? CardDetailsViewModelProtocol
                detailsVC.hideButton()
            }
        }
    }

}
