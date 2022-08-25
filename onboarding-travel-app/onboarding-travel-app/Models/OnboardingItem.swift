//
//  OnboardingItem.swift
//  onboarding-travel-app
//
//  Created by John Salvador on 8/25/22.
//

import UIKit

struct OnboardingItem {
    let title: String
    let detail: String
    let bgImage: UIImage?
}

// Demo Data
extension OnboardingItem {
    static func createItems() -> [OnboardingItem] {
        return [
            OnboardingItem(title: "Travel Your Way",
                           detail: "Travel the world by air, rail or sea at the most competitive prices",
                           bgImage: nil),
            OnboardingItem(title: "Stay Your Way",
                           detail: "With over millions of hotel worldwide, find the perfect accomodation in the most amazing places!",
                           bgImage: nil),
            OnboardingItem(title: "Discover Your Way",
                           detail: "Explore exotic destinations with our new features that link you to like-minded travelers!",
                           bgImage: nil),
            OnboardingItem(title: "Feast Your Way",
                           detail: "We recommend you local cuisines that are safe and highly recommended by the locals!",
                           bgImage: nil)
        ]
    }
}
