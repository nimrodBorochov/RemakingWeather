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
            CloudsView(
                thickness: viewModel.cloudThickness,
                topTint: viewModel.cloudTints.top,
                bottomTint: viewModel.cloudTints.bottom
            )
        }
        .preferredColorScheme(.dark)
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
