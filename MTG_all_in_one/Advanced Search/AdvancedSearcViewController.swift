//
//  AdvancedSearcViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 4.03.23.
//

import UIKit

class AdvancedSearcViewController: UIViewController {
    
    @IBOutlet weak var testLbl: UILabel!
    private let testUrl = "https://api.magicthegathering.io/v1/sets"
    var viewModel: AdvancedSearchViewModelProtocol! {
        didSet {
            viewModel.fetchSets(url: testUrl) {
                
                print("success")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel = AdvancedSearchViewModel()
        
        if viewModel.setsMTG.isEmpty {
            testLbl.text = "Waiting for data"
        } else {
            testLbl.text = viewModel.setsMTG[0].name
        }

    }

}
