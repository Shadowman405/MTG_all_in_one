//
//  AdvancedSearcViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 4.03.23.
//

import UIKit

class AdvancedSearcViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var testLbl: UILabel!
    @IBOutlet weak var subtypesTestLbl: UILabel!
    @IBOutlet weak var setsPicker: UIPickerView!
    
    
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
                if viewModel.subtypesMTG.isEmpty {
                    subtypesTestLbl.text = "Waiting for data - subtypes"
                } else {
                    subtypesTestLbl.text = "\(viewModel.subtypesMTG[0].subtypes)"
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setsPicker.delegate = self
        self.setsPicker.dataSource = self
        
        viewModel = AdvancedSearchViewModel()
        
        if viewModel.setsMTG.isEmpty {
            testLbl.text = "Sets - Waiting for data"
        } else {
            testLbl.text = viewModel.setsMTG[0].name
        }

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.setsMTG.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.setsMTG[row].name
    }

}
