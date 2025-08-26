//
//  UIApplication.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 26/08/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEdition() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
