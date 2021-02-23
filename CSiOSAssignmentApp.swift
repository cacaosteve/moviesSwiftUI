//
//  CS_iOS_AssignmentApp.swift
//  CS_iOS_Assignment
//
//  Created by steve on 1/3/21.
//

import SwiftUI

@main
struct CSiOSAssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.backgroundLead)
                .ignoresSafeArea()
        }
    }
}
