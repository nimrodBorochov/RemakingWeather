//
//  StormView.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 05/09/2023.
//

import SwiftUI

struct StormView: View {
    let storm: Storm

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                storm.update(date: timeline.date, size: size)

                for drop in storm.drops {
                    // render a single drop
                    var contextCopy = context

                    let xPos = drop.xCord * size.width
                    let yPos = drop.yCord * size.height

                    contextCopy.opacity = drop.opacity
                    contextCopy.translateBy(x: xPos, y: yPos)
                    contextCopy.rotate(by: drop.direction + drop.rotation)
                    contextCopy.scaleBy(x: drop.xScale, y: drop.yScale)
                    contextCopy.draw(storm.image, at: .zero)
                }
            }
        }
        .ignoresSafeArea()
    }

    init(type: Storm.Content, direction: Angle, strength: Int) {
        storm = Storm(type: type, direction: direction, strength: strength)
    }
}

struct StormView_Previews: PreviewProvider {
    static var previews: some View {
        StormView(type: .rain, direction: .zero, strength: 200)
            .background(.blue)
    }
}
