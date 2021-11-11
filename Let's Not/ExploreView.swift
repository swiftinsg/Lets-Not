//
//  ExploreView.swift
//  Let's Not
//
//  Created by jiachen on 31/10/21.
//

import SwiftUI

struct ExploreView: View {
    
    @State var isExcusePresented = false
    @State var selectedExcuse: Excuse?
    @ObservedObject var teacherManager: TeacherManager
    
    @State var recommendedExcuses = Excuse.sample
    @State var allExcuses = Excuse.all.shuffled()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("🚀 Recommended")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.primary)
                            .padding(.horizontal)
                            .padding(.top)
                        Text("Browse through recommended excuses from our machine learning model.")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                            .padding(.top, 0.5)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(recommendedExcuses) { excuse in
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
                                                .font(.system(size: 25, weight: .regular, design: .rounded))
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
                        
                        Text("🗂 Browse")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.primary)
                            .padding(.horizontal)
                        
                        Text("Browse through over a hundred AI generated excuses.")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                            .padding(.top, 0.5)
                        
                        VStack {
                            ForEach(allExcuses) { excuse in
                                Button {
                                    selectedExcuse = excuse
                                    isExcusePresented = true
                                } label: {
                                    let isUsed = !excuse.usedOn(teachers: teacherManager.teachers).isEmpty
                                    
                                    HStack(alignment: .bottom) {
                                        VStack(alignment: .leading) {
                                            Text(excuse.title)
                                                .fontWeight(.semibold)
                                                .multilineTextAlignment(.leading)
                                                .font(.system(.title, design: .rounded))
                                                .lineLimit(3)
                                                .foregroundColor(isUsed ? .white : Color(.label))
                                            
                                            Spacer()
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: isUsed ? "heart.fill" : "heart")
                                            .foregroundColor(isUsed ? .white : .accentColor)
                                            .font(.system(size: 25, weight: .regular, design: .rounded))
                                    }
                                    .padding()
                                    .frame(height: 170, alignment: .leading)
                                    .background(isUsed ? Color.accentColor : Color(.systemGray6).opacity(0.7))
                                    .cornerRadius(15)
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.bottom)
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
            .sheet(isPresented: $isExcusePresented) {
                ExcuseDetailView(excuse: $selectedExcuse, teacherManager: teacherManager)
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(teacherManager: TeacherManager())
    }
}
