//
//  Color-Interpolation.swift
//  RemakingWeather
//
//  Created by nimrod borochov on 04/09/2023.
//

import SwiftUI

struct ColorComponents {
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double
}

extension Color {
    func getComponents() -> ColorComponents {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        let uiColor = UIColor(self)
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return ColorComponents(red: red, green: green, blue: blue, alpha: alpha)
    }

    func interpolated(to other: Color, amount: Double) -> Color {
        let componentsForm = self.getComponents()
        let componentsTo = other.getComponents()

        let newRed = (1 - amount) * componentsForm.red + (amount * componentsTo.red)
        let newGreen = (1 - amount) * componentsForm.green + (amount * componentsTo.green)
        let newBlue = (1 - amount) * componentsForm.blue + (amount * componentsTo.blue)
        let newOpacity = (1 - amount) * componentsForm.alpha + (amount * componentsTo.alpha)

        return Color(.displayP3, red: newRed, green: newGreen, blue: newBlue, opacity: newOpacity)
    }
}
