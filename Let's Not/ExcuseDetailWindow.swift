//
//  ExcuseDetailWindow.swift
//  Let's Not
//
//  Created by Jia Chen Yee on 9/4/24.
//

import SwiftUI

#if os(visionOS)
struct ExcuseDetailWindow: View {
    
    var excuse: Excuse
    @ObservedObject var teacherManager: TeacherManager
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        VStack(spacing: -32) {
            Text(excuse.title)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 32))
                .padding([.top, .horizontal])
                .zIndex(1)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if teacherManager.teachers.isEmpty {
                        Text("Think this excuse would work well with a particular teacher?")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.primary)
                            .padding(.horizontal)
                            .padding(.top)
                        Text("Head over to the second tab on the main window to add teacher(s) to the app.")
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 32)
                
                ForEach(teacherManager.teachers) { teacher in
                    HStack {
                        Button {
                            openWindow(value: teacher)
                        } label: {
                            Text(teacher.name)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color(.label))
                            Spacer()
                        }
                        
                        Button {
                            let index = teacherManager.teachers.firstIndex(where: { $0 == teacher })!
                            
                            withAnimation {
                                if teacher.excuses.contains(excuse) {
                                    teacherManager.teachers[index].excuses.removeAll(where: { $0 == excuse })
                                } else {
                                    teacherManager.teachers[index].excuses.append(excuse)
                                }
                            }
                        } label: {
                            Image(systemName: teacher.excuses.contains(excuse) ? "checkmark" : "square")
                                .contentTransition(.symbolEffect(.replace))
                                .imageScale(.large)
                                .padding(2.5)
                        }
                        .foregroundStyle(Color.accentColor)
                    }
                    .padding([.horizontal, .top])
                }
            }
        }
    }
}
#endif
