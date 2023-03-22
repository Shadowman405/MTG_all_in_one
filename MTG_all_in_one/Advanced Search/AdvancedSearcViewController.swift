//
//  AdvancedSearcViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 4.03.23.
//

import UIKit

class AdvancedSearcViewController: UIViewController {
    
    @IBOutlet weak var testLbl: UILabel!
    @IBOutlet weak var subtypesTestLbl: UILabel!
    
    
    private let testUrlSets = "https://api.magicthegathering.io/v1/sets"
    private let testUrlSubtypes = "https://api.magicthegathering.io/v1/subtypes"
    
    var viewModel: AdvancedSearchViewModelProtocol! {
        didSet {
            viewModel.fetchSets(url: testUrlSets) {
                print("sets success")
            }
            
            viewModel.fetchSubtypes(url: testUrlSubtypes) { [self] in
                print("subtypes success")
                if viewModel.subtypesMTG.isEmpty {
                    subtypesTestLbl.text = "Waiting for data - subtypes"
                } else {
                    subtypesTestLbl.text = viewModel.subtypesMTG[0].subtypes[0]
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel = AdvancedSearchViewModel()
        
        if viewModel.setsMTG.isEmpty {
            testLbl.text = "Sets - Waiting for data"
        } else {
            testLbl.text = viewModel.setsMTG[0].name
        }

    }

}
