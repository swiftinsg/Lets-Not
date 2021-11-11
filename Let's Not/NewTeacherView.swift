//
//  NewTeacherView.swift
//  Let's Not
//
//  Created by jiachen on 1/11/21.
//

import SwiftUI

struct NewTeacherView: View {
    
    @ObservedObject var teacherManager: TeacherManager
    @State var teacher = Teacher(name: "", subject: "")
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Mr Soon", text: $teacher.name)
                } header: {
                    Text("Name")
                }
                
                Section {
                    TextField("Swift Accelerator Programme", text: $teacher.subject)
                } header: {
                    Text("Subject")
                }
            }
            .navigationTitle("New Teacher")
            .toolbar {
                Button {
                    teacherManager.teachers.append(teacher)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct NewTeacherView_Previews: PreviewProvider {
    static var previews: some View {
        NewTeacherView(teacherManager: TeacherManager())
    }
}
