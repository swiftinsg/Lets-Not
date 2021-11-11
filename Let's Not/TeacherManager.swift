//
//  TeacherManager.swift
//  Let's Not
//
//  Created by jiachen on 1/11/21.
//

import Foundation
import SwiftUI

class TeacherManager: ObservableObject {
    @Published var teachers: [Teacher] = [] {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "teachers.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedTeachers = try? propertyListEncoder.encode(teachers)
        try? encodedTeachers?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        var finalTeachers: [Teacher]!
        
        if let retrievedTeacherData = try? Data(contentsOf: archiveURL),
           let decodedTeachers = try? propertyListDecoder.decode([Teacher].self, from: retrievedTeacherData) {
            finalTeachers = decodedTeachers
        } else {
            finalTeachers = []
        }
        
        teachers = finalTeachers
    }
}
