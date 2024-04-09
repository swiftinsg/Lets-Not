//
//  NewExcuseView.swift
//  Let's Not
//
//  Created by jiachen on 1/11/21.
//

import SwiftUI

struct NewExcuseView: View {
    
    @ObservedObject var teacherManager: TeacherManager
    @ObservedObject var excuseManager: ExcuseManager
    @Environment(\.presentationMode) var presentationMode
    
    @State var excuse = Excuse(id: .random(in: 200 ... .max), title: "")
    let placeholderExcuse = Excuse.all.randomElement()!
    
    @State var isTeacherPresented = false
    @State var selectedTeacher: Teacher?
    
    @State var selectedTeachers: [Teacher] = []
    
    @Environment(\.openWindow) var openWindow
    
    init(teacherManager: TeacherManager, excuseManager: ExcuseManager) {
        UITextView.appearance().backgroundColor = .clear
        
        self.teacherManager = teacherManager
        self.excuseManager = excuseManager
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("What's your excuse?") {
                    TextEditor(text: $excuse.title)
                        .font(.title)
                }
                
                Section {
                    ForEach(teacherManager.teachers) { teacher in
                        HStack {
                            Button {
#if os(visionOS)
                                openWindow(value: teacher)
#else
                                selectedTeacher = teacher
                                isTeacherPresented = true
#endif
                            } label: {
                                Text(teacher.name)
                                    .font(.system(.body, design: .rounded))
                                    .foregroundColor(Color(.label))
                                Spacer()
                            }
                            
                            Button {
                                if selectedTeachers.contains(teacher) {
                                    selectedTeachers.removeAll(where: { $0 == teacher })
                                } else {
                                    selectedTeachers.append(teacher)
                                }
                            } label: {
                                Image(systemName: selectedTeachers.contains(teacher) ? "checkmark.square.fill" : "square")
                                    .padding(2.5)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                } header: {
                    #if os(visionOS)
                    VStack(alignment: .leading) {
                        if teacherManager.teachers.isEmpty {
                            Text("Think this excuse would work well with a particular teacher?")
                                .font(.system(.headline, design: .rounded))
                                .foregroundStyle(.primary)
                            Text("Add teacher(s) to the app first.")
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundStyle(.secondary)
                        } else {
                            Text("Assign to Teacher")
                                .font(.system(.headline, design: .rounded))
                                .foregroundStyle(.primary)
                            Text("Select a teacher to assign the excuse to.")
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundStyle(.secondary)
                        }
                    }
                    #else
                    Text("Assign to Teacher")
                    #endif
                } footer: {
#if os(visionOS)
#else
                    Text("Select a teacher to assign the excuse to.")
#endif
                }
                
                Section {
                    Button {
                        for teacher in selectedTeachers {
                            let index = teacherManager.teachers.firstIndex(where: { $0 == teacher })!
                            
                            teacherManager.teachers[index].excuses.append(excuse)
                        }
                        
                        excuseManager.userExcuses.append(excuse)
                        
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Label("Done", systemImage: "checkmark")
                    }
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Label("Cancel", systemImage: "xmark")
                    }
                }
            }
            .navigationTitle("New Excuse")
        }
        .sheet(isPresented: $isTeacherPresented) {
            TeacherDetailView(teacherManager: teacherManager, teacher: $selectedTeacher)
        }
    }
}

struct NewExcuseView_Previews: PreviewProvider {
    static var previews: some View {
        NewExcuseView(teacherManager: TeacherManager(), excuseManager: ExcuseManager())
    }
}
