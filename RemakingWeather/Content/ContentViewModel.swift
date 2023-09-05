//
//  ContentViewModel.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 05/09/2023.
//

import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var cloudThickness = Cloud.Thickness.regular
        @Published var time = 0.0

        var formattedTime: String {
            let start = Calendar.current.startOfDay(for: Date.now)
            let advanced = start.addingTimeInterval(time * 24 * 60 * 60)
            return advanced.formatted(date: .omitted, time: .shortened)
        }

        // MARK: - Background Gradient

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

        var gradientColors: [Color] {
            [
                backgroundTopStop.interpolated(amount: time),
                backgroundBottomStop.interpolated(amount: time)
            ]
        }

        // MARK: - Cloud Shading Gradient

        let cloudTopStop: [Gradient.Stop] = [
            .init(color: .darkCloudStart, location: 0),
            .init(color: .darkCloudStart, location: 0.25),
            .init(color: .sunriseCloudStart, location: 0.33),
            .init(color: .lightCloudStart, location: 0.38),
            .init(color: .lightCloudStart, location: 0.7),
            .init(color: .sunsetCloudStart, location: 0.78),
            .init(color: .darkCloudStart, location: 0.82),
            .init(color: .darkCloudStart, location: 1)
        ]

        let cloudBottomStop: [Gradient.Stop] = [
            .init(color: .darkCloudEnd, location: 0),
            .init(color: .darkCloudEnd, location: 0.25),
            .init(color: .sunriseCloudEnd, location: 0.33),
            .init(color: .lightCloudEnd, location: 0.38),
            .init(color: .lightCloudEnd, location: 0.7),
            .init(color: .sunsetCloudEnd, location: 0.78),
            .init(color: .darkCloudEnd, location: 0.82),
            .init(color: .darkCloudEnd, location: 1)
        ]

        var cloudTints: (top: Color, bottom: Color) {
            (cloudTopStop.interpolated(amount: time), cloudBottomStop.interpolated(amount: time))
        }

        // MARK: - Stars Appearance color & alpha

        let starStop: [Gradient.Stop] = [
            .init(color: .white, location: 0),
            .init(color: .white, location: 0.25),
            .init(color: .clear, location: 0.33),
            .init(color: .clear, location: 0.38),
            .init(color: .clear, location: 0.7),
            .init(color: .clear, location: 0.78),
            .init(color: .white, location: 0.82),
            .init(color: .white, location: 1)
        ]

        var starOpacity: Double {
            let color = starStop.interpolated(amount: time)
            return color.getComponents().alpha
        }

    }
}
