//
//  FolderView.swift
//  MemTest18
//
//  Created by Jeff Hokit on 7/27/24.
//

import SwiftUI
import SwiftData

struct FolderView: View {
    
    @Query private var items: [Item]
    @Query(sort: \Folder.name) private var folders: [Folder]
    @Binding var selection:Folder?
    @State private var isShowingNewFolderAlert = false
    @State private var newFolderName = ""
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        Text("\(items.count) total items")
        List(selection:$selection){
            ForEach(folders, id:\.self) { folder in
                HStack{
                    Label(folder.name,systemImage:"folder")
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
        .alert("New Folder", isPresented: $isShowingNewFolderAlert) {
            TextField("Name", text: $newFolderName)
            
            Button("Save") {createFolder()}
            // .disabled(newFolderName.isEmpty) // a bug in Button with disabled causes the action to not be called if the initial state is true
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Enter a name for the new folder.")
        }
        

    }
    
    
    func createFolder() {
        let folder = Folder(name: newFolderName)
        modelContext.insert(folder)
        newFolderName = ""
    }
    
   func createFolder(named:String)->Folder {
        let folder = Folder(name: named)
        modelContext.insert(folder)
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
                   for _ in 1...10 {
                       let newItem = Item(timestamp: Date(), image:UIImage(named: "image\(Int.random(in: 1...3))")!)
                       modelContext.insert(newItem)
                       newFolder.items?.append(newItem)
                   }
                }

            })
            {
                Text("Populate")
            }
        }
    }

    
}

