//
//  MyExcuses.swift
//  Let's Not
//
//  Created by jiachen on 31/10/21.
//

import SwiftUI

struct MyExcusesView: View {
    
    @State var isExcusePresented = false
    @State var isTeacherPresented = false
    @State var isNewTeacherSheetPresented = false
    @State var isNewExcuseSheetPresented = false
    
    @State var selectedExcuse: Excuse?
    @State var selectedTeacher: Teacher?
    
    @ObservedObject var teacherManager: TeacherManager
    @ObservedObject var excuseManager: ExcuseManager
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    HStack {
                        Text("👤 By me")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.primary)
                        
                        Spacer()
                        
                        Button {
                            isNewExcuseSheetPresented = true
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.accentColor)
                        }
                    }
                    .padding(.horizontal)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .buttonStyle(PlainButtonStyle())
                    
                    VStack(alignment: .leading) {
                        Text("Excuses created by you.")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundStyle(.secondary)
                            .padding(.top, 0.5)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(excuseManager.userExcuses) { excuse in
                                    Button {
                                        selectedExcuse = excuse
                                        isExcusePresented = true
                                    } label: {
                                        let isUsed = !excuse.usedOn(teachers: teacherManager.teachers).isEmpty
                                        
                                        HStack(alignment: .bottom) {
                                            VStack(alignment: .leading) {
                                                Text(excuse.title)
                                                    .font(.system(.title, design: .rounded))
                                                    .fontWeight(.semibold)
                                                    .lineLimit(3)
                                                    .multilineTextAlignment(.leading)
                                                    .foregroundColor(isUsed ? .white : Color(.label))
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                            
                                            Image(systemName: isUsed ? "heart.fill" : "heart")
                                                .foregroundColor(isUsed ? .white : .accentColor)
                                                .font(.system(size: 25, design: .rounded))
                                        }
                                        .padding()
                                        .frame(width: 300, height: 170, alignment: .leading)
                                        .background(isUsed ? Color.accentColor : Color(.systemGray6).opacity(0.7))
                                        .cornerRadius(15)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Divider()
                            .padding()
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                    
                    HStack {
                        Text("🧑‍🏫 Teachers")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.primary)
                        
                        Spacer()
                        
                        Button {
                            isNewTeacherSheetPresented = true
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.accentColor)
                        }
                    }
                    .padding(.horizontal)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .buttonStyle(PlainButtonStyle())
                    
                    Text("Assign excuses to teachers to ensure you never repeat them. There's nothing worse than hearing \"You said that to me last week\" from your teacher.")
                        .font(.system(.subheadline, design: .rounded))
                        .padding(.horizontal)
                        .foregroundStyle(.secondary)
                        .padding(.bottom)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

                    ForEach(teacherManager.teachers) { teacher in
                        Button {
                            // open teacher view
                            selectedTeacher = teacher
                            isTeacherPresented = true
                        } label: {
                            HStack(alignment: .bottom) {
                                VStack(alignment: .leading) {
                                    Text(teacher.name)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        .font(.system(.title, design: .rounded))
                                        .lineLimit(1)
                                        .foregroundColor(Color(UIColor.label))
                                    
                                    Text(teacher.subject)
                                        .font(.system(.headline, design: .rounded))
                                        .foregroundColor(Color(UIColor.label))
                                    
                                    Spacer()
                                    
                                    Text("\(teacher.excuses.count) excuses")
                                        .font(.system(.caption, design: .rounded))
                                        .foregroundColor(.accentColor)
                                }
                                
                                Spacer()
                            }
                            .padding()
                            .frame(height: 110, alignment: .leading)
                            .background(Color(UIColor.systemGray6).opacity(0.7))
                            .cornerRadius(15)
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .onDelete { offsets in
                        teacherManager.teachers.remove(atOffsets: offsets)
                    }
                    .onMove(perform: { offsets, position in
                        teacherManager.teachers.move(fromOffsets: offsets, toOffset: position)
                    })
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .listStyle(.plain)
            }
            .frame(alignment: .leading)
            .navigationTitle("My Excuses")
            .toolbar {
                if !teacherManager.teachers.isEmpty {
                    EditButton()
                }
            }
            .sheet(isPresented: $isExcusePresented) {
                ExcuseDetailView(excuse: $selectedExcuse, teacherManager: teacherManager)
            }
            .sheet(isPresented: $isTeacherPresented) {
                TeacherDetailView(teacherManager: teacherManager, teacher: $selectedTeacher)
            }
            .sheet(isPresented: $isNewTeacherSheetPresented) {
                NewTeacherView(teacherManager: teacherManager)
            }
            .sheet(isPresented: $isNewExcuseSheetPresented) {
                NewExcuseView(teacherManager: teacherManager, excuseManager: excuseManager)
            }
        }
    }
}

struct MyExcuses_Previews: PreviewProvider {
    static var previews: some View {
        MyExcusesView(teacherManager: TeacherManager(), excuseManager: ExcuseManager())
    }
}
