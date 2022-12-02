//
//  AlertController.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 2.12.22.
//

import UIKit

extension UIAlertController {
    static func createAlert(withTitle title: String, andMessage message:String) -> UIAlertController {
        UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    func action(completion: @escaping (String) -> Void) {
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else {return}
            guard !newValue.isEmpty else {return}
            completion(newValue)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField{ txtField in
            txtField.placeholder = "Collection Name"
        }
    }
    
}
