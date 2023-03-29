//
//  AdvancedSearcViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 4.03.23.
//

import UIKit

class AdvancedSearcViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var setsPicker: UIPickerView!
    @IBOutlet weak var subtypesTAbleView: UITableView!
    @IBOutlet weak var typesPicker: UIPickerView!
    @IBOutlet weak var formatsPicker: UIPickerView!
    @IBOutlet weak var supertypesPicker: UIPickerView!
    private var manager = NetworkManager.shared
    
    
    private let testUrlSets = "https://api.magicthegathering.io/v1/sets"
    private let testUrlSubtypes = "https://api.magicthegathering.io/v1/subtypes"
    
    var arrSubs = ["card"]
    var viewModel: AdvancedSearchViewModelProtocol! {
        didSet {
            viewModel.fetchSets(url: testUrlSets) {
                print("sets success")
                self.updateUI()
            }
            
            viewModel.fetchSubtypes(url: testUrlSubtypes) {
                print("subtypes success")
                self.updateUI()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setsPicker.delegate = self
        self.setsPicker.dataSource = self
        
        self.subtypesTAbleView.delegate = self
        self.subtypesTAbleView.dataSource = self
        self.subtypesTAbleView.register(TableViewCell.self, forCellReuseIdentifier: "subCell")
        
        viewModel = AdvancedSearchViewModel()
        print(manager.types.count)
    }
    
    //MARK: - Pickers Logic and Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            //return viewModel.subtypesMTG[0].subtypes.count
            return arrSubs.count
        } else if pickerView.tag == 2 {
            return manager.types.count
        } else if pickerView.tag == 3 {
            return manager.formats.count
        } else if pickerView.tag == 4 {
            return manager.supertypes.count
        }
        else {
            return 3
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return arrSubs[row]
        } else if pickerView.tag == 2 {
            return manager.types[row]
        } else if pickerView.tag == 3 {
            return manager.formats[row]
        } else if pickerView.tag == 4 {
            return manager.supertypes[row]
        } else {
            return viewModel.setsMTG[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateUI()
    }
    
    //MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = arrSubs[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateUI()
    }
    
    class TableViewCell: UITableViewCell {
        
    }

    
    private func updateUI() {
        subtypesTAbleView.reloadData()
        setsPicker.reloadAllComponents()
        typesPicker.reloadAllComponents()
        formatsPicker.reloadAllComponents()
        supertypesPicker.reloadAllComponents()
        print("UI updated")
    }
}
