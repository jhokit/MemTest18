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
    @Environment(\.managedObjectContext) private var viewContext

    init(folder: CoreFolder){
        self.folder = folder
        self._items = FetchRequest<CoreItem>(sortDescriptors: [SortDescriptor(\.timestamp, order: .reverse)], 
                                             predicate: NSPredicate(format: "folder.uuid = %@", folder.uuid ?? ""))

    }
    var body: some View {
        NavigationStack{
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
            .navigationTitle(folder?.name ?? "No Selection")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = CoreItem(context:viewContext)
            newItem.uuid = UUID().uuidString
            newItem.timestamp = Date()
            let image = UIImage(named: "image\(Int.random(in: 1...3))")!
            newItem.image = image.jpegData(compressionQuality: 1.0)
            newItem.thumbnail = image.preparingThumbnail(of: CGSize(width: 500, height: 500))?.jpegData(compressionQuality: 1.0)
            newItem.folder = folder
            folder?.addToItems(newItem)
            do {
                try viewContext.save()
            } catch {
                print("Error saving item")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let item = items[index]
                viewContext.delete(item)
            }
        }
        do {
            try viewContext.save()
        } catch {
            print("Error saving folder")
        }
    }
}


