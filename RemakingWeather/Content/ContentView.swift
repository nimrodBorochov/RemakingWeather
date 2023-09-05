//
//  ContentView.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 04/09/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        ZStack {
            StarsView()
                .opacity(viewModel.starOpacity)

            CloudsView(
                thickness: viewModel.cloudThickness,
                topTint: viewModel.cloudTints.top,
                bottomTint: viewModel.cloudTints.bottom
            )

            if viewModel.stormType != .none {
                StormView(type: viewModel.stormType, direction: .degrees(viewModel.rainAngle), strength: Int(viewModel.rainIntensity))
            }
        }
        .preferredColorScheme(.dark)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(colors: viewModel.gradientColors, startPoint: .top, endPoint: .bottom)
        )
        .safeAreaInset(edge: .bottom) {
            VStack {
                Text(viewModel.formattedTime)
                    .padding(.top)

                Picker("Thickness", selection: $viewModel.cloudThickness) {
                    ForEach(Cloud.Thickness.allCases, id: \.self) { thickness in
                        Text(String(describing: thickness).capitalized)
                    }
                }
                .pickerStyle(.segmented)

                HStack {
                    Text("Time:")
                    Slider(value: $viewModel.time)
                }
                .padding()

                Picker("Precipitation", selection: $viewModel.stormType) {
                    ForEach(Storm.Content.allCases, id:\.self) { stormType in
                        Text(String(describing: stormType).capitalized)
                    }
                }
                .pickerStyle(.segmented)

                HStack {
                    Text("Intensity:")
                    Slider(value: $viewModel.rainIntensity, in: 0...1000)
                }
                .padding(.horizontal)

                HStack {
                    Text("Angle:")
                    Slider(value: $viewModel.rainAngle, in: 0...90)
                }
                .padding(.horizontal)

            }
            .padding(5)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
