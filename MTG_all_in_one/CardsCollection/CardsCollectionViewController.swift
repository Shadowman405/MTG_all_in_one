//
//  CardsCollectionViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 14.11.22.
//

import UIKit

class CardsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let reuseIdentifier = "Cell"
    private let manager = NetworkManager.shared
    private let testUrl = "https://api.magicthegathering.io/v1/cards?page=311"
    
    let searchController = UISearchController(searchResultsController: nil)
    var selectedCard: CardMTG!
    
    
    private var viewModel: CardCollectionViewModelProtocol! {
        didSet {
            viewModel.fetchCards(url: testUrl) {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CardCollectionViewModel()
        
        UIApplication.shared.isIdleTimerDisabled = false
        collectionView.backgroundColor = .lightGray
        setupSearchController()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //selectedCard = viewModel.cards[indexPath.item]
        let detailsCardViewModel = viewModel.cellViewModel(at: indexPath)
        performSegue(withIdentifier: "toDetails", sender: detailsCardViewModel)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardCollectionViewCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = (width - 40) / 2
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            if let detailsVC = segue.destination as? CardDetailsViewController {
                detailsVC.viewModel = sender as? CardDetailsViewModelProtocol
                detailsVC.activateButon = true
            }
        }
    }
}


//MARK: - Search Bar and logic

extension CardsCollectionViewController: UISearchResultsUpdating {
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cards"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        viewModel.fetchCards(url: "https://api.magicthegathering.io/v1/cards?name=\(searchText)") {
            self.collectionView.reloadData()
        }
        
        viewModel.cards.filter {$0.imageURL == ""}.first?.imageURL = "https://preview.redd.it/fr7g5swymhc41.png?width=640&crop=smart&auto=webp&s=930c8edaa0acc0755c71c3d737840d08a9e9a0b0"
    }
}
