//
//  CardsInCollectionTableViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 3.12.22.
//

import UIKit

class CardsInCollectionTableViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    @IBOutlet weak var sortBtnLbl: UIBarButtonItem!
    private var manager = NetworkManager.shared
    var viewModel: CardsInCollectionViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = false
        
        viewModel.createSections()
        setupUI()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(section: section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
        let sectionTitles = viewModel.uniqueCards()
        let section = viewModel.sections[indexPath.section]
        
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
        setupUI()
        viewModel.sections = []
        viewModel.createSections()
        tableView.reloadData()
    }
    
    private func setupUI() {
        if viewModel.collection.cards.count == 0 {
            sortBtnLbl.isHidden = true
        }
    }
    
    //MARK: - Segue Logic
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            viewModel.sections[indexPath.section].isOpened = !viewModel.sections[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .automatic)
        } else {
            switch indexPath.section {
            default:
                let section = viewModel.sections[indexPath.section]
                let filterCard = section.duplicateCards[indexPath.row - 1]
                
                //let detailsCardViewModel = viewModel.detailsViewModel(at: indexPath)
                let detailsCardViewModel = CardDetailsViewModel(card: filterCard)
                performSegue(withIdentifier: "toCardDetails", sender: detailsCardViewModel)
            }
        }
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
