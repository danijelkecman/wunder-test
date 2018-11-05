//
//  WunderCoreDataStore.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import CoreData

final class WunderCoreDataStore {
  
  // MARK: - Managed object contexts
  private var processingQueue = OperationQueue()
  
  static let shared = WunderCoreDataStore()
  private init() {
    setupProcessingQueue()
  }
  
  private func setupProcessingQueue() {
    processingQueue.maxConcurrentOperationCount = 1
    processingQueue.qualityOfService = .userInitiated
  }
  
  var errorHandler: (Error) -> Void = {_ in }
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "WunderDataModel")
    container.loadPersistentStores(completionHandler: { [weak self] (storeDescription, error) in
      if let error = error {
        self?.errorHandler(error)
      }
    })
    return container
  }()
  
  lazy var viewContext: NSManagedObjectContext = {
    return self.persistentContainer.viewContext
  }()
  
  lazy var backgroundContext: NSManagedObjectContext = {
    return self.persistentContainer.newBackgroundContext()
  }()
  
  func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
    self.viewContext.perform {
      block(self.viewContext)
    }
  }
  
  func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
    self.persistentContainer.performBackgroundTask(block)
  }
  
  deinit {
    persistentContainer.performBackgroundTask() { context in
      do {
        try context.save()
      } catch {
        fatalError("Error saving context on WunderCoreDataStore deinit")
      }
    }
  }
}


