//
//  OnboardingViewModelTests.swift
//  XBikeAppTests
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import XCTest
@testable import XBikeApp

final class OnboardingViewModelTests: XCTestCase {

    func testInitialState() {
        let viewModel = OnboardingViewModel()
        
        XCTAssertEqual(viewModel.currentIndex, 0)
        XCTAssertFalse(viewModel.isLastSlide)
    }
    
    func testIsLastSlide() {
        let viewModel = OnboardingViewModel()
        viewModel.currentIndex = 2
        XCTAssertTrue(viewModel.isLastSlide, "El índice 2 debería ser la última slide")
    }
    
    func testFinishOnboardingSetsUserDefault() {
        let viewModel = OnboardingViewModel()
        UserDefaults.standard.removeObject(forKey: "hasSeenOnboarding")
        
        viewModel.finishOnboarding()

        let hasSeen = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        XCTAssertTrue(hasSeen, "finishOnboarding() debería marcar hasSeenOnboarding en UserDefaults")
    }
}
