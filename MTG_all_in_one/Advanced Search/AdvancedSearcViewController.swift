//
//  AdvancedSearcViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 4.03.23.
//

import UIKit

class AdvancedSearcViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
//TV & SC
    @IBOutlet weak var selectSegmentControl: UISegmentedControl!
    @IBOutlet weak var subtypesTAbleView: UITableView!
//Buttoms
    @IBOutlet weak var addFilterBtn: UIButton!
    @IBOutlet weak var clearFilterBtn: UIButton!
//Labels
    @IBOutlet weak var setLbl: UILabel!
    @IBOutlet weak var subtypeLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var supertypeLbl: UILabel!
    @IBOutlet weak var formatLbl: UILabel!
 
//Variables
    
    var delegate: searchStringProtocol?
    private var manager = NetworkManager.shared
    private var searchStringPickerValue = "set="
    var mainSearchString = "https://api.magicthegathering.io/v1/cards?"

    private var arrSubs : [Subtypes] = NetworkManager.shared.mockSubtypesArr
    private var arrSets : [SetMTG] = NetworkManager.shared.mockSetArr
    private var arrTypes: [Types] = NetworkManager.shared.mockTypesArr
    private var arrSupertypes: [Supertypes] = NetworkManager.shared.mockSupertypes
    private var arrFormats: [Formats] = NetworkManager.shared.mockFormats
    
//SearchController
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    let searchController = UISearchController(searchResultsController: nil)
    private var arrSetsFiltered = [SetMTG]()
    private var arrSubtypesFiltered = [Subtypes(subtypes: ["Waiting for data..."])]
    
//ViewModel
    var viewModel: AdvancedSearchViewModelProtocol! {
        didSet {
            viewModel.fetchSets(url: NetworkManager.shared.testUrlSets) {
                    self.updateUI()
            }
            viewModel.fetchSubtypes(url: NetworkManager.shared.testUrlSubtypes) {
                    self.updateUI()
            }
            viewModel.fetchTypes(url: NetworkManager.shared.testUrlTypes) {
                    self.updateUI()
            }
            viewModel.fetchSupertypes(url: NetworkManager.shared.testUrlSupertypes) {
                self.updateUI()
            }
            viewModel.fetchFormats(url: NetworkManager.shared.testUrlFormats) {
                self.updateUI()
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
        updateButtonsUI()
        clearLabel()
        setupSearchController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let set = setLbl.text, let subtype = subtypeLbl.text,
           let type = typeLbl.text,
           let supertype = supertypeLbl.text, let format = formatLbl.text {
            delegate?.updateSearchString(seacrhString: "\(mainSearchString)\(set)\(subtype)\(type)\(supertype)\(format)&name=")
        }
        delegate?.showSearchBar()
    }
    
//MARK: - Segmant control logic
    @IBAction func segmentControlPressed(_ sender: UISegmentedControl) {
        switch selectSegmentControl.selectedSegmentIndex {
        case 0: searchStringPickerValue = viewModel.searchSetSegment; updateUI(); presentSearchBar(false)
        case 1: searchStringPickerValue = viewModel.searchSubtypeSegment; updateUI(); presentSearchBar(false)
        case 2: searchStringPickerValue = viewModel.searchTypeSegment; updateUI(); presentSearchBar(true)
        case 3: searchStringPickerValue = viewModel.searchSupertypeSegment; updateUI(); presentSearchBar(true)
        case 4: searchStringPickerValue = viewModel.searchFormatSegment; updateUI(); presentSearchBar(true)
        default: searchStringPickerValue = "&set="
        }
    }
    
//MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering && selectSegmentControl.selectedSegmentIndex == 0 {
            return arrSetsFiltered.count
        } else if isFiltering && selectSegmentControl.selectedSegmentIndex == 1 {
            return arrSubtypesFiltered[0].subtypes.count
        }
        return viewModel.numberOfRows(segmnetedControlIndex: selectSegmentControl.selectedSegmentIndex)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        returnCellHandler(tableView, cellForRowAt: indexPath) // logic move to extension for tableVC
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        returnSelectedRow(tableView, didSelectRowAt: indexPath) // logic move to extension for tableVC
    }
