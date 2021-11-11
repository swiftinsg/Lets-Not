//
//  Let_s_NotApp.swift
//  Let's Not
//
//  Created by jiachen on 31/10/21.
//

import SwiftUI

@main
struct Let_s_NotApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension UIFont {
    func rounded(weight: UIFont.Weight) -> UIFont {
        guard let descriptor = fontDescriptor.withDesign(.rounded)?.addingAttributes([.traits: [
            UIFontDescriptor.TraitKey.weight: weight
        ]]) else {
            return self
        }
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
