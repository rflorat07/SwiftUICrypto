//
//  XMarkButton.swift
//  SwiftUICrypto
//
//  Created by Roger Florat Gutierrez on 02/09/25.
//

import SwiftUI

struct XMarkButton: View {
  
    let dismiss: DismissAction
  
  var body: some View {
    Button (action: {
      dismiss()
    }, label: {
      Image(systemName: "xmark")
        .font(.headline)
    })
  }
}

#Preview {
    @Previewable @Environment(\.dismiss) var dismiss
    XMarkButton(dismiss: dismiss)
}
