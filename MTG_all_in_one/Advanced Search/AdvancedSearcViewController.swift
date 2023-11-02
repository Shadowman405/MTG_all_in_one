//
//  AdvancedSearcViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 4.03.23.
//

import UIKit

class AdvancedSearcViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
        case 0: searchStringPickerValue = viewModel.searchSetSegment; updateUI()
        case 1: searchStringPickerValue = viewModel.searchSubtypeSegment; updateUI()
        case 2: searchStringPickerValue = viewModel.searchTypeSegment; updateUI()
        case 3: searchStringPickerValue = viewModel.searchSupertypeSegment; updateUI()
        case 4: searchStringPickerValue = viewModel.searchFormatSegment; updateUI()
        default: searchStringPickerValue = "&set="
        }
    }
    
//MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(segmnetedControlIndex: selectSegmentControl.selectedSegmentIndex)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        if selectSegmentControl.selectedSegmentIndex == 0 {
            let subType = arrSets[indexPath.row]
            content.text = subType.name
            cell.contentConfiguration = content
            return cell
        } else if selectSegmentControl.selectedSegmentIndex == 1 {
            let subType = arrSubs[0].subtypes[indexPath.row]
            content.text = subType
            cell.contentConfiguration = content
            return cell
        } else if selectSegmentControl.selectedSegmentIndex == 2 {
            let type = arrTypes[0].types[indexPath.row]
            content.text = type
            cell.contentConfiguration = content
            return cell
        } else if selectSegmentControl.selectedSegmentIndex == 3 {
            let supertype = arrSupertypes[0].supertypes[indexPath.row]
            content.text = supertype
            cell.contentConfiguration = content
            return cell
        } else if selectSegmentControl.selectedSegmentIndex == 4 {
            let format = arrFormats[0].formats[indexPath.row]
            content.text = format
            cell.contentConfiguration = content
            return cell
        }
        else {
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectSegmentControl.selectedSegmentIndex == 0 {
            viewModel.searchSetValue = arrSets[indexPath.row].code
            setLbl.text = "&set=\(viewModel.searchSetValue)"
            print(viewModel.searchSetValue)
        }
        else if selectSegmentControl.selectedSegmentIndex == 1 {
            viewModel.searchSubtypeValue = arrSubs[0].subtypes[indexPath.row]
            subtypeLbl.text = "&subtypes=\(viewModel.searchSubtypeValue)"
            print(viewModel.searchSubtypeValue)
        }
        else if selectSegmentControl.selectedSegmentIndex == 2 {
            viewModel.searchTypeValue = arrTypes[0].types[indexPath.row]
            typeLbl.text = "&types=\(viewModel.searchTypeValue)"
            print(viewModel.searchTypeValue)
        }
        else if selectSegmentControl.selectedSegmentIndex == 3 {
            viewModel.searchSupertypeValue = arrSupertypes[0].supertypes[indexPath.row]
            supertypeLbl.text = "&supertypes=\(viewModel.searchSupertypeValue)"
            print(viewModel.searchSupertypeValue)
        }
        else if selectSegmentControl.selectedSegmentIndex == 4 {
            viewModel.searchFormatValue = arrFormats[0].formats[indexPath.row]
            formatLbl.text = "&formats=\(viewModel.searchFormatValue)"
            print(viewModel.searchFormatValue)
        }
    }
    
    class TableViewCell: UITableViewCell {}

//MARK: - Other funcs
    func updateUI() {
        subtypesTAbleView.reloadData()
        arrSubs = viewModel.subtypesMTG
        arrSets = viewModel.setsMTG
        arrTypes = viewModel.typesMTG
        arrSupertypes = viewModel.supertypesMTG
        arrFormats = viewModel.formatsMTG
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
//MARK: - Buttons
    @IBAction func searchBtnPressed(_ sender: Any) {
        if let set = setLbl.text, let subtype = subtypeLbl.text,
           let type = typeLbl.text,
           let supertype = supertypeLbl.text, let format = formatLbl.text {
            print("\(mainSearchString)\(set)\(subtype)\(type)\(supertype)\(format)&name=")
        }
        dismiss(animated: true)
    }
    
    @IBAction func clearFiltersPressed(_ sender: Any) {
        clearLabel()
    }
}


// MARK: - protocols and extensions

protocol searchStringProtocol {
    func updateSearchString(seacrhString: String)
    func showSearchBar()
}

extension AdvancedSearcViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text ?? "")
    }
    
    func filterContentForSearchText(_ searchText: String) {
        self.subtypesTAbleView.reloadData()
        print(searchText)
    }
}
