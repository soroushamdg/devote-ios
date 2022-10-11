//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Soro on 2022-10-11.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
