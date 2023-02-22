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
    var sections = [Section]()
    
    var viewModel: CardsInCollectionViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        let sectionTitles = viewModel.uniqueCards()
        print(sectionTitles.count)
        UIApplication.shared.isIdleTimerDisabled = false
        
        createSections()
    }
    
    func createSections() {
        var sectionTitles = viewModel.uniqueCards()
        
        if sectionTitles.count != 0 {
            sectionTitles = sectionTitles.sorted()
            let filterArrays = viewModel.filteredCollections(counts: sectionTitles.count)
            
            for i in 0...sectionTitles.count - 1 {
                sections.append(Section(title: i.description, duplicateCards: filterArrays[i]))
            }
        } else {
            sections = []
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        //viewModel.numberOfSections()
        
//        var sectionTitles = viewModel.uniqueCards()
//        sectionTitles = sectionTitles.sorted()
//        return sectionTitles.count
        if viewModel.editable {
            return sections.count
        } else {
           return 1
        }
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        //viewModel.titleForHeader(section: section)
//
//        var sectionTitles = viewModel.uniqueCards()
//        sectionTitles = sectionTitles.sorted()
//
//        guard sectionTitles.indices ~= section else {
//            return nil
//        }
//
//        return sectionTitles[section]
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //viewModel.numberOfRows(section: section)
//        var sectionTitles = viewModel.uniqueCards()
//        sectionTitles = sectionTitles.sorted()
//        let filterArrays = viewModel.filteredCollections(counts: sectionTitles.count)
//        return filterArrays[section].count
        
        let section = sections[section]
        
        if viewModel.editable {
            if section.isOpened{
                return section.duplicateCards.count + 1
            } else {
                return 1
            }
        } else {
            return viewModel.collection.cards.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
        //let cards = viewModel.collection.cards
        
        let sectionTitles = viewModel.uniqueCards()
        //let filterArrays = viewModel.filteredCollections(counts: sectionTitles.count)
        
        //let card = cards[indexPath.row]
        let section = sections[indexPath.section]
        
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
        
//        for _ in 0...cards.count - 1 {
//                for indexSection in 0...sectionTitles.count - 1 {
//                    if card.name == sectionTitles[indexSection] {
//                        if indexPath.section == indexSection {
//                            var content = cell.defaultContentConfiguration()
//                            content.attributedText = manager.addManaImages(someString: card.name)
//                            content.secondaryAttributedText = manager.addManaImages(someString: card.manaCost)
//                            cell.contentConfiguration = content
//                        }
//                    }
//                }
//       }
        
//        for i in 0...sectionTitles.count - 1 {
//            if sectionTitles[i] == filterCard.name {
//                var content = cell.defaultContentConfiguration()
//                content.attributedText = manager.addManaImages(someString: filterCard.name)
//                content.secondaryAttributedText = manager.addManaImages(someString: filterCard.manaCost)
//                cell.contentConfiguration = content
//            }
//        }
        
        if viewModel.editable {
            if indexPath.row == 0 {
                let filterCard = section.duplicateCards[indexPath.row]
                for i in 0...sectionTitles.count - 1 {
                    if sectionTitles[i] == filterCard.name {
                        var content = cell.defaultContentConfiguration()
                        content.text = "\(filterCard.name) x\(section.duplicateCards.count)"
                        cell.contentConfiguration = content
                    }
                }
            } else {
                let filterCard = section.duplicateCards[indexPath.row - 1]
                for i in 0...sectionTitles.count - 1 {
                    if sectionTitles[i] == filterCard.name {
                        var content = cell.defaultContentConfiguration()
                        content.attributedText = manager.addManaImages(someString: filterCard.name)
                        content.secondaryAttributedText = manager.addManaImages(someString: filterCard.manaCost)
                        cell.contentConfiguration = content
                    }
                }
            }
        } else {
            let card = viewModel.collection.cards[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.attributedText = manager.addManaImages(someString: card.name)
            content.secondaryAttributedText = manager.addManaImages(someString: card.manaCost)
            cell.contentConfiguration = content
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
        tableView.reloadData()
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    @IBAction func didTapSort() {
        if table.isEditing {
            table.isEditing = false
            viewModel.editable = true
            updateSectionData()
        } else {
            table.isEditing = true
            viewModel.editable = false
            updateSectionData()
        }
    }
    
    private func updateSectionData() {
        sections = []
        createSections()
        tableView.reloadData()
    }
    
    //MARK: - Segue Logic
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .automatic)
        } else {
            switch indexPath.section {
            default:
                let section = sections[indexPath.section]
                let filterCard = section.duplicateCards[indexPath.row - 1]
                
                //let detailsCardViewModel = viewModel.detailsViewModel(at: indexPath)
                let detailsCardViewModel = CardDetailsViewModel(card: filterCard)
                performSegue(withIdentifier: "toCardDetails", sender: detailsCardViewModel)
            }
        }
        
//        switch indexPath.section {
//        default:
//            let detailsCardViewModel = viewModel.detailsViewModel(at: indexPath)
//            performSegue(withIdentifier: "toCardDetails", sender: detailsCardViewModel)
//        }
//
        
//        print("row \(indexPath.row)")
//        let detailsCardViewModel = viewModel.detailsViewModel(at: indexPath)
//        performSegue(withIdentifier: "toCardDetails", sender: detailsCardViewModel)
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
