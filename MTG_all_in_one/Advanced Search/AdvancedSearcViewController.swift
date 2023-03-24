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
    
    var viewModel: AdvancedSearchViewModelProtocol! {
        didSet {
            viewModel.fetchSets(url: testUrlSets) {
                print("sets success")
                self.setsPicker.reloadAllComponents()
            }
            
            viewModel.fetchSubtypes(url: testUrlSubtypes) { [self] in
                print("subtypes success")
                self.subtypesPicker.reloadAllComponents()
                print(viewModel.subtypesMTG)
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
        if pickerView.tag == 0 {
            return viewModel.subtypesMTG[0].subtypes.count
        } else {
            return viewModel.setsMTG.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return viewModel.subtypesMTG[0].subtypes[row]
        } else {
            return viewModel.setsMTG[row].name
        }
    }

}
