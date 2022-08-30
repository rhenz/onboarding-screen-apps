//
//  OnboardingItem.swift
//  onboarding-fashing-app
//
//  Created by John Salvador on 8/30/22.
//

import Foundation

struct OnboardingItem {
    let authorName: String
    let authorQuote: String
}

extension OnboardingItem {
    static func createSampleData() -> [Self] {
        return [
            .init(authorName: "I like my money right where I can see it…hanging in my closet.", authorQuote: "Carrie Bradshaw"),
            .init(authorName: "I think there is beauty in everything. What 'normal' people perceive as ugly, I can usually see something of beauty in it.", authorQuote: "Alexander McQueen"),
            .init(authorName: "Style is something each of us already has, all we need to do is find it.", authorQuote: "Diane von Furstenberg"),
            .init(authorName: "Fashion is the armor to survive the reality of everyday life.", authorQuote: "Bill Cunningham"),
            .init(authorName: "I don't design clothes. I design dreams.", authorQuote: "Ralph Lauren")
        ]
    }
}
