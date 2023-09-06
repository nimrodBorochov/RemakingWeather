//
//  LightningView.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 06/09/2023.
//

import SwiftUI

struct LightningView: View {
    var lightning: Lightning

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                lightning.update(date: timeline.date, size: size)

                let fullSize = Path(CGRect(origin: .zero, size: size))
                // lightning.flashOpacity will be 0.0 till fading state
                context.fill(fullSize, with: .color(.white.opacity(lightning.flashOpacity)))

                // rendering twice, blur filter will be effect only on the second
                for _ in 0..<2 {
                    for bolt in lightning.bolts {
                        var path = Path()
                        path.addLines(bolt.points)
                        context.stroke(path, with: .color(.white), lineWidth: bolt.width)
                    }

                    context.addFilter(.blur(radius: 5))
                }
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            lightning.strike()
        }
    }

    init(maximumBolts: Int = 4, forkProbability: Int = 20) {
        lightning = Lightning(maximumBolts: maximumBolts, forkProbability: forkProbability)
    }
}

struct LightningView_Previews: PreviewProvider {
    static var previews: some View {
        LightningView()
            .background(.blue)
    }
}
