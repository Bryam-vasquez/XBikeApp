//
//  OnboardingViewModel.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import Foundation
import Combine

class OnboardingViewModel:ObservableObject {
    
    @Published private(set) var slides: [OnboardingSlide] = [
        OnboardingSlide(
            imageName: TextConstants.Onboarding.Icons.easyIcon,
            text: TextConstants.Onboarding.slide1
        ),
        OnboardingSlide(
            imageName: TextConstants.Onboarding.Icons.timeIcon,
            text: TextConstants.Onboarding.slide2
        ),
        OnboardingSlide(
            imageName: TextConstants.Onboarding.Icons.progressIcon,
            text: TextConstants.Onboarding.slide3
        )
    ]
    
    @Published var currentIndex: Int = 0
    
    var isLastSlide: Bool {
        currentIndex == slides.count - 1
    }
    
    func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: Constants.Configuration.onboardingStorage)
    }
}
