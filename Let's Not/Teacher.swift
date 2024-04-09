//
//  Teacher.swift
//  Let's Not
//
//  Created by jiachen on 31/10/21.
//

import Foundation

struct Teacher: Codable, Identifiable, Equatable, Hashable {
    var id = UUID()
    var name: String
    var subject: String
    var excuses: [Excuse] = []
}
