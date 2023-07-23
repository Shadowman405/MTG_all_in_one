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

    
    @IBOutlet weak var setLbl: UILabel!
    @IBOutlet weak var subtypeLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var supertypeLbl: UILabel!
    @IBOutlet weak var formatLbl: UILabel!
    
    
    
    
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
            print(viewModel.searchSetValue)
        }
        else if selectSegmentControl.selectedSegmentIndex == 1 {
            viewModel.searchSubtypeValue = arrSubs[0].subtypes[indexPath.row]
            print(viewModel.searchSubtypeValue)
        }
        else if selectSegmentControl.selectedSegmentIndex == 2 {
            viewModel.searchTypeValue = arrTypes[0].types[indexPath.row]
            print(viewModel.searchTypeValue)
        }
        else if selectSegmentControl.selectedSegmentIndex == 3 {
            viewModel.searchSupertypeValue = arrSupertypes[0].supertypes[indexPath.row]
            print(viewModel.searchSupertypeValue)
        }
        else if selectSegmentControl.selectedSegmentIndex == 4 {
            viewModel.searchFormatValue = arrFormats[0].formats[indexPath.row]
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
//MARK: - Buttons
    @IBAction func searchBtnPressed(_ sender: Any) {

        if selectSegmentControl.selectedSegmentIndex == 0 {
//            mainSearchString.append("\(viewModel.searchSetSegment)\(viewModel.searchSetValue)")
            setLbl.text = "&set=\(viewModel.searchSetValue)"
            print(mainSearchString)
        }
        else if selectSegmentControl.selectedSegmentIndex == 1 {
//            mainSearchString.append("\(viewModel.searchSubtypeSegment)\(viewModel.searchSubtypeValue)")
            subtypeLbl.text = "&subtypes=\(viewModel.searchSubtypeValue)"
            print(mainSearchString)
        }
        else if selectSegmentControl.selectedSegmentIndex == 2 {
            //mainSearchString.append("\(viewModel.searchTypeSegment)\(viewModel.searchTypeValue)")
            typeLbl.text = "&types=\(viewModel.searchTypeValue)"
            print(mainSearchString)
        }
        else if selectSegmentControl.selectedSegmentIndex == 3 {
            //mainSearchString.append("\(viewModel.searchSupertypeSegment)\(viewModel.searchSupertypeValue)")
            supertypeLbl.text = "&supertypes=\(viewModel.searchSupertypeValue)"
            print(mainSearchString)
        }
        else if selectSegmentControl.selectedSegmentIndex == 4 {
            //mainSearchString.append("\(viewModel.searchFormatSegment)\(viewModel.searchFormatValue)")
            formatLbl.text = "&formats=\(viewModel.searchFormatValue)"
            print(mainSearchString)
        }
    }
    
    @IBAction func clearFiltersPressed(_ sender: Any) {
        //updateUI()
        let tempString = "https://api.magicthegathering.io/v1/cards?"
        mainSearchString = tempString
        print(mainSearchString)
    }
}
