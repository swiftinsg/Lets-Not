//
//  TeacherDetailView.swift
//  Let's Not
//
//  Created by jiachen on 1/11/21.
//

import SwiftUI

struct TeacherDetailView: View {
    
    @ObservedObject var teacherManager: TeacherManager
    
    @Binding var teacher: Teacher?
    @State var isExcusePresented = false
    @State var selectedExcuse: Excuse?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(teacher!.name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(.accentColor)
                .padding([.horizontal, .top])
            
            Text(teacher!.subject)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.accentColor)
                .padding([.horizontal, .bottom])
            
            ScrollView(.vertical) {
                ForEach(teacher!.excuses) { excuse in
                    Button {
                        selectedExcuse = excuse
                        isExcusePresented = true
                    } label: {
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading) {
                                Text(excuse.title)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                    .font(.system(.title, design: .rounded))
                                    .lineLimit(3)
                                    .foregroundColor(Color(.label))
                                
                                Spacer()
                                
                                let numberOfTeachers = excuse.usedOn(teachers: teacherManager.teachers).count
                                Text("Used on \(numberOfTeachers) \(numberOfTeachers == 1 ? "teacher" : "teachers")")
                                    .multilineTextAlignment(.leading)
                                    .font(.system(.headline, design: .rounded))
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .frame(height: 170, alignment: .leading)
                        .background(Color(UIColor.systemGray6).opacity(0.7))
                        .cornerRadius(15)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .sheet(isPresented: $isExcusePresented) {
            ExcuseDetailView(excuse: $selectedExcuse, teacherManager: teacherManager)
        }
    }
}

struct TeacherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherDetailView(teacherManager: TeacherManager(), teacher: .constant(Teacher(name: "Mr Soon", subject: "Swift")))
    }
}
