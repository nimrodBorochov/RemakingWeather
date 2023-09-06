//
//  ResidueDrop.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 05/09/2023.
//

import SwiftUI

class ResidueDrop: Hashable {
    var id = UUID()
    var destructionTime: Double
    var xCord: Double
    var yCord = 0.5
    var scale: Double
    var speed: Double
    var opacity: Double
    var xMovement: Double
    var yMovement: Double

    init(type: Storm.Content, xPosition: Double, destructionTime: Double) {
        self.xCord = xPosition
        self.destructionTime = destructionTime

        switch type {
        case .snow:
            scale = Double.random(in: 0.125...0.75)
            opacity = Double.random(in: 0.2...0.7)
            speed = 0
            xMovement = 0
            yMovement = 0

        default:
            scale = Double.random(in: 0.4...0.5)
            opacity = Double.random(in: 0...0.3)
            speed = 2

            let direction = Angle.degrees(.random(in: 225...315)).radians  // 270° is UP
            xMovement = cos(direction)
            yMovement = sin(direction) / 1.5 // splash don't get so high
        }
    }

    static func == (lhs: ResidueDrop, rhs: ResidueDrop) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
