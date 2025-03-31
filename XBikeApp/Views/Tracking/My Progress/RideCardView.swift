//
//  RideCardView.swift
//  XBikeApp
//
//  Created by Juan Diego Olivas Maldonado on 31/03/25.
//

import SwiftUI

struct RideCardView: View {
    let ride: Ride
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(ride.formattedDuration)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("A: \(ride.startAddress ?? "No address")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("B: \(ride.endAddress ?? "No address")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Text(ride.formattedDistance)
                .font(.headline)
                .foregroundColor(.orange)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
    }
}
