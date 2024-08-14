//
//  MemTest18App.swift
//  MemTest18
//
//  Created by Jeff Hokit on 7/27/24.
//

import SwiftUI

@main
struct MemTest18App: App {
    
    let manager = CoreDataManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
