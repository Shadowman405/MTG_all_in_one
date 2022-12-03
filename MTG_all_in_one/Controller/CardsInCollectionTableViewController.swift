//
//  CardsInCollectionTableViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 3.12.22.
//

import UIKit

class CardsInCollectionTableViewController: UITableViewController {
    
    var cardCollection: CardCollection?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cardCollection?.cards.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
        let card = cardCollection!.cards[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = card.name
        cell.contentConfiguration = content

        return cell
    }
    

}
