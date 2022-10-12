//
//  Constent.swift
//  Devote
//
//  Created by Soro on 2022-10-11.
//

import SwiftUI

// formatter
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
 

// ui
var backgroundGradient: LinearGradient{
    return LinearGradient(gradient: Gradient(colors: [Color.pink,Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
// ux
let feedback = UINotificationFeedbackGenerator()
