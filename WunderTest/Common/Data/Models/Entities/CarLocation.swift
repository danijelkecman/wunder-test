//
//  CarLocation.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/12/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import CoreLocation
import MapKit

@objc class CarLocation: NSObject {
  var title: String?
  var subtitle: String?
  var coordinate: CLLocationCoordinate2D
  
  init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate
  }
}

extension CarLocation: MKAnnotation { }
