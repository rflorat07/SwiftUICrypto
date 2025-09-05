//
//  Color.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 22/08/25.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    let accent: Color = Color("AccentColor")
    let background: Color = Color("BackgroundColor")
    let green: Color = Color("GreenColor")
    let red: Color = Color("RedColor")
    let secondaryText: Color = Color("SecondaryTextColor")
}

struct LaunchTheme {
    let accent: Color = Color("LaunchAccentColor")
    let background: Color = Color("LaunchBackgroundColor")
}
