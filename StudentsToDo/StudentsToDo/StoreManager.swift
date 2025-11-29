//
//  StoreManager.swift
//  StudentsToDo
//
//  Created by SDGKU

import SwiftUI

class StoreManager: ObservableObject {
    @Published var isPro = false
    
    func buyProVersion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isPro = true
        }
    }
    
    func canAddGroup(currentGroupCount: Int) -> Bool {
        if isPro {
            return true
        } else {
            return currentGroupCount < 3 // Free users can only have up to 3 Groups
        }
    }
}
