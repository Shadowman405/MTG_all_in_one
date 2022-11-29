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

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cardCollection.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let collection = cardCollection[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = collection.collectionName
        content.secondaryText = "Cards: \(collection.cards.count)"
        cell.contentConfiguration = content

        return cell
    }
}
