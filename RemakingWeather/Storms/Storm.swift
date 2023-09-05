//
//  Storm.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 05/09/2023.
//

import SwiftUI

class Storm {
    enum Content: CaseIterable {
        case none, rain, snow
    }

    var drops = [StormDrop]()
    var lastUpdate = Date.now
    var image: Image

    init(type: Content, direction: Angle, strength: Int) {
        switch type {
        case .snow:
            image = Image("snow")
        default:
            image = Image("rain")
        }

        for _ in 0..<strength {
            drops.append(StormDrop(type: type, direction: direction + .degrees(90))) // 90° is the "natural" drop DOWN
        }
    }

    func update(date: Date, size: CGSize) {
        let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970
        let divisor = size.height / size.width

        // back to school (geometry)
        for drop in drops {
            let radians = drop.direction.radians
            // add divisor for normalize by phone ratio
            drop.xCord += cos(radians) * drop.speed * delta * divisor
            drop.yCord += sin(radians) * drop.speed * delta

            // out of screen from side
            if drop.xCord < -0.2 {
                drop.xCord += 1.4
            }

            // out of screen from bottom
            if drop.yCord > 1.2 {
                drop.xCord = Double.random(in: -0.2...1.2)
                drop.yCord -= 1.4
            }
        }

        lastUpdate = date
    }
}
