//
//  CoreDataManager.swift
//  MemTest18
//
//  Created by Jeff Hokit on 8/11/24.
//

import Foundation
import CoreData

final class CoreDataManager {
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        let container = NSPersistentContainer(name: "Model")
        
        if let description = container.persistentStoreDescriptions.first {
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            description.url = URL.applicationSupportDirectory.appending(path: "default.store")
            description.shouldMigrateStoreAutomatically = true
            description.shouldInferMappingModelAutomatically = true
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        self.container = container
    }
}
