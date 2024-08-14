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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var cdFolder: FetchedResults<CoreFolder>

//    @Environment(\.modelContext) private var modelContext
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        Text("\(cdItems.count) total items")
        List(selection:$selection){
            ForEach(cdFolder, id:\.self) { folder in
                HStack{
                    Label(folder.name ?? "unknown",systemImage:"folder")
                    Spacer()
                    Text("\(folder.items?.count ?? 0)").foregroundColor(.secondary).monospacedDigit()
                }
            }
        }
        .navigationTitle("Folders")
        .toolbar {
            NewFolderToolbarItem(placement: .primaryAction)
            PopulateToolbarItem(placement: .automatic)
        }
    }
    
    
   func createFolder(named:String)->CoreFolder {
       let folder = CoreFolder(context: viewContext)
       folder.name = named
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
                       newItem.timestamp = Date()
                       let image = UIImage(named: "image\(Int.random(in: 1...3))")!
                       newItem.image = image.jpegData(compressionQuality: 1.0)
                       newItem.thumbnail = image.preparingThumbnail(of: CGSize(width: 500, height: 500))?.jpegData(compressionQuality: 1.0)
                       newFolder.addToItems(newItem)
                   }
                }

            })
            {
                Text("Add 40 Pix")
            }
        }
    }

    
}

