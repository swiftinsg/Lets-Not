//
//  MyExcuses.swift
//  Let's Not
//
//  Created by jiachen on 31/10/21.
//

import SwiftUI

struct MyExcusesView: View {
    
    @State var isExcusePresented = false
    @State var selectedExcuse: Excuse?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("👤 By me")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding(.horizontal)
                            .padding(.top)
                        Text("Excuses created by you.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                            .padding(.top, 0.5)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Excuse.sample) { excuse in
                                    Button {
                                        selectedExcuse = excuse
                                        isExcusePresented = true
                                    } label: {
                                        HStack(alignment: .bottom) {
                                            VStack(alignment: .leading) {
                                                Text(excuse.title)
                                                    .font(.title)
                                                    .fontWeight(.semibold)
                                                    .lineLimit(3)
                                                    .multilineTextAlignment(.leading)
                                                    .foregroundColor(.white)
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                            
                                            Image(systemName: "heart.fill")
                                                .foregroundColor(.white)
                                                .font(.system(size: 25))
                                        }
                                        .padding()
                                        .frame(width: 300, height: 170, alignment: .leading)
                                        .background(Color.accentColor)
                                        .cornerRadius(15)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Divider()
                            .padding()
                        
                        HStack {
                            Text("🧑‍🏫 Teachers")
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "plus")
                            }
                            .padding(.trailing)
                        }
                        
                        Text("Assign excuses to teachers to ensure you never repeat them. There's nothing worse than hearing \"You said that to me last week\" from your teacher.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                            .padding(.top, 0.5)
                        
                        VStack {
                            
                            var teachers = [Teacher(name: "Mr Potato", subject: "potato studies"), Teacher(name: "Mr Soon", subject: "Swift"), Teacher(name: "Mr Yeo", subject: "Geography")]
                            ForEach(teachers) { teacher in
                                Button {
                                    // open teacher view
                                    
                                } label: {
                                    HStack(alignment: .bottom) {
                                        VStack(alignment: .leading) {
                                            Text(teacher.name)
                                                .fontWeight(.bold)
                                                .multilineTextAlignment(.leading)
                                                .font(.title)
                                                .lineLimit(1)
                                                .foregroundColor(Color(UIColor.label))
                                            
                                            Text(teacher.subject)
                                                .font(.headline)
                                                .foregroundColor(Color(UIColor.label))
                                            
                                            Spacer()
                                            
                                            Text("\(teacher.excuses.count) excuses")
                                                .font(.caption)
                                                .foregroundColor(.accentColor)
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .frame(height: 110, alignment: .leading)
                                    .background(Color(UIColor.systemGray6).opacity(0.7))
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
            .navigationTitle("My Excuses")
            .sheet(isPresented: $isExcusePresented) {
                ExcuseDetailView(excuse: $selectedExcuse)
            }
        }
    }
}

struct MyExcuses_Previews: PreviewProvider {
    static var previews: some View {
        MyExcusesView()
    }
}
