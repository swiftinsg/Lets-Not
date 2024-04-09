//
//  ContentView.swift
//  Let's Not
//
//  Created by jiachen on 31/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var teacherManager: TeacherManager
    @ObservedObject var excuseManager = ExcuseManager()
    
    init(teacherManager: ObservedObject<TeacherManager>) {
        self._teacherManager = teacherManager
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.preferredFont(forTextStyle: .largeTitle).rounded(weight: .bold)]
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.preferredFont(forTextStyle: .headline).rounded(weight: .semibold)]
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont.preferredFont(forTextStyle: .caption2).rounded(weight: .medium)], for: [])
//            .titleTextAttributes = [.font: UIFont.preferredFont(forTextStyle: .headline).rounded(weight: .semibold)]
    }
    var body: some View {
        TabView {
            ExploreView(teacherManager: teacherManager)
                .tabItem {
                    Label("Explore", systemImage: "paperplane")
                        .font(.system(.headline, design: .rounded))
                }
            
            MyExcusesView(teacherManager: teacherManager, excuseManager: excuseManager)
                .tabItem {
                    Label("My Excuses", systemImage: "bubble.left.and.exclamationmark.bubble.right.fill")
                        .font(.system(.headline, design: .rounded))
                }
        }
    }
}
