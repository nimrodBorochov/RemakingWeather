//
//  ContentView.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 04/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var cloudThickness = Cloud.Thickness.regular
    @State private var time = 0.0

    let backgroundTopStop: [Gradient.Stop] = [
        .init(color: .midnightStart, location: 0),
        .init(color: .midnightStart, location: 0.25),
        .init(color: .sunriseStart, location: 0.33),
        .init(color: .sunnyDayStart, location: 0.38),
        .init(color: .sunnyDayStart, location: 0.7),
        .init(color: .sunsetStart, location: 0.78),
        .init(color: .midnightStart, location: 0.82),
        .init(color: .midnightStart, location: 1)
    ]

    let backgroundBottomStop: [Gradient.Stop] = [
        .init(color: .midnightEnd, location: 0),
        .init(color: .midnightEnd, location: 0.25),
        .init(color: .sunriseEnd, location: 0.33),
        .init(color: .sunnyDayEnd, location: 0.38),
        .init(color: .sunnyDayEnd, location: 0.7),
        .init(color: .sunsetEnd, location: 0.78),
        .init(color: .midnightEnd, location: 0.82),
        .init(color: .midnightEnd, location: 1)
    ]

    var body: some View {
        ZStack {
            CloudsView(thickness: cloudThickness)
        }
        .preferredColorScheme(.dark)
        .background(
            LinearGradient(colors: [
                backgroundTopStop.interpolated(amount: time),
                backgroundBottomStop.interpolated(amount: time)
            ], startPoint: .top, endPoint: .bottom)
        )
        .safeAreaInset(edge: .bottom) {
            VStack {
                Text(formattedTime)
                    .padding(.top)

                Picker("Thickness", selection: $cloudThickness) {
                    ForEach(Cloud.Thickness.allCases, id: \.self) { thickness in
                        Text(String(describing: thickness).capitalized)
                    }
                }
                .pickerStyle(.segmented)

                HStack {
                    Text("Time:")
                    Slider(value: $time)
                }
                .padding()
            }
            .padding(5)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        }
    }

    var formattedTime: String {
        let start = Calendar.current.startOfDay(for: Date.now)
        let advanced = start.addingTimeInterval(time * 24 * 60 * 60)
        return advanced.formatted(date: .omitted, time: .shortened)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
