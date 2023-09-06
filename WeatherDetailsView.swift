//
//  WeatherDetailsView.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 06/09/2023.
//

import SwiftUI

struct WeatherDetailsView: View {
    let tintColor: Color

    let residueType: Storm.Content
    let residueStrength: Double

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ResidueView(type: residueType, strength: residueStrength)
                    .frame(height: 62)
                    .offset(y: 30)
                    .zIndex(1)

                RoundedRectangle(cornerRadius: 25)
                    .fill(tintColor.opacity(0.25))
                    .frame(height: 800)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal, 25)
            }
            .padding(.top, 200)
        }
    }
}

struct WeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsView(tintColor: .blue, residueType: .rain, residueStrength: 200)
    }
}
