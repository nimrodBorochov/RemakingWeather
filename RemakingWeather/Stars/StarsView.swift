//
//  StarsView.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 05/09/2023.
//

import SwiftUI

struct StarsView: View {
    @State var starField = StarField()

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, _ in
                let timeInterval = timeline.date.timeIntervalSince1970
                starField.update(date: timeline.date)
                context.addFilter(.blur(radius: 0.3))

                for (index, star) in starField.stars.enumerated() {
                    let path = Path(ellipseIn: CGRect(x: star.xPos, y: star.yPos, width: star.size, height: star.size))

                    if star.flickerInterval == 0 {
                        // flashing star
                        var flashLevel = sin(Double(index) + timeInterval * 4) // sin for number from -1 to 1
                        flashLevel = abs(flashLevel) // make it 0 to 1
                        flashLevel /= 2 // make it 0 to 0.5
                        context.opacity = 0.5 + flashLevel // opacity is 0.5 to 1
                    } else {
                        // blooming star
                        var flashLevel = sin(Double(index) + timeInterval)
                        // flashlevel =  -1 to 1
                        // If we multiply that by flicker interval, which is 3 to 20
                        // Then: flashLevel will be -3 to 3 on the low end, up to -20 to 20 on the high end
                        // Then for flicker as 20: take away flashLevel - 1 (= 19) -39 to 1
                        // Then for flicker as 3: take away flashLevel - 1 (= 2) -5 to 1
                        // Meaning most of the time this will be invisible
                        flashLevel *= star.flickerInterval
                        flashLevel -= star.flickerInterval - 1

                        if flashLevel > 0 {
                            var contextCopy = context
                            contextCopy.opacity = flashLevel
                            contextCopy.addFilter(.blur(radius: 3))

                            contextCopy.fill(path, with: .color(white: 1))
                            contextCopy.fill(path, with: .color(white: 1))
                            contextCopy.fill(path, with: .color(white: 1))
                        }

                        context.opacity = 1
                    }

                    if index.isMultiple(of: 5) {
                        context.fill(path, with: .color(red: 1, green: 0.85, blue: 0.8))
                    } else {
                        context.fill(path, with: .color(white: 1))
                    }
                }
            }
        }
        .ignoresSafeArea()
        .mask(
            LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom)
        )
    }
}

struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView()
            .background(.blue )
    }
}
