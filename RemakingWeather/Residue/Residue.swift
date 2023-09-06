//
//  Residue.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 05/09/2023.
//

import SwiftUI

class Residue {
    var drops = Set<ResidueDrop>()
    var lastUpdate = Date.now
    var nextCreationTime = Date.now

    var image = Image("snow")
    var type: Storm.Content

    let creationAmount: Int
    let lifetime: ClosedRange<Double>
    let creationDelay: ClosedRange<Double>?

    init(type: Storm.Content, strength: Double) {
        self.type = type

        switch type {
        case .snow:
            creationAmount = 1
            lifetime = 1.0...2.0
        default:
            creationAmount = 3
            lifetime = 0.9...1.1
        }

        if type == .none || strength == 0 {
            creationDelay = nil
        } else {
            switch strength {
            case 1...200:
                creationDelay = 0...0.2
            case 201...400:
                creationDelay = 0...0.1
            case 401...800:
                creationDelay = 0...0.05
            default:
                creationDelay = 0...0.02
            }
        }
    }

    func update(date: Date, size: CGSize) {
        guard let creationDelay else { return }

        let currentTime = date.timeIntervalSince1970
        let delta = currentTime - lastUpdate.timeIntervalSince1970
        let divisor = size.height / size.width

        for drop in drops {
            drop.xCord += drop.xMovement * drop.speed * delta * divisor
            drop.yCord += drop.yMovement * drop.speed * delta
            drop.yMovement += delta * 2

            if drop.yCord > 0.5 {
                if drop.xCord  > 0.075 && drop.xCord < 0.925 {
                    drop.yCord = 0.5
                    drop.yMovement = 0
                }
            }

            if drop.destructionTime < currentTime {
                drops.remove(drop)
            }
        }

        if nextCreationTime.timeIntervalSince1970 < currentTime {
            let dropX = Double.random(in: 0.075...0.925)

            for _ in 0..<creationAmount {
                drops.insert(ResidueDrop(
                    type: type,
                    xPosition: dropX,
                    destructionTime: currentTime + .random(in: lifetime))
                )
            }

            nextCreationTime = Date.now + Double.random(in: creationDelay)
        }

        lastUpdate = date
    }
}
