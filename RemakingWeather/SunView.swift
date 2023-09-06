//
//  SunView.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 06/09/2023.
//

import SwiftUI

struct SunView: View {
    let progress: Double

    @State private var haloScale = 1.0
    @State private var sunRotation = 0.0
    @State private var flareDistance = 80.0

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image("halo")
                    .blur(radius: 3)
                    .scaleEffect(haloScale)
                    .opacity(sin(progress * .pi) * 3 - 2) // sin go 0 to 1 then back to 0 and opacity is -2 through to 1 

                Image("sun")
                    .blur(radius: 2)
                    .rotationEffect(.degrees(sunRotation))

                VStack {
                    Spacer()
                        .frame(height: 200)

                    ForEach(0..<3) { index in
                        let size = 16 + Double(index * 10) // get bigger for each
                        Circle()
                            .fill(.white.opacity(0.2))
                            .frame(width: size, height: size)
                            .padding(.top, 40 + (sin(Double(index) / 2) * flareDistance))
                            .blur(radius: 1)
                            .opacity(sin(progress * .pi) - 0.7) // -0.7 through to +0.3
                    }
                }
            }
            .blendMode(.screen)
            .position(x: proxy.frame(in: .global).width * sunX, y: 50) //
            .rotationEffect(.degrees((progress - 0.5) * 180)) // progress in 0 to 1 so angle is -90° to 90°
            .onAppear {
                withAnimation(.easeInOut(duration: 7).repeatForever(autoreverses: true)) {
                    haloScale = 1.3
                }

                withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
                    sunRotation = 20
                }

                withAnimation(.easeInOut(duration: 30).repeatForever(autoreverses: true)) {
                    flareDistance = -70
                }
            }
        }
        .ignoresSafeArea()
    }

    var sunX: Double { // for appearing correct in day time
        (progress - 0.3) * 1.8
    }
}

struct SunView_Previews: PreviewProvider {
    static var previews: some View {
        SunView(progress: 0.5)
            .background(.blue)
    }
}
