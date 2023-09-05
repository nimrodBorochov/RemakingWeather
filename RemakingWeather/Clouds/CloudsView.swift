//
//  CloudsView.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 04/09/2023.
//

import SwiftUI

struct CloudsView: View {
    var cloudGroup: CloudGroup
    let topTint: Color
    let bottomTint: Color

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, _ in
                cloudGroup.update(date: timeline.date)
                context.opacity = cloudGroup.opacity

                let resolvedImages = (0..<8).map { counter -> GraphicsContext.ResolvedImage in
                    let sourceImage = Image("cloud\(counter)")
                    var resolved = context.resolve(sourceImage)
                    resolved.shading = .linearGradient(
                        Gradient(colors: [topTint, bottomTint]),
                        startPoint: .zero,
                        endPoint: CGPoint(x: 0, y: resolved.size.height)
                    )
                    return resolved
                }

                for cloud in cloudGroup.clouds {
                    context.translateBy(x: cloud.position.x, y: cloud.position.y)
                    context.scaleBy(x: cloud.scale, y: cloud.scale)
                    context.draw(resolvedImages[cloud.imageNumber ], at: .zero, anchor: .topLeading)
                     context.transform = .identity
                }
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    init(thickness: Cloud.Thickness, topTint: Color, bottomTint: Color) {
        cloudGroup = CloudGroup(thickness: thickness)
        self.topTint = topTint
        self.bottomTint = bottomTint
    }
}

struct CloudsView_Previews: PreviewProvider {
    static var previews: some View {
        CloudsView(thickness: .regular, topTint: .white, bottomTint: .white)
            .background(.blue)
    }
}
