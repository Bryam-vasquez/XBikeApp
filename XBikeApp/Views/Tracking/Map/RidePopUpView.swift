//
//  CurrentRidePopUpView.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 30/03/25.
//

import SwiftUI

struct RidePopupView: View {
    @ObservedObject var viewModel: CurrentRideViewModel
    var dismissAction: () -> Void

    var body: some View {
        VStack {
            Spacer()
        
            VStack(spacing: 20) {
                if viewModel.isTracking {
                    Text(viewModel.elapsedTimeText)
                        .font(.largeTitle)
                        .padding(.top, 20)
                    
                    HStack(spacing: 20) {
                        Button(action: {}) {
                            Text("Start")
                                .font(.headline)
                                .foregroundColor(.orange)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Rectangle()
                            .frame(width: 1, height: 22)
                            .foregroundColor(.orange)
                        
                        Button(action: {
                            viewModel.stopRide()
                        }) {
                            Text("Stop")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 20)
                    
                } else if viewModel.ride != nil {
                    VStack(spacing: 8) {
                        Text("Your time was")
                            .font(.headline)
                        Text(viewModel.elapsedTimeText)
                            .font(.largeTitle)
                        
                        Text("Your distance was")
                            .font(.headline)
                        Text(viewModel.distanceText)
                            .font(.largeTitle)
                    }
                    .padding(.top, 20)
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            viewModel.saveRide()
                            dismissAction()
                        }) {
                            Text("Store")
                                .font(.headline)
                                .foregroundColor(.orange)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Rectangle()
                            .frame(width: 1, height: 22)
                            .foregroundColor(.orange)
                        
                        Button(action: {
                            viewModel.deleteRide()
                            dismissAction()
                        }) {
                            Text("Delete")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 20)
                    
                } else {
                    Text("No ride data")
                        .padding()
                }
                
            }
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 8)
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
    }
}

#Preview {
    RidePopupView(viewModel: CurrentRideViewModel(), dismissAction: {})
}
