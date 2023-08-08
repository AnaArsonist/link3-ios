//
//  OnboardingView.swift
//  link3
//
//  Created by Ana Howard on 22/07/2023.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .center,
        @ViewBuilder placeholder : () -> Content ) -> some View
    {
        ZStack {
            placeholder().opacity(shouldShow ? 0.6 : 0)
            self
        }
    }
}


class SearchData: ObservableObject {
    @Published var ensName: String = ""

    init(ensName: String = "") {
        self.ensName = ensName
    }
    
    var isValidInput: Bool {
        return ensName.contains(".") && ensName.count >= 6 && !ensName.hasSuffix(".")
    }
}

struct OnboardingView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var search: SearchData = SearchData()
    
    @State private var showingAlert = false
    @State private var showingData = false

    var body: some View {
        NavigationView {
            VStack(spacing: 16.0) {
                HStack {
                    Image(systemName: "binoculars.fill").font(.system(size: 16.0))
                        .foregroundColor(colorScheme == .dark ? Color("AccentColor") : Color("AccentColor"))
                    TextField("", text: $search.ensName)
                        .multilineTextAlignment(.center)
                        .placeholder(when: search.ensName.isEmpty) {
                            Text("Search ENS Name").foregroundColor(Color("AccentColor"))
                                .fontWeight(.medium)
                        }
                }
                .autocorrectionDisabled()
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(colorScheme == .dark ? Color("AccentColor") : Color("AccentColor")))
                Button(action: {
                    if !search.isValidInput {
                        showingAlert = true
                    } else {
                        showingData = true
                    }
                }) {
                    HStack {
                        Image(systemName: "magnifyingglass").font(.system(size: 16.0))
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .padding(.leading, 20)
                        Text("Lookup").font(.system(size: 16.0))
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .padding(.all, 20)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, 20)
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(colorScheme == .dark ? Color("AccentColor") : Color("AccentColor"))
                    .cornerRadius(12)
                }.alert("Please enter a valid ENS name", isPresented: $showingAlert){
                    Button("OK", role: .cancel) { }
                }
            }
            .padding(.horizontal, 40)
        }.sheet(isPresented: $showingData) {
            DataView().environmentObject(search)
        }
    }
}

//#Preview {
//    TabNav()
//}
