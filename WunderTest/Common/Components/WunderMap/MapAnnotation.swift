//
//  MapAnnotation.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/12/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Foundation
import CoreLocation

class MapAnnotation: NSObject {
  
  // MARK: - Properties
  let vin: String
  let coordinate: CLLocationCoordinate2D
  let type: MapAnnotationType
  let imageName: String?
  let imageURL: URL?
  let imageIdentifier: String
  
  // MARK: - Methods
  init(vin: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, type: MapAnnotationType, imageName: String) {
    self.vin = vin
    self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    self.type = type
    self.imageName = imageName
    self.imageURL = nil
    self.imageIdentifier = imageName
  }
  
  init(vin: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, type: MapAnnotationType, imageURL: URL) {
    self.vin = vin
    self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    self.type = type
    self.imageName = nil
    self.imageURL = imageURL
    self.imageIdentifier = imageURL.absoluteString
  }
}

extension MapAnnotation {
  
  override var hash: Int {
    return vin.hash ^ type.rawValue.hash
  }
  
  override func isEqual(_ object: Any?) -> Bool {
    guard let object = object as? MapAnnotation else {
      return false
    }
    
    return vin == object.vin && type == object.type
  }
}
