//
//  StarField.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 05/09/2023.
//

import Foundation

class StarField {
    var stars = [Star]()
    let leftEdge = -50.0
    let rightEdge = 500.0
    var lastUpdate = Date.now

    init() {
        for _ in 1...200 {
            let xPos = Double.random(in: leftEdge...rightEdge)
            let yPos = Double.random(in: 0...600)
            let size = Double.random(in: 1...3)
            let star = Star(xPos: xPos, yPos: yPos, size: size)
            stars.append(star)
        }
    }

    func update(date: Date) {
        let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970

        for star in stars {
            star.xPos -= delta * 2

            if star.xPos < leftEdge {
                star.xPos = rightEdge
            }
        }

        lastUpdate = date
    }
}
