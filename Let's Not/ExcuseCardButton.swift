//
//  ExcuseCardButton.swift
//  Let's Not
//
//  Created by Jia Chen Yee on 9/4/24.
//

import SwiftUI

struct ExcuseCardButton: View {
    
    @ObservedObject var teacherManager: TeacherManager
    
    @State private var isExcusePresented = false
    @State private var selectedExcuse: Excuse?
    
    @Environment(\.openWindow) var openWindow

    var excuse: Excuse
    
    var body: some View {
        Group {
#if os(visionOS)
            Button {
                openWindow(value: excuse)
            } label: {
                let teachers = excuse.usedOn(teachers: teacherManager.teachers)
                
                VStack {
                    Text(excuse.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .font(.system(.title, design: .rounded))
                        .lineLimit(3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    Spacer()
                    
                    if !teachers.isEmpty {
                        Text("Used on ^[\(teachers.count) teacher](inflect: true)")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .buttonBorderShape(.roundedRectangle)
#else
            Button {
                selectedExcuse = excuse
                isExcusePresented = true
            } label: {
                let teachers = excuse.usedOn(teachers: teacherManager.teachers)
                
                VStack {
                    VStack(alignment: .leading) {
                        Text(excuse.title)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .font(.system(.title, design: .rounded))
                            .lineLimit(3)
                            .foregroundColor(teachers.count > 0 ? .white : Color(.label))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                    }
                    
                    if !teachers.isEmpty {
                        Text("Used on ^[\(teachers.count) teacher](inflect: true)")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundStyle(.white)
                    }
                }
                .padding()
                .background(teachers.count > 0 ? Color.accentColor : Color(.systemGray6).opacity(0.7))
                .cornerRadius(15)
            }
#endif
        }
        .sheet(isPresented: $isExcusePresented) {
            ExcuseDetailView(excuse: $selectedExcuse, teacherManager: teacherManager)
        }
    }
}
