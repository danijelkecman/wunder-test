//
//  PlacemarksListInteractor.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/6/18.
//  Copyright (c) 2018 Danijel Kecman. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class PlacemarksListInteractor {
  private let _placemarksService = PlacemarkDataService(placemarkPersistence: WunderCoreDataStore.shared)
}

// MARK: - Extensions -

extension PlacemarksListInteractor: PlacemarksListInteractorInterface {
  func getPlacemarks(completion: @escaping ([Placemark]) -> Void) {
    _placemarksService.fetchPlacemarks { (placemarks) in
      completion(placemarks)
    }
  }
}
