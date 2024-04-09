//
//  MyExcuses.swift
//  Let's Not
//
//  Created by jiachen on 31/10/21.
//

import SwiftUI

struct MyExcusesView: View {
    
    @State var isTeacherPresented = false
    @State var isNewTeacherSheetPresented = false
    @State var isNewExcuseSheetPresented = false
    
    @State var selectedTeacher: Teacher?
    
    @ObservedObject var teacherManager: TeacherManager
    @ObservedObject var excuseManager: ExcuseManager
    
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("👤 By Me")
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
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal, paddingConstant)
                        
                        Text("Excuses created by you.")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundStyle(.secondary)
                            .padding(.top, 0.5)
                            .padding(.horizontal, paddingConstant)
                    
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(excuseManager.userExcuses) { excuse in
                                ExcuseCardButton(teacherManager: teacherManager, excuse: excuse)
                                    .frame(width: 300, height: 170, alignment: .leading)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            let index = excuseManager.userExcuses.firstIndex(of: excuse)
                                            
                                            if let index {
                                                _ = withAnimation {
                                                    excuseManager.userExcuses.remove(at: index)
                                                }
                                            }
                                            
                                            for (teacherIndex, teacher) in teacherManager.teachers.enumerated() {
                                                if let teacherExcuseIndex = teacher.excuses.firstIndex(of: excuse) {
                                                    teacherManager.teachers[teacherIndex].excuses.remove(at: teacherExcuseIndex)
                                                }
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal, paddingConstant)
                    }
                    
                    Divider()
                        .padding(.horizontal, paddingConstant)

                    VStack(alignment: .leading, spacing: 0) {
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
                        .padding(.horizontal, paddingConstant)
                        .buttonStyle(PlainButtonStyle())
                        
                        Text("Assign excuses to teachers to ensure you never repeat them. There's nothing worse than hearing \"You said that to me last week\" from your teacher.")
                            .font(.system(.subheadline, design: .rounded))
                            .padding(.horizontal, paddingConstant)
                            .foregroundStyle(.secondary)
                            .padding(.bottom)
                    }

                    ForEach(teacherManager.teachers) { teacher in
#if os(visionOS)
                        Button {
                            openWindow(value: teacher)
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
                                }
                                
                                Spacer()
                            }
                            .frame(height: 110, alignment: .leading)
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle)
                        .padding(.horizontal, paddingConstant)
#else
                        Button {
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
#endif
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
