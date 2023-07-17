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
    
    @IBOutlet weak var addFilterBtn: UIButton!
    @IBOutlet weak var clearFilterBtn: UIButton!
    
    
    
    private var manager = NetworkManager.shared
    
    
    private let testUrlSets = "https://api.magicthegathering.io/v1/sets"
    private let testUrlSubtypes = "https://api.magicthegathering.io/v1/subtypes"
    private var searchStringValue = ""
    private var searchStringPickerValue = "set="
    
    private var arrSubs : [Subtypes] = NetworkManager.shared.mockSubtypesArr
    private var arrSets : [SetMTG] = NetworkManager.shared.mockSetArr
    
    
    var viewModel: AdvancedSearchViewModelProtocol! {
        didSet {
            viewModel.fetchSets(url: testUrlSets) {
                    self.updateUI()
            }
            
            viewModel.fetchSubtypes(url: testUrlSubtypes) {
                    self.updateUI()
//                    self.arrSubs = self.viewModel.subtypesMTG
//                    self.arrSets = self.viewModel.setsMTG
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subtypesTAbleView.delegate = self
        self.subtypesTAbleView.dataSource = self
        self.subtypesTAbleView.register(TableViewCell.self, forCellReuseIdentifier: "subCell")
        
        viewModel = AdvancedSearchViewModel()
        
        
        configureSegmentControl()
        
        addFilterBtn.backgroundColor = .green
        addFilterBtn.layer.cornerRadius = 10
        clearFilterBtn.backgroundColor = .red
        clearFilterBtn.layer.cornerRadius = 10
    }
    
    //MARK: - Segmant control logic
    
    @IBAction func segmentControlPressed(_ sender: UISegmentedControl) {
        switch selectSegmentControl.selectedSegmentIndex {
        case 0: searchStringPickerValue = viewModel.searchSetSegmentValue; updateUI()
        case 1: searchStringPickerValue = "&subtype="; updateUI()
        case 2: searchStringPickerValue = "&supertype="
        case 3: searchStringPickerValue = "&type="
        case 4: searchStringPickerValue = "&format="
        default: searchStringPickerValue = "&set="
        }
        
    }
    
    func configureSegmentControl() {
        selectSegmentControl.setWidth(80, forSegmentAt: 2)
        selectSegmentControl.backgroundColor = .green
    }
    
    //MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //viewModel.numberOfRows()
        
        viewModel.numberOfRows(segmnetedControlIndex: selectSegmentControl.selectedSegmentIndex)
        
//        if selectSegmentControl.selectedSegmentIndex == 0 {
//            return arrSets.count
//        } else {
//            return arrSubs[0].subtypes.count
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        if selectSegmentControl.selectedSegmentIndex == 0 {
            let subType = arrSets[indexPath.row]
            content.text = subType.name
            cell.contentConfiguration = content
            return cell
        } else {
            let subType = arrSubs[0].subtypes[indexPath.row]
            content.text = subType
            cell.contentConfiguration = content
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(arrSubs[0].subtypes[indexPath.row])
        viewModel.searchSetValue = arrSubs[0].subtypes[indexPath.row]
        print(viewModel.searchSetValue)
    }
    
    class TableViewCell: UITableViewCell {
        
    }

    
    func updateUI() {
        subtypesTAbleView.reloadData()
        arrSubs = viewModel.subtypesMTG
        arrSets = viewModel.setsMTG
        
        print(arrSubs.count)
    }
    //MARK: - Search button
    @IBAction func searchBtnPressed(_ sender: Any) {
        let mainSearchString = "https://api.magicthegathering.io/v1/cards?"
        print("\(mainSearchString)\(viewModel.searchSetSegmentValue)\(viewModel.searchSetValue)")
        self.dismiss(animated: true)
    }
    
    @IBAction func clearFiltersPressed(_ sender: Any) {
        
    }
    
    
}
