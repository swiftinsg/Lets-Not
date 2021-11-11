//
//  ExcuseManager.swift
//  Let's Not
//
//  Created by jiachen on 1/11/21.
//

import Foundation
import SwiftUI

class ExcuseManager: ObservableObject {
    @Published var userExcuses: [Excuse] = [] {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "userexcuses.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedExcuses = try? propertyListEncoder.encode(userExcuses)
        try? encodedExcuses?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        var finalExcuses: [Excuse]!
        
        if let retrievedExcuseData = try? Data(contentsOf: archiveURL),
           let decodedExcuses = try? propertyListDecoder.decode([Excuse].self, from: retrievedExcuseData) {
            finalExcuses = decodedExcuses
        } else {
            finalExcuses = []
        }
        
        userExcuses = finalExcuses
    }
}
