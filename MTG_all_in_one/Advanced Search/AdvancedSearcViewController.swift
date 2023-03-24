//
//  AdvancedSearcViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 4.03.23.
//

import UIKit

class AdvancedSearcViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var setsPicker: UIPickerView!
    @IBOutlet weak var subtypesPicker: UIPickerView!
    
    
    private let testUrlSets = "https://api.magicthegathering.io/v1/sets"
    private let testUrlSubtypes = "https://api.magicthegathering.io/v1/subtypes"
    
    var arrSubs = [String]()
    var viewModel: AdvancedSearchViewModelProtocol! {
        didSet {
            viewModel.fetchSets(url: testUrlSets) {
                print("sets success")
                self.setsPicker.reloadAllComponents()
            }
            
            viewModel.fetchSubtypes(url: testUrlSubtypes) { [self] in
                print("subtypes success")
                self.subtypesPicker.reloadAllComponents()
                arrSubs = viewModel.subtypesMTG[0].subtypes
                print(arrSubs)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setsPicker.delegate = self
        self.setsPicker.dataSource = self
        
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.view.endEditing(false)
        if pickerView.tag == 1 {
            subtypesPicker.selectRow(0, inComponent: 0, animated: true)
            subtypesPicker.reloadAllComponents()
        } else {
            subtypesPicker.selectRow(0, inComponent: 0, animated: true)
            subtypesPicker.reloadAllComponents()
        }
    }

}
