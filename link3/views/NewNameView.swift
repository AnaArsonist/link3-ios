//
//  NewNameView.swift
//  link3
//
//  Created by Ana Howard on 24/07/2023.
//

import SwiftUI

struct NewNameView: View {
    @State private var search = ""
    @Environment (\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack{
            Text("Your Web3 Username")
                .font(Font.custom("SatoshiVariable-Bold_Bold", size: 24))
                .foregroundStyle(Color("AccentColor"))
                .multilineTextAlignment(.center)
            TextField("", text: $search)
                .multilineTextAlignment(.center)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .disableAutocorrection(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
                .fontWeight(.bold)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(colorScheme == .dark ? Color("AccentColor") : Color(Color("AccentColor")))
                .frame(maxWidth: .infinity))
        }
        .padding(.horizontal, 40)

        }
}


#Preview {
    NewNameView()
}
