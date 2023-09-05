//
//  Star.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 05/09/2023.
//

import Foundation

class Star {
    var xPos: Double
    var yPos: Double
    var size: Double
    var flickerInterval: Double

    init(xPos: Double, yPos: Double, size: Double) {
        self.xPos = xPos
        self.yPos = yPos
        self.size = size

        if size > 2 && yPos < 250 {
            flickerInterval = Double.random(in: 3...20)
        } else {
            flickerInterval = 0
        }
    }
}
