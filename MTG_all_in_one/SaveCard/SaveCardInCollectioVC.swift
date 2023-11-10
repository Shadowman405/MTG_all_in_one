//
//  SaveCardInCollectioVC.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 3.12.22.
//
import UIKit
import RealmSwift 

class SaveCardInCollectioVC: UITableViewController {
    
    private var cardCollection : Results<CardCollection>!
    var card: CardMTG?
    @IBOutlet weak var createCollectionLbl: UIBarButtonItem!
    
    var viewModel: SaveCardViewModelProtocol! {
        didSet {
            viewModel.loadCollcetions {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = false
        
        if viewModel.collection.isEmpty {
            createCollectionLbl.isHidden = false
        } else {
            createCollectionLbl.isHidden = true
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numverOfRows()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.saveInCollection(at: indexPath)
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath)
        let collection = viewModel.collection[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = collection.collectionName
        content.secondaryText = "Cards: \(collection.cards.count)/60"
        cell.contentConfiguration = content
        
        return cell
    }
    
    @IBAction func createCollectionTaped(_ sender: Any) {
        showAlert()
    }
}

//MARK: - Extension for VC
extension SaveCardInCollectioVC {
    private func showAlert() {
        let alert = UIAlertController.createAlert(withTitle: "New Collection",
                                                  andMessage: "Please enter collection name")
        
        alert.action { newValue in
            self.save(cardCollections: newValue)
        }
        
        present(alert, animated: true)
    }
    
    private func save(cardCollections: String) {
        let cardCollections = CardCollection(value: [cardCollections])
        
        StorageManager.shared.save(cardCollection: cardCollections)
        let rowIndex = IndexPath(row: viewModel.collection.count - 1, section: 0)
        tableView.insertRows(at: [rowIndex], with: .automatic)
        createCollectionLbl.isHidden = true
    }
}
