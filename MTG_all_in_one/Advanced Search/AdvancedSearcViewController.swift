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
    private var manager = NetworkManager.shared
    
    
    private let testUrlSets = "https://api.magicthegathering.io/v1/sets"
    private let testUrlSubtypes = "https://api.magicthegathering.io/v1/subtypes"
    
    var arrSubs : [Subtypes] = [Subtypes(subtypes: ["1"])]
    var viewModel: AdvancedSearchViewModelProtocol! {
        didSet {
            viewModel.fetchSets(url: testUrlSets) {
                print("sets success")
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    self.updateUI()
                }
            }
            
            viewModel.fetchSubtypes(url: testUrlSubtypes) {
                print("subtypes success")
                    self.updateUI()
                    self.arrSubs = self.viewModel.subtypesMTG
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            self.updateUI()
        }
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
            //return arrSubs[row]
            return "Beep"
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
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let subType = arrSubs[indexPath.row]
        content.text = subType.subtypes[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateUI()
        //print(arrSubs[0].subtypes.count)
    }
    
    class TableViewCell: UITableViewCell {
        
    }

    
    func updateUI() {
        subtypesTAbleView.reloadData()
        setsPicker.reloadAllComponents()
        print("UI updated")
    }
}
