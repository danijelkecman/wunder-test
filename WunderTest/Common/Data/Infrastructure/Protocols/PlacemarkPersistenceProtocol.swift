//
//  PlacemarkPersistenceProtocol.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Foundation

protocol PlacemarkPersistenceProtocol {
  func fetchPlacemarks(completionHandler: @escaping (_ user: () throws -> [Placemark]) -> Void)
  func fetchPlacemark(_ placemarkVin: String, completionHandler: @escaping (_ placemark: () throws -> Placemark?) -> Void)
  func createPlacemark(_ placemark: Placemark, completionHandler: @escaping (_ done: () throws -> Void) -> Void)
  func createPlacemarks(_ placemarks: [Placemark], completionHandler: @escaping (_ done: () throws -> Void) -> Void)
  func deletePlacemarks(completionHandler: @escaping (_ done: () throws -> Void) -> Void)
}

enum WunderStoreError: Equatable, Error {
  case cannotFetch(String)
  case cannotCreate(String)
  case cannotUpdate(String)
  case cannotDelete(String)
}

func == (lhs: WunderStoreError, rhs: WunderStoreError) -> Bool {
  switch (lhs, rhs) {
  case (.cannotFetch(let a), .cannotFetch(let b)) where a == b: return true
  case (.cannotCreate(let a), .cannotCreate(let b)) where a == b: return true
  case (.cannotUpdate(let a), .cannotUpdate(let b)) where a == b: return true
  case (.cannotDelete(let a), .cannotDelete(let b)) where a == b: return true
  default: return false
  }
}
