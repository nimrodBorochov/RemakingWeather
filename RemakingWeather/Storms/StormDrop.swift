//
//  StromDrop.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 05/09/2023.
//

import SwiftUI

class StormDrop {

    var xCord: Double
    var yCord: Double
    var xScale: Double
    var yScale: Double
    var speed: Double
    var opacity: Double

    var direction: Angle
    var rotation: Angle
    var rotationSpeed: Angle

    init(type: Storm.Content, direction: Angle) {
        xCord = Double.random(in: -0.2...1.2)
        yCord = Double.random(in: -0.2...1.2)

        switch type {
        case .snow:
            self.direction = direction + .degrees(.random(in: -15...15))
            xScale = Double.random(in: 0.125...1)
            yScale = xScale * Double.random(in: 0.5...1)
            speed = Double.random(in: 0.2...0.6)
            opacity = Double.random(in: 0.2...1)
            rotation = Angle.degrees(Double.random(in: 0...360))
            rotationSpeed = Angle.degrees(Double.random(in: -360...360))
        default:
            self.direction = direction
            xScale = Double.random(in: 0.4...1)
            yScale = xScale
            speed = Double.random(in: 1...2)
            opacity = Double.random(in: 0.05...0.3)
            rotation = Angle.zero
            rotationSpeed = Angle.zero
        }
    }
}
