//
//  ContentView.swift
//  MemTest18
//
//  Created by Jeff Hokit on 7/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection:CoreFolder?

    var body: some View {
        NavigationSplitView {
            FolderView(selection: $selection)
        } detail: {
            if let selection{
                ItemListView(folder:selection)
            }
        }
    }


}
