//
//  AdvancedSearcViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 4.03.23.
//

import UIKit

class AdvancedSearcViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var setsPicker: UIPickerView!
    @IBOutlet weak var subtypesPicker: UIPickerView!
    
    @IBOutlet weak var subtypesTAbleView: UITableView!
    
    
    private let testUrlSets = "https://api.magicthegathering.io/v1/sets"
    private let testUrlSubtypes = "https://api.magicthegathering.io/v1/subtypes"
    
    var arrSubs = ["card"]
    var viewModel: AdvancedSearchViewModelProtocol! {
        didSet {
            viewModel.fetchSets(url: testUrlSets) {
                print("sets success")
                self.setsPicker.reloadAllComponents()
            }
            
            viewModel.fetchSubtypes(url: testUrlSubtypes) { [self] in
                print("subtypes success")
                arrSubs = viewModel.subtypesMTG[0].subtypes
                self.subtypesTAbleView.reloadData()
                print(arrSubs)
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
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            //return viewModel.subtypesMTG[0].subtypes.count
            return arrSubs.count
        } else {
            return viewModel.setsMTG.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return "\(arrSubs[row])"
        } else {
            return viewModel.setsMTG[row].name
        }
    }
    
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
    
    class TableViewCell: UITableViewCell {
        
    }

}
