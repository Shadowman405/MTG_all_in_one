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

    override func viewDidLoad() {
        super.viewDidLoad()
        cardCollection = StorageManager.shared.realm.objects(CardCollection.self)

        //createTestData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardCollection.count
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
    
    
    @IBAction func addNewCollection(_ sender: Any) {
        
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
