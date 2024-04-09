//
//  ExploreView.swift
//  Let's Not
//
//  Created by jiachen on 31/10/21.
//

import SwiftUI

#if os(visionOS)
let paddingConstant = 32.0
#else
let paddingConstant = 16.0
#endif

struct ExploreView: View {
    
    @ObservedObject var teacherManager: TeacherManager
    
    @State var recommendedExcuses = Excuse.sample
    @State var allExcuses = Excuse.all.shuffled()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("🚀 Recommended")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.primary)
                            .padding(.horizontal, paddingConstant)
                            .padding(.top)
                        Text("Browse through recommended excuses from our machine learning model.")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, paddingConstant)
                            .padding(.top, 0.5)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(recommendedExcuses) { excuse in
                                    ExcuseCardButton(teacherManager: teacherManager, excuse: excuse)
                                        .frame(width: 300, height: 170, alignment: .leading)
                                }
                            }
                            .padding(.horizontal, paddingConstant)
                        }
                        
                        Divider()
                            .padding(.vertical)
                            .padding(.horizontal, paddingConstant)
                        
                        Text("🗂 Browse")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.primary)
                            .padding(.horizontal, paddingConstant)
                        
                        Text("Browse through over a hundred AI generated excuses.")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, paddingConstant)
                            .padding(.top, 0.5)
                        
#if os(visionOS)
                        LazyVGrid(columns: [.init(.adaptive(minimum: 300))]) {
                            ForEach(allExcuses) { excuse in
                                ExcuseCardButton(teacherManager: teacherManager, excuse: excuse)
                                    .frame(height: 170)
                            }
                        }
                        .padding([.horizontal, .bottom], paddingConstant)
#else
                        VStack {
                            ForEach(allExcuses) { excuse in
                                ExcuseCardButton(teacherManager: teacherManager, excuse: excuse)
                                    .padding(.horizontal, paddingConstant)
                                    .frame(height: 170)
                            }
                        }
                        .padding(.bottom)
#endif
                    }
                }
            }
            .frame(alignment: .leading)
            .navigationTitle(Text("Explore"))
            .toolbar {
                Button {
                    recommendedExcuses = Excuse.sample
                    allExcuses = Excuse.all.shuffled()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(teacherManager: TeacherManager())
    }
}
