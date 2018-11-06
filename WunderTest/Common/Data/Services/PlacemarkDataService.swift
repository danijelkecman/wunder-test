//
//  PlacemarkDataService.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Foundation

class PlacemarkDataService {
  var placemarkPersistence: PlacemarkPersistenceProtocol
  
  init(placemarkPersistence: PlacemarkPersistenceProtocol) {
    self.placemarkPersistence = placemarkPersistence
  }
  
  func fetchPlacemark(_ vin: String, completionHandler: @escaping (_ Placemark: Placemark?) -> Void) {
    placemarkPersistence.fetchPlacemark(vin) { (placemark: () throws -> Placemark?) -> Void in
      do {
        let placemark = try placemark()
        completionHandler(placemark)
      } catch {
        completionHandler(nil)
      }
    }
  }
  
  func createPlacemark(_ placemark: Placemark, completionHandler: @escaping () -> Void) {
    placemarkPersistence.createPlacemark(placemark) { (done: () throws -> Void) -> Void in
      do {
        try done()
        completionHandler()
      } catch {
        completionHandler()
      }
    }
    
  }
  
  func fetchPlacemarks(_ completionHandler: @escaping (_ placemarks: [Placemark]) -> Void) {
    placemarkPersistence.fetchPlacemarks { (placemarks: () throws -> [Placemark]) -> Void in
      do {
        let placemarks = try placemarks()
        completionHandler(placemarks)
      } catch {
        completionHandler([])
      }
    }
  }
  
  func deletePlacemarks(completionHandler: @escaping () -> Void) {
    placemarkPersistence.deletePlacemarks { (done: () throws -> Void) -> Void in
      do {
        try done()
        completionHandler()
      } catch {
        debugPrint(error)
        completionHandler()
      }
    }
  }
}
