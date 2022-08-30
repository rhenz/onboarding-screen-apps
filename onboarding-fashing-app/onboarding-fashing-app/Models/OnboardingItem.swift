//
//  OnboardingItem.swift
//  onboarding-fashing-app
//
//  Created by John Salvador on 8/30/22.
//

import Foundation

struct OnboardingItem {
    let authorQuote: String
    let authorName: String
}

extension OnboardingItem {
    static func createSampleData() -> [Self] {
        return [
            .init(authorQuote: "I like my money right where I can see it…hanging in my closet.", authorName: "Carrie Bradshaw"),
            .init(authorQuote: "I think there is beauty in everything. What 'normal' people perceive as ugly, I can usually see something of beauty in it.", authorName: "Alexander McQueen"),
            .init(authorQuote: "Style is something each of us already has, all we need to do is find it.", authorName: "Diane von Furstenberg"),
            .init(authorQuote: "Fashion is the armor to survive the reality of everyday life.", authorName: "Bill Cunningham"),
            .init(authorQuote: "I don't design clothes. I design dreams.", authorName: "Ralph Lauren")
        ]
    }
}
