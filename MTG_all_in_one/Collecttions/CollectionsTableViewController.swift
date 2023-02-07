//
//  CollectionsTableViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 16.11.22.
//

import UIKit
import RealmSwift

class CollectionsTableViewController: UITableViewController {
    
    private var cardCollection : Results<CardCollection>!
    private var selectedCollection: CardCollection?
    
    private var viewModel: CollectionsViewModelProtocol! {
        didSet {
            cardCollection = viewModel.cardCollection
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CollectionsViewModel()
        UIApplication.shared.isIdleTimerDisabled = false

        //cardCollection = StorageManager.shared.realm.objects(CardCollection.self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let collection = cardCollection[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = collection.collectionName
        content.secondaryText = "Cards: \(collection.cards.count)/60"
        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCollection = cardCollection[indexPath.row]
        performSegue(withIdentifier: "toCards", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCards" {
            if let cardsTVC = segue.destination as? CardsInCollectionTableViewController {
                cardsTVC.cardCollection = selectedCollection
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let currentCollection = cardCollection[indexPath.row]
        let deleteActtion = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            StorageManager.shared.delete(cardCollection: currentCollection)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteActtion])
    }
    
    
    @IBAction func addNewCollection(_ sender: Any) {
        showAlert()
    }
    
    //MARK: - Mock Data
    
    private func createTestData(){
        let firstList = CardCollection()
        firstList.collectionName = "Main Deck"
        
        let cardOne = CardMTG()
        cardOne.name = "Forest"
        cardOne.type = "Basic Land — Forest"
        cardOne.rarity = "Common"
        cardOne.setName = "KHM"
        cardOne.imageURL = "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=507589&type=card"
        cardOne.manaCost = ""
        cardOne.text = "({T}: Add {G}.)"
        cardOne.originalType = "Basic Land — Forest"
        cardOne.id = "4ac153f5-8a7c-5128-8135-64b1c0c851e5"
        
        firstList.cards.insert(cardOne, at: 0)
        
        DispatchQueue.main.async {
            StorageManager.shared.save(cardCollection: [firstList])
        }
    }
}

//MARK: - Extensions

extension CollectionsTableViewController {
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
        let rowIndex = IndexPath(row: cardCollection.count - 1, section: 0)
        tableView.insertRows(at: [rowIndex], with: .automatic)
    }
}
