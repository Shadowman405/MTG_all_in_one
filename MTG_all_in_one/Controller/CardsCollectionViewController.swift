//
//  CardsCollectionViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 14.11.22.
//

import UIKit

private let reuseIdentifier = "Cell"

class CardsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let manager = NetworkManager.shared
    var cards: [CardMTG] = []
    var selectedCard: CardMTG!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        fetcCards()
        
    }

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 3
//    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCard = cards[indexPath.item]
        performSegue(withIdentifier: "toDetails", sender: nil)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return cards.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardCollectionViewCell
        let card = cards[indexPath.row]
        cell.configureCell(with: card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            if let detailsVC = segue.destination as? CardDetailsViewController {
                detailsVC.card = selectedCard
            }
        }
    }
    
    
    //MARK: - Helpers
    
    func fetcCards() {
        manager.fetchCards { card in
            self.cards = card
            self.collectionView.reloadData()
        }
        
        cards.filter {$0.imageURL == ""}.first?.imageURL = "https://preview.redd.it/fr7g5swymhc41.png?width=640&crop=smart&auto=webp&s=930c8edaa0acc0755c71c3d737840d08a9e9a0b0"
    }

}
