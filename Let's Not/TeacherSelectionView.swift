//
//  TeacherSelectionView.swift
//  Let's Not
//
//  Created by jiachen on 1/11/21.
//

import SwiftUI

struct TeacherSelectionView: View {
    
    @Binding var excuse: Excuse?
    @Binding var teacher: Teacher
    
    var body: some View {
        HStack {
            Text(teacher.name)
                .font(.system(.body, design: .rounded))
            Spacer()
            
            Button {
                if teacher.excuses.contains(excuse!) {
                    teacher.excuses.removeAll(where: { $0 == excuse })
                } else {
                    teacher.excuses.append(excuse!)
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

struct TeacherSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherSelectionView(excuse: .constant(Excuse(id: 0, title: "")), teacher: .constant(Teacher(name: "Mr Soon", subject: "potato")))
    }
}
