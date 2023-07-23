//
//  RecordItem.swift
//  link3
//
//  Created by Ana Howard on 23/07/2023.
//

import SwiftUI
    
struct recordInfo {
    var image: String
    var friendlyName: String
    var bg: Color
    
}

var recordData: [String: recordInfo] = [
    "com.twitter" : recordInfo(image: "Twitter", friendlyName: "Twitter", bg:.cyan),
    "com.instagram" : recordInfo(image: "Instagram", friendlyName: "Instagram", bg:.pink),
    "com.discord" : recordInfo(image: "Discord", friendlyName: "Discord", bg: .indigo),
    "org.telegram" : recordInfo(image: "Telegram", friendlyName: "Telegram", bg: .blue),
    "com.github" : recordInfo(image: "Github", friendlyName: "GitHub", bg: .gray),
]


struct RecordItem: View {
    var recordKey: String
    var recordValue: String
    
    var body: some View {
        
        HStack{
            if let style = recordData[recordKey] {
                // good
                HStack{
                    HStack {
                        Image(style.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text(style.friendlyName)
                            .foregroundStyle(.white)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    Text(recordValue)
                        .foregroundStyle(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }.padding(.vertical, 20)
            } else {
                // boring generic style
                HStack{
                    HStack {
                        Image(systemName: "list.bullet")
                            
                        Text(recordKey)
                            .fontWeight(.bold)
                    }
                    .padding(.leading, 20)
                    Text(recordValue)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding(.trailing, 20)
                }
                .frame(width: 300, height:60)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.black))
                    )
            }
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: 300)
        .fixedSize(horizontal: false, vertical: true)
        .background(recordData[recordKey] != nil ? recordData[recordKey]!.bg : .white)
        .cornerRadius(20)
    }
}
