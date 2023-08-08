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
                    Image("List")
                    Text("Your Names")
                        .font(Font.custom("SatoshiVariable-Bold_Light", size: 12))
                }
            OnboardingView()
                .tabItem {
                    Image("MagnifyingGlassSimple")
                    Text("Search")
                        .font(Font.custom("SatoshiVariable-Bold_Light", size: 12))
                }
            NewNameView()
                .tabItem {
                    Image("PlusCircle")
                        Text("New Name")
                        .font(Font.custom("SatoshiVariable-Bold_Light", size: 12))

                }
            OnboardingView()
                .tabItem {
                    Image("Marker")
                    Text("Find Bitches")
                        .font(Font.custom("SatoshiVariable-Bold_Light", size: 12))

                }
            RecordItem(recordKey: "foo", recordValue: "bar")
                .tabItem {
                    Image("Cog")
                    Text("Preferences")
                        .font(Font.custom("SatoshiVariable-Bold_Bold", size: 12))
                }
        }
        .font(Font.custom("SatoshiVariable-Bold_Light", size: 12))
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    TabNav()
}
