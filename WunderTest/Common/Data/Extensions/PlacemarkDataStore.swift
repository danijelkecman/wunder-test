//
//  PlacemarkDataStore.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import CoreData

extension WunderCoreDataStore: PlacemarkPersistenceProtocol {
  func fetchPlacemarks(completionHandler: @escaping (_ Placemark: () throws -> [Placemark]) -> Void) {
    WunderCoreDataStore.shared.backgroundContext.perform {
      do {
        let fetchRequest = NSFetchRequest<ManagedPlacemark>(entityName: "ManagedPlacemark")
        let results = try WunderCoreDataStore.shared.backgroundContext.fetch(fetchRequest)
        let placemarks = results.map { $0.toPlacemark() }
        
        completionHandler { return placemarks }
      } catch {
        completionHandler { throw WunderStoreError.cannotFetch("Cannot fetch Placemarks") }
      }
    }
  }
  
  func fetchPlacemark(_ placemarkVin: String, completionHandler: @escaping (_ Placemark: () throws -> Placemark?) -> Void) {
    WunderCoreDataStore.shared.backgroundContext.perform {
      do {
        let fetchRequest = NSFetchRequest<ManagedPlacemark>(entityName: "ManagedPlacemark")
        fetchRequest.predicate = NSPredicate(format: "vin == %@", placemarkVin)
        let results = try WunderCoreDataStore.shared.backgroundContext.fetch(fetchRequest)
        if let placemark = results.first?.toPlacemark() {
          completionHandler { return placemark }
        } else {
          throw WunderStoreError.cannotFetch("Cannot fetch Placemark with id \(placemarkVin)")
        }
      } catch {
        debugPrint(error)
        completionHandler { throw WunderStoreError.cannotFetch("Cannot fetch Placemark with id \(placemarkVin)") }
      }
    }
  }
  
  func createPlacemark(_ placemark: Placemark, completionHandler: @escaping (_ done: () throws -> Void) -> Void) {
    WunderCoreDataStore.shared.backgroundContext.perform {
      do {
        let managedPlacemark = NSEntityDescription.insertNewObject(forEntityName: "ManagedPlacemark",
                                                                   into: WunderCoreDataStore.shared.backgroundContext) as! ManagedPlacemark
        
        managedPlacemark.address = placemark.address
        managedPlacemark.coordinates = placemark.coordinates
        managedPlacemark.engineType = placemark.engineType
        managedPlacemark.exterior = placemark.exterior
        managedPlacemark.fuel = placemark.fuel
        managedPlacemark.interior = placemark.interior
        managedPlacemark.name = placemark.name
        managedPlacemark.vin = placemark.vin
        
        try WunderCoreDataStore.shared.backgroundContext.save()
        completionHandler { return }
      } catch {
        debugPrint(error)
        completionHandler { throw WunderStoreError.cannotCreate("Cannot create placemark with id \(placemark.vin)") }
      }
    }
  }
  
  func createPlacemarks(_ placemarks: [Placemark], completionHandler: @escaping (_ done: () throws -> Void) -> Void) {
    WunderCoreDataStore.shared.backgroundContext.perform {
      do {
        for placemark in placemarks {
          let managedPlacemark = NSEntityDescription.insertNewObject(forEntityName: "ManagedPlacemark",
                                                                     into: WunderCoreDataStore.shared.backgroundContext) as! ManagedPlacemark
          
          managedPlacemark.address = placemark.address
          managedPlacemark.coordinates = placemark.coordinates
          managedPlacemark.engineType = placemark.engineType
          managedPlacemark.exterior = placemark.exterior
          managedPlacemark.fuel = placemark.fuel
          managedPlacemark.interior = placemark.interior
          managedPlacemark.name = placemark.name
          managedPlacemark.vin = placemark.vin
        }
        
        try WunderCoreDataStore.shared.backgroundContext.save()
        completionHandler { return }
      } catch {
        debugPrint(error)
        completionHandler { throw WunderStoreError.cannotCreate("Cannot create placemarks") }
      }
    }
  }
  
  func deletePlacemarks(completionHandler: @escaping (_ done: () throws -> Void) -> Void) {
    WunderCoreDataStore.shared.backgroundContext.perform {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedPlacemark")
      let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      
      do {
        try WunderCoreDataStore.shared.backgroundContext.execute(deleteRequest)
        try WunderCoreDataStore.shared.backgroundContext.save()
        completionHandler { return }
      } catch {
        completionHandler { throw WunderStoreError.cannotDelete("Cannot delete Placemarks") }
      }
    }
  }
}
