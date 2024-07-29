//
//  ContentView.swift
//  MemTest18
//
//  Created by Jeff Hokit on 7/27/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var selection:Folder?

    var body: some View {
        NavigationSplitView {
            FolderView(selection: $selection)
        } detail: {
            ItemListView(folder:selection)
        }
    }


}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
