//
//  NavBarExtension.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 9.11.23.
//

import UIKit

extension UINavigationBar {
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
