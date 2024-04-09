//
//  Let_s_NotApp.swift
//  Let's Not
//
//  Created by jiachen on 31/10/21.
//

import SwiftUI

@main
struct Let_s_NotApp: App {
    
    @StateObject var teacherManager = TeacherManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(teacherManager: .init(wrappedValue: teacherManager))
        }
        
        #if os(visionOS)
        WindowGroup(for: Excuse.self) { $excuse in
            if let excuse {
                ExcuseDetailWindow(excuse: excuse, teacherManager: teacherManager)
            }
        }
        .defaultSize(width: 512, height: 360)
        
        WindowGroup(for: Teacher.self) { $teacher in
            if let teacher = teacher {
                TeacherDetailWindow(teacherManager: teacherManager, teacher: teacher)
            }
        }
        .defaultSize(width: 512, height: 360)
        #endif
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
