//
//  AdvancedSearcViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 4.03.23.
//

import UIKit

class AdvancedSearcViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var selectSegmentControl: UISegmentedControl!
    @IBOutlet weak var subtypesTAbleView: UITableView!
    private var manager = NetworkManager.shared
    
    
    private let testUrlSets = "https://api.magicthegathering.io/v1/sets"
    private let testUrlSubtypes = "https://api.magicthegathering.io/v1/subtypes"
    
    var arrSubs : [Subtypes] = [Subtypes(subtypes: ["1"])]
    var viewModel: AdvancedSearchViewModelProtocol! {
        didSet {
            viewModel.fetchSets(url: testUrlSets) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    self.updateUI()
                }
            }
            
            viewModel.fetchSubtypes(url: testUrlSubtypes) {
                    self.updateUI()
                    self.arrSubs = self.viewModel.subtypesMTG
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subtypesTAbleView.delegate = self
        self.subtypesTAbleView.dataSource = self
        self.subtypesTAbleView.register(TableViewCell.self, forCellReuseIdentifier: "subCell")
        
        viewModel = AdvancedSearchViewModel()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
//            self.updateUI()
//        }
    }
    
    //MARK: - Pickers Logic and Methods
    
    
    //MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return arrSubs[0].subtypes.count
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let subType = arrSubs[0].subtypes[indexPath.row]
        content.text = subType
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(arrSubs[0].subtypes[indexPath.row])
    }
    
    class TableViewCell: UITableViewCell {
        
    }

    
    func updateUI() {
        subtypesTAbleView.reloadData()
        self.arrSubs = self.viewModel.subtypesMTG
        print("UI updated")
    }
}
