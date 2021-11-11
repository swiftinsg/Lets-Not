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
    
    init(teacherManager: TeacherManager, excuseManager: ExcuseManager) {
        UITextView.appearance().backgroundColor = .clear
        
        self.teacherManager = teacherManager
        self.excuseManager = excuseManager
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            ZStack(alignment: .leading) {
                                if excuse.title.isEmpty {
                                    Text(placeholderExcuse.title)
                                        .opacity(0.5)
                                        .padding(8)
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                } else {
                                    Text(excuse.title).opacity(0).padding(8)
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                                TextEditor(text: $excuse.title)
                                    .background(Color.clear)
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .tint(.white)
                                
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(15)
                    .padding([.horizontal, .top])
                    
                    VStack(alignment: .leading) {
                        
                        if teacherManager.teachers.isEmpty {
                            Text("Think this excuse would work well with a particular teacher?")
                                .font(.system(.headline, design: .rounded))
                                .foregroundStyle(.primary)
                                .padding(.horizontal)
                                .padding(.top)
                            Text("Add teacher(s) to the app first.")
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundStyle(.secondary)
                                .padding(.horizontal)
                                .padding(.top, 0.5)
                        } else {
                            Text("Assign to Teacher")
                                .font(.system(.headline, design: .rounded))
                                .foregroundStyle(.primary)
                                .padding(.horizontal)
                                .padding(.top)
                            Text("Select a teacher to assign the excuse to.")
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundStyle(.secondary)
                                .padding(.horizontal)
                        }
                    }
                    
                    ForEach(teacherManager.teachers) { teacher in
                        HStack {
                            Button {
                                selectedTeacher = teacher
                                isTeacherPresented = true
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
                        .padding()
                        .background(Color(.systemGray6).opacity(0.7))
                        .cornerRadius(15)
                        .padding([.horizontal, .top])
                    }
                }
                
            }
            .navigationTitle("New Excuse")
            .toolbar {
                Button {
                    for teacher in selectedTeachers {
                        let index = teacherManager.teachers.firstIndex(where: { $0 == teacher })!
                        
                        teacherManager.teachers[index].excuses.append(excuse)
                    }
                    
                    excuseManager.userExcuses.append(excuse)
                    
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "checkmark")
                }
            }
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
