//
//  ItemListView.swift
//  MemTest18
//
//  Created by Jeff Hokit on 7/27/24.
//

import SwiftUI
import SwiftData

struct ItemListView: View {
    @Environment(\.modelContext) private var modelContext
    var folder:Folder?

    var body: some View {
        NavigationStack{
            List {
                if let items = folder?.items{
                    ForEach(items) { item in
                        NavigationLink {
                            VStack{
                                Image(uiImage: UIImage(data:item.image!)!)
                                    .resizable()
                                    .scaledToFit()
                                Text("Item at \(item.timestamp!, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            }
                        } label: {
                            HStack{
                                Image(uiImage: UIImage(data:item.thumbnail!)!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text("Item at \(item.timestamp!, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle(folder?.name ?? "unknown")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), image:UIImage(named: "image\(Int.random(in: 1...3))")!)
            modelContext.insert(newItem)
            folder?.items?.append(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                if let items = folder?.items{
                    modelContext.delete(items[index])
                }
            }
        }
    }
}