//MARK: - buttons
    @IBAction func searchBtnPressed(_ sender: Any) {
        if let set = setLbl.text, let subtype = subtypeLbl.text,
           let type = typeLbl.text,
           let supertype = supertypeLbl.text, let format = formatLbl.text {
            print("\(mainSearchString)\(set)\(subtype)\(type)\(supertype)\(format)&name=")
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearFiltersPressed(_ sender: Any) {
        clearLabel()
    }
}

 

// MARK: - PROTOCOLS & EXTENSIONS

protocol searchStringProtocol {
    func updateSearchString(seacrhString: String)
    func showSearchBar()
}

extension AdvancedSearcViewController: UISearchResultsUpdating {
    class TableViewCell: UITableViewCell {}
    
    // MARK: - searchcontroller
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text ?? "")
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if selectSegmentControl.selectedSegmentIndex == 0 {
            if searchText.isEmpty == false {
                arrSetsFiltered = arrSets.filter { (setMtg: SetMTG) -> Bool in
                    return setMtg.name.lowercased().contains(searchText.lowercased())
                }
            } else {
                arrSetsFiltered = arrSets
            }
        } else {
            arrSubtypesFiltered[0].subtypes = arrSubs[0].subtypes.filter({ subtype -> Bool in
                return subtype.lowercased().contains(searchText.lowercased())
            })
        }
        subtypesTAbleView.reloadData()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.isActive = true
    }
    
    func presentSearchBar(_ bool: Bool) {
        searchController.searchBar.isHidden = bool
    }
    
    //MARK: - Handlers for tablewview funcs
    func returnCellHandler(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        switch selectSegmentControl.selectedSegmentIndex {
        case 0:
            let setType: SetMTG
            if isFiltering && arrSetsFiltered.count != 0{
                setType = arrSetsFiltered[indexPath.row]
            } else {
                setType = arrSets[indexPath.row]
            }
            content.text = setType.name
            cell.contentConfiguration = content
            return cell
        case 1:
            var subType: [String]
            if isFiltering {
                subType = arrSubtypesFiltered[0].subtypes
            } else {
                subType = arrSubs[0].subtypes
            }
            content.text = subType[indexPath.row]
            cell.contentConfiguration = content
            return cell
        case 2:
            let type = arrTypes[0].types[indexPath.row]
            content.text = type
            cell.contentConfiguration = content
            return cell
        case 3:
            let supertype = arrSupertypes[0].supertypes[indexPath.row]
            content.text = supertype
            cell.contentConfiguration = content
            return cell
        case 4:
            let format = arrFormats[0].formats[indexPath.row]
            content.text = format
            cell.contentConfiguration = content
            return cell
        default:
            return cell
        }
    }
    //
    func returnSelectedRow(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch selectSegmentControl.selectedSegmentIndex{
        case 0:
                        if isFiltering {
                            viewModel.searchSetValue = arrSetsFiltered[indexPath.row].code
                            setLbl.text = "&set=\(viewModel.searchSetValue)"
                          } else {
                              viewModel.searchSetValue = arrSets[indexPath.row].code
                              setLbl.text = "&set=\(viewModel.searchSetValue)"
                          }
        case 1:
                        if isFiltering {
                            viewModel.searchSubtypeValue = arrSubtypesFiltered[0].subtypes[indexPath.row]
                            subtypeLbl.text = "&subtypes=\(viewModel.searchSubtypeValue)"
                        } else {
                            viewModel.searchSubtypeValue = arrSubs[0].subtypes[indexPath.row]
                            subtypeLbl.text = "&subtypes=\(viewModel.searchSubtypeValue)"
                        }
        case 2:
                        viewModel.searchTypeValue = arrTypes[0].types[indexPath.row]
                        typeLbl.text = "&types=\(viewModel.searchTypeValue)"
        case 3:
                        viewModel.searchSupertypeValue = arrSupertypes[0].supertypes[indexPath.row]
                        supertypeLbl.text = "&supertypes=\(viewModel.searchSupertypeValue)"
        case 4:
                        viewModel.searchFormatValue = arrFormats[0].formats[indexPath.row]
                        formatLbl.text = "&formats=\(viewModel.searchFormatValue)"
        default:
            viewModel.searchFormatValue = arrFormats[0].formats[indexPath.row]
            formatLbl.text = "&formats=\(viewModel.searchFormatValue)"
        }
    }
    //MARK: - Other funcs
        func updateUI() {
            subtypesTAbleView.reloadData()
            arrSubs = viewModel.subtypesMTG
            arrSets = viewModel.setsMTG
            arrTypes = viewModel.typesMTG
            arrSupertypes = viewModel.supertypesMTG
            arrFormats = viewModel.formatsMTG
            navigationController?.navigationBar.transparentNavigationBar()
        }
        
        func updateButtonsUI() {
            addFilterBtn.backgroundColor = .green
            addFilterBtn.layer.cornerRadius = 10
            clearFilterBtn.backgroundColor = .red
            clearFilterBtn.layer.cornerRadius = 10
        }
        
        func configureSegmentControl() {
            selectSegmentControl.setWidth(80, forSegmentAt: 2)
            selectSegmentControl.backgroundColor = .green
        }
        
        func clearLabel(){
            setLbl.text = ""
            subtypeLbl.text = ""
            typeLbl.text = ""
            supertypeLbl.text = ""
            formatLbl.text = ""
        }
}
