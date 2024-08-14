//
//  FolderView.swift
//  MemTest18
//
//  Created by Jeff Hokit on 7/27/24.
//

import SwiftUI

struct FolderView: View {
    
    @Binding var selection:CoreFolder?
    @State private var isShowingNewFolderAlert = false
    @State private var newFolderName = ""
    
    @FetchRequest(sortDescriptors: []) var cdItems: FetchedResults<CoreItem> // just to get the count
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var cdFolders: FetchedResults<CoreFolder>

    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        Text("\(cdItems.count) total items")
        List(selection:$selection){
            ForEach(cdFolders, id:\.self) { folder in
                HStack{
                    Label(folder.name ?? "unknown",systemImage:"folder")
                    Spacer()
                    Text("\(folder.items?.count ?? 0)").foregroundColor(.secondary).monospacedDigit()
                }
            }
            .onDelete(perform: { offsets in
                viewContext.delete(cdFolders[offsets.first ?? 0])
            })
        }
        .navigationTitle("Folders")
        .toolbar {
            NewFolderToolbarItem(placement: .primaryAction)
            PopulateToolbarItem(placement: .automatic)
        }
    }
    
    
   func createFolder(named:String)->CoreFolder {
       let folder = CoreFolder(context: viewContext)
       folder.uuid = UUID().uuidString
       folder.name = named
       do {
           try viewContext.save()
       } catch {
           print("Error saving folder")
       }
       return folder
    }
    
    
    @ToolbarContentBuilder private func NewFolderToolbarItem(placement:ToolbarItemPlacement) -> some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button(action: {isShowingNewFolderAlert.toggle()}) {
                Label("New Folder", systemImage: "folder.badge.plus")
            }
        }
    }

    @ToolbarContentBuilder private func PopulateToolbarItem(placement:ToolbarItemPlacement) -> some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button(action: {
                for _ in 1...2
                {
                   let newFolder = createFolder(named:"Test\(Int.random(in: 1...1000))")
                   for _ in 1...20 {
                       let newItem = CoreItem(context:viewContext)
                       newItem.uuid = UUID().uuidString
                       newItem.timestamp = Date()
                       let image = UIImage(named: "image\(Int.random(in: 1...3))")!
                       newItem.image = image.jpegData(compressionQuality: 1.0)
                       newItem.thumbnail = image.preparingThumbnail(of: CGSize(width: 500, height: 500))?.jpegData(compressionQuality: 1.0)
                       newItem.folder = newFolder
                       newFolder.addToItems(newItem)
                       do {
                           try viewContext.save()
                       } catch {
                           print("Error saving item")
                       }

                   }
                }

            })
            {
                Text("Add 40 Pix")
            }
        }
    }

    
}

