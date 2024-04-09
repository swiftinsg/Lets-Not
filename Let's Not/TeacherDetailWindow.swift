//
//  TeacherDetailWindow.swift
//  Let's Not
//
//  Created by Jia Chen Yee on 9/4/24.
//

import SwiftUI

struct TeacherDetailWindow: View {
    
    @ObservedObject var teacherManager: TeacherManager
    
    var teacher: Teacher
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(teacher.name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.heavy)
                .padding([.horizontal, .top], 32)
            
            Text(teacher.subject)
                .font(.system(.headline, design: .rounded))
                .foregroundStyle(.secondary)
                .padding(.horizontal, 32)
            
            ScrollView(.vertical) {
                ForEach(teacher.excuses) { excuse in
                    ExcuseCardButton(teacherManager: teacherManager, excuse: excuse)
                        .padding(.horizontal, 32)
                }
                .padding(.bottom, 32)
            }
        }
    }
}
