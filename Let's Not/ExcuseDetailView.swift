//
//  ExcuseDetailView.swift
//  Let's Not
//
//  Created by jiachen on 31/10/21.
//

import SwiftUI

struct ExcuseDetailView: View {
    
    @Binding var excuse: Excuse?
    @ObservedObject var teacherManager: TeacherManager
    
    @State var isTeacherPresented = false
    @State var selectedTeacher: Teacher?
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(excuse!.title)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
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
                        Text("Head over to the second tab on the main screen to add teacher(s) to the app.")
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
                            .padding(.top, 0.5)
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
                            let index = teacherManager.teachers.firstIndex(where: { $0 == teacher })!
                            
                            if teacher.excuses.contains(excuse!) {
                                teacherManager.teachers[index].excuses.removeAll(where: { $0 == excuse })
                            } else {
                                teacherManager.teachers[index].excuses.append(excuse!)
                            }
                        } label: {
                            Image(systemName: teacher.excuses.contains(excuse!) ? "checkmark.square.fill" : "square")
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
        .sheet(isPresented: $isTeacherPresented) {
            TeacherDetailView(teacherManager: teacherManager, teacher: $selectedTeacher)
        }
    }
}

struct ExcuseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExcuseDetailView(excuse: .constant(Excuse.all.randomElement()), teacherManager: TeacherManager())
    }
}
