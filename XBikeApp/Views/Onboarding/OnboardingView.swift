//
//  OnboardingView.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        
        TabView(selection: $viewModel.currentIndex) {
            ForEach(Array(viewModel.slides.enumerated()), id: \.offset) { index, slide in
                ZStack {
                    Color.orange
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Spacer()
                        
                        Image(slide.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        Text(slide.text)
                            .font(.title3)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 20) {
                        Spacer()
                        
                        if index == viewModel.slides.count - 1 {
                            Button(action: {
                                viewModel.finishOnboarding()
                            }) {
                                Text(TextConstants.Onboarding.getStartedButton)
                                    .font(.headline)
                                    .foregroundColor(.orange)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 24)
                                    .background(Color.white)
                                    .cornerRadius(8)
                            }
                            .padding(.bottom, 40)
                        }
                    }
                }
                .tag(index)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        
    }
}

#Preview {
    OnboardingView()
}
