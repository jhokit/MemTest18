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

    var body: some View {
        NavigationSplitView {
            List {
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
            .navigationTitle("\(items.count) Items") // SET A BREAKPOINT HERE TO SEE IOS 18 BUG WHERE CALLING .COUNT LOADS ALL ITEMS
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), image:UIImage(named: "image\(Int.random(in: 1...3))")!)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
