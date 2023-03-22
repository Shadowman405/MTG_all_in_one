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
            viewModel.fetchSets(url: testUrl) { [self] in
                print("success")
                testLbl.text = viewModel.setsMTG[0].name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel = AdvancedSearchViewModel()
    }

}
