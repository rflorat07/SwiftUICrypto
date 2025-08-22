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
}

struct ColorTheme {
    let accent: Color = Color("AccentColor")
    let background: Color = Color("BackgroundColor")
    let gree: Color = Color("GreenColor")
    let red: Color = Color("RedColor")
    let secondaryText: Color = Color("SecondaryTextColor")
}
