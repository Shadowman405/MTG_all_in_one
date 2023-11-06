//
//  CardsCollectionViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 14.11.22.
//

import UIKit

class CardsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout,searchStringProtocol {
    
    private let reuseIdentifier = "Cell"
    private let manager = NetworkManager.shared
    private let reachabilityManager = Connectivity.shared
    var testUrl = "https://api.magicthegathering.io/v1/cards?page=311"
    var searchUrl = "https://api.magicthegathering.io/v1/cards?name="
    
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
        navigationController?.navigationBar.barTintColor = UIColor.black        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsCardViewModel = viewModel.detailsViewModel(at: indexPath)
        performSegue(withIdentifier: "toDetails", sender: detailsCardViewModel)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if Connectivity.isConnectedToInternet {
            return viewModel.numberOfRows()
        } else {
            let alert = UIAlertController(title: "Alert", message: "No internet connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardCollectionViewCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return viewModel.frameSize(width: width)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            if let detailsVC = segue.destination as? CardDetailsViewController {
                detailsVC.viewModel = sender as? CardDetailsViewModelProtocol
                detailsVC.activateButon = true
            }
        } else if segue.identifier == "toAdvancedSearch"{
            if let advSearchVC = segue.destination as? AdvancedSearcViewController {
                advSearchVC.delegate = self
            }
        }
    }
    
    //MARK: - Protocol method
    func updateSearchString(seacrhString: String) {
        searchUrl = seacrhString
        print(searchUrl)
    }
    
    func showSearchBar() {
        searchController.isActive = true
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
        if let searchBarText = searchController.searchBar.text {
            filterContentForSearchText(searchBarText)
        } else {
            return
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        viewModel.fetchCards(url: "\(searchUrl)\(searchText)") {
            
            self.collectionView.reloadData()
            print("\(self.searchUrl)\(searchText)")
        }
       // self.collectionView.reloadData()
//        viewModel.cards.filter {$0.imageURL == ""}.first?.imageURL = "https://preview.redd.it/fr7g5swymhc41.png?width=640&crop=smart&auto=webp&s=930c8edaa0acc0755c71c3d737840d08a9e9a0b0"
    }
}
