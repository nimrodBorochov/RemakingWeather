//
//  ResideView.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 06/09/2023.
//

import SwiftUI

struct ResidueView: View {
    let residue: Residue

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                residue.update(date: timeline.date, size: size)

                for drop in residue.drops {
                    var contextCopy = context

                    // move to pixels
                    let xPos = drop.xCord * size.width
                    let yPos = drop.yCord * size.height

                    contextCopy.opacity = drop.opacity
                    contextCopy.translateBy(x: xPos, y: yPos)
                    contextCopy.scaleBy(x: drop.scale, y: drop.scale)

                    contextCopy.draw(residue.image, at: .zero)
                }
            }
        }
    }

    init(type: Storm.Content, strength: Double) {
        residue = Residue(type: type, strength: strength)
    }
}

struct ResideView_Previews: PreviewProvider {
    static var previews: some View {
        ResidueView(type: .rain, strength: 200)
            .background(.blue)
    }
}
