//
//  MainViewController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 15.11.22.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var cardsLbl: UIButton!
    @IBOutlet weak var collectionLbl: UIButton!
    @IBOutlet weak var hpLbl: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI(){
        collectionLbl.translatesAutoresizingMaskIntoConstraints = false
        collectionLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        hpLbl.translatesAutoresizingMaskIntoConstraints = false
        hpLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hpLbl.topAnchor.constraint(equalTo: collectionLbl.bottomAnchor, constant: 30).isActive = true
        
        cardsLbl.translatesAutoresizingMaskIntoConstraints = false
        cardsLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardsLbl.bottomAnchor.constraint(equalTo: collectionLbl.topAnchor, constant: -30).isActive = true
        navigationController?.navigationBar.barTintColor = UIColor.black

    }
}
