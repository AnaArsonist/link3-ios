//
//  link3App.swift
//  link3
//
//  Created by Ana Howard on 22/07/2023.
//

import SwiftUI

@main

struct link3App: App {
    
    init(){
        for family in UIFont.familyNames {
             print(family)

             for names in UIFont.fontNames(forFamilyName: family){
             print("== \(names)")
             }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabNav()
        }
    }
}
