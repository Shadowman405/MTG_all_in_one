//
//  HapticManager.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 2.03.23.
//

import UIKit

final class HapticManager {
    static let shared = HapticManager()
    
    private init() {}
    
    public func selectionVibrate() {
        DispatchQueue.main.async {
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.prepare()
            selectionFeedbackGenerator.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        } 
    }
}

