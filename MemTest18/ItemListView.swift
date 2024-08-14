//
//  ItemListView.swift
//  MemTest18
//
//  Created by Jeff Hokit on 7/27/24.
//

import SwiftUI

struct ItemListView: View {
    var folder:CoreFolder?
    @FetchRequest private var items: FetchedResults<CoreItem>

    init(folder: CoreFolder){
        self.folder = folder
        self._items = FetchRequest<CoreItem>(sortDescriptors: [], 
                                             predicate: NSPredicate(format: "folder.uuid = %@", folder.uuid ?? ""))

    }
    var body: some View {
        NavigationStack{
            List {
                    ForEach(items) { item in
                        NavigationLink {
                            VStack{
                                Image(uiImage: UIImage(data:(item.image?.imageData!)!)!)
                                    .resizable()
                                    .scaledToFit()
                                Text("Item at \(item.timestamp!, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            }
                        } label: {
                            HStack{
                                Image(uiImage: UIImage(data:(item.thumbnail?.imageData!)!)!)
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
            .navigationTitle(folder?.name ?? "No Selection")
        }
    }
    
    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date(), image:UIImage(named: "image\(Int.random(in: 1...3))")!)
//            modelContext.insert(newItem)
//            folder?.items?.append(newItem)
//        }
    }
    
    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                if let items = folder?.items{
//                    modelContext.delete(items[index])
//                }
//            }
//        }
    }
}


