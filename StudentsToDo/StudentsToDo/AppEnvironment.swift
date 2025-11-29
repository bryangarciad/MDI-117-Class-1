//
//  AppEnvironment.swift
//  StudentsToDo
//
//  Created by SDGKU on 15/11/25.
//

import SwiftUI

private struct AppAccentColorKey: EnvironmentKey {
    static let defaultValue: Color = .cyan
}

extension EnvironmentValues {
    var appAccentColor: Color {
        get { self[AppAccentColorKey.self] }
        set { self[AppAccentColorKey.self] = newValue }
    }
}
