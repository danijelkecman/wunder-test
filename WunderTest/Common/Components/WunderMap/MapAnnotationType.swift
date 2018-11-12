//
//  MapAnnotationType.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/12/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Foundation

enum MapAnnotationType: String {
  
  case personLocation
  case placemarkLocation
  
  static func makePersonLocationAnnotation(`for` placemark: Placemark) -> MapAnnotation {
    return MapAnnotation(vin: placemark.vin,
                         latitude: placemark.coordinates[0],
                         longitude: placemark.coordinates[1],
                         type: .personLocation,
                         imageName: "MarkerPersonLocation")
  }
  
  static func makePlacemarkLocationAnnotation(`for` placemark: Placemark?) -> MapAnnotation? {
    guard let placemark = placemark else { return nil }
    return MapAnnotation(vin: placemark.vin,
                         latitude: placemark.coordinates[0],
                         longitude: placemark.coordinates[1],
                         type: .placemarkLocation,
                         imageName: "MapPlacemarkLocation")
  }
}
