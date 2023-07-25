//
//  TabView.swift
//  link3
//
//  Created by Ana Howard on 24/07/2023.
//

import SwiftUI

struct TabNav: View {
    var body: some View {
        TabView {
            EnsGallery()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Your ENS Names")
                }
            
            OnboardingView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            NewNameView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("New Name")
                }
            OnboardingView()
                .tabItem {
                    Image(systemName: "cat")
                    Text("Cat")
                }
            RecordItem(recordKey: "foo", recordValue: "bar")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Preferences")
                }
        }
        .tabViewStyle(DefaultTabViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

//#Preview {
//    TabNav()
//}
