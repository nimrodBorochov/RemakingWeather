//
//  LightningBolt.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 06/09/2023.
//

import Foundation

class LightningBolt {
    var points = [CGPoint]()
    var width: Double
    var angle: Double

    init(start: CGPoint, width: Double, angle: Double) {
        points.append(start)
        self.width = width
        self.angle = angle
    }
}
