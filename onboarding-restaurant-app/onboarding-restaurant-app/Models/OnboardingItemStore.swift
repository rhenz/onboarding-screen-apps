//
//  OnboardingItemStore.swift
//  onboarding-restaurant-app
//
//  Created by John Salvador on 9/6/22.
//

import Foundation

class OnboardingItemStore {
    
    // MARK: - Properties
    
    let items: [OnboardingItem]
    
    // MARK: - Init
    
    init(with items: [OnboardingItem] = OnboardingItemStore.arrangedOnboardingItems) {
        self.items = items
    }
}

// MARK: -

extension OnboardingItemStore {
    private static let arrangedOnboardingItems: [OnboardingItem] = [
        // 1st
        .init(title: "Get your favorite food delivered to you under 30 minutes!", animationName: "", buttonColor: .systemYellow, buttonTitle: "Next"),
        
        // 2nd
        .init(title: "We serve only from selected restaurants in your area.", animationName: "", buttonColor: .systemGreen, buttonTitle: "Order Now")
    ]
}
